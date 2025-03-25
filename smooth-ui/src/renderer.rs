use std::{collections::BTreeMap, sync::Arc};

use futures::executor;

use egui_wgpu_backend::{RenderPass, ScreenDescriptor};

use crate::{chat_ui::ChatUI, ffi::ffi::BaseChatController, font_loader::load_font_data_by_name, input_output::{InputEvent, OutputState}};

pub struct Renderer {
    // wgpu
    device: wgpu::Device,
    queue: wgpu::Queue,
    surface: wgpu::Surface<'static>,
    config: wgpu::SurfaceConfiguration,

    // egui
    context: egui::Context,
    raw_input: egui::RawInput,
    egui_rpass: RenderPass,
}

impl Renderer {
    pub fn new(layer_ptr: *mut std::ffi::c_void, width: u32, height: u32, display_scale: f32) -> Self {
        // Setup wgpu
        let descriptor = wgpu::InstanceDescriptor {
            backends: wgpu::Backends::METAL,
            ..Default::default()
        };
        let instance = wgpu::Instance::new(descriptor);
        let surface = unsafe {
            instance.create_surface_unsafe(wgpu::SurfaceTargetUnsafe::CoreAnimationLayer(layer_ptr)).unwrap()
        };

        let adapter = executor::block_on(instance.request_adapter(&wgpu::RequestAdapterOptions {
            power_preference: wgpu::PowerPreference::HighPerformance,
            force_fallback_adapter: false,
            compatible_surface: Some(&surface),
        }))
        .expect("Failed to find an appropriate adapter");

        let (device, queue) = executor::block_on(adapter.request_device(&wgpu::DeviceDescriptor {
            required_features: wgpu::Features::MAPPABLE_PRIMARY_BUFFERS | wgpu::Features::TEXTURE_COMPRESSION_ASTC_HDR,
            ..Default::default()
        }, None))
        .expect("Failed to create device");

        let tex_format = wgpu::TextureFormat::Bgra8UnormSrgb;

        let mut config = surface.get_default_config(&adapter, width, height).expect("Failed to create config");
        config.format = tex_format;
        config.view_formats = vec![tex_format];

        surface.configure(&device, &config);

        // Setup egui
        let context = egui::Context::default();

        let display_font_data = load_font_data_by_name("SF Pro Text Medium");

        if let Ok(display_font_data) = display_font_data {

            let mut fonts = egui::FontDefinitions::default();

            let display_font_data = Arc::new(egui::FontData::from_owned(display_font_data));
            fonts.font_data.insert("SF-Pro-Text-Medium".to_owned(), display_font_data);

            let display_family = egui::FontFamily::Name("SF-Pro-Text".into());
            fonts.families.insert(display_family.clone(), vec!["SF-Pro-Text-Medium".to_owned()]);

            context.set_fonts(fonts);
            
            context.all_styles_mut(|style| {
                let text_styles: BTreeMap<_, _> = [
                    (egui::TextStyle::Heading, egui::FontId::new(11.0, display_family.clone())),
                    (egui::TextStyle::Body, egui::FontId::new(13.0, display_family.clone())),

                    (egui::TextStyle::Button, egui::FontId::new(14.0, display_family.clone())),
                    (egui::TextStyle::Small, egui::FontId::new(10.0, display_family.clone())),
                ].into();
                
                style.text_styles = text_styles;
            });
        }

        let raw_input = egui::RawInput {
            viewport_id: egui::ViewportId::ROOT,
            viewports: std::iter::once((egui::ViewportId::ROOT, egui::ViewportInfo {  
                native_pixels_per_point: Some(display_scale),
                focused: Some(true),
                ..Default::default() 
            })).collect(),
            predicted_dt: 1.0 / 120.0,
            focused: true,
            system_theme: None,
            max_texture_side: Some(wgpu::Limits::default().max_texture_dimension_2d as usize),
            ..Default::default()
        };
        let egui_rpass = RenderPass::new(&device, tex_format, 1);

        Self {
            device,
            queue,
            surface,
            config,
            context,
            raw_input,
            egui_rpass
        }
    }

    pub fn resize(&mut self, width: u32, height: u32) {
        let mut config = self.config.clone();
        config.width = width;
        config.height = height;
        self.surface.configure(&self.device, &config);

        self.config = config;
    }

    pub fn render(&mut self, time: f64, input_events: Vec<InputEvent>, controller: BaseChatController) -> OutputState {
        
        let device = &self.device;
        let queue = &self.queue;
        let surface = &self.surface;

        let ctx = &self.context;
        let egui_rpass = &mut self.egui_rpass;
        
        self.raw_input.time = Some(time);

        let rect = egui::Rect::from_min_size(
            egui::Pos2::ZERO, 
            egui::vec2(
                self.config.width as f32 / ctx.pixels_per_point(), 
                self.config.height as f32 / ctx.pixels_per_point()
            )
        );
        self.raw_input.screen_rect = Some(rect);
        self.raw_input.events = input_events.into_iter().map(|e| e.into()).collect();

        let full_output = ctx.run(self.raw_input.take(), |ctx| {
            egui::CentralPanel::default().show(&ctx, |ui| {
                ChatUI::ui(ui, &controller);
            });
        });

        let paint_jobs = ctx.tessellate(full_output.shapes, ctx.pixels_per_point());

        // Get the next frame
        let frame = surface.get_current_texture().expect("Failed to get next frame");
        let view = frame.texture.create_view(&wgpu::TextureViewDescriptor::default());

        // Begin rendering
        let mut encoder = device.create_command_encoder(&wgpu::CommandEncoderDescriptor {
            label: Some("Render Encoder"),
        });

        let screen_descriptor = ScreenDescriptor {
            physical_width: self.config.width,
            physical_height: self.config.height,
            scale_factor: ctx.pixels_per_point(),
        };
        let tdelta: egui::TexturesDelta = full_output.textures_delta;

        egui_rpass
            .add_textures(&device, &queue, &tdelta)
            .expect("add texture ok");

        egui_rpass.update_buffers(&device, &queue, &paint_jobs, &screen_descriptor);

        // Record all render passes.
        egui_rpass
            .execute(
                &mut encoder,
                &view,
                &paint_jobs,
                &screen_descriptor,
                Some(wgpu::Color::BLACK),
            )
            .unwrap();

        // Submit commands
        self.queue.submit(Some(encoder.finish()));

        // Present the frame
        frame.present();

        egui_rpass.remove_textures(tdelta).unwrap();

        OutputState::new(full_output.platform_output.cursor_icon.into())
    }
}