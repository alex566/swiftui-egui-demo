use crate::ffi::ffi::{BaseChatController, ChatBubble};

use egui::{Align, Color32, Frame, Label, Layout, Rect, RichText, Rounding, ScrollArea, Shape, Stroke, UiBuilder, Vec2};

pub struct ChatUI {
}

impl ChatUI {

    pub fn ui(ui: &mut egui::Ui, controller: &BaseChatController) {
        ui.set_width(ui.available_width());
        ui.set_height(ui.available_height());

        ScrollArea::vertical()
                .animated(false)
                .auto_shrink([false, false])
                .stick_to_bottom(true)
                .show(ui, |ui| {
                    let count = controller.bubbles_count();
                    for i in 0..count {
                        Self::bubble_ui(ui, controller.bubble_at_index(i));
                    }
                });
    }

    fn bubble_ui(ui: &mut egui::Ui, bubble: ChatBubble) {
        let max_msg_width = ui.available_width() - 40.0;
        let inner_margin = 8.0;
        let outer_margin = 8.0;

        let layout = Layout::top_down(Align::Min);

        ui.with_layout(layout, |ui| {
            ui.set_max_width(max_msg_width);

            let mut measure = |text| {
                let label = Label::new(text);
                let (_pos, galley, _response) = label.layout_in_ui(
                    &mut ui.new_child(UiBuilder::new().max_rect(ui.max_rect())),
                );
                let rect = galley.rect;
                f32::min(
                    rect.width() + inner_margin * 2.0 + outer_margin * 2.0 + 0.1,
                    max_msg_width,
                )
            };

            let text = &bubble.text;
            let sender = &bubble.sender;

            let content = RichText::new(text).strong();
            let mut msg_width = measure(content.clone());

            let name = RichText::new(sender).small().strong();
            let width = measure(name.clone());
            msg_width = f32::max(msg_width, width);

            ui.set_min_width(msg_width);

            // Draw the message.
            let msg_color = Color32::from_rgb(0, 120, 254);

            let rounding = 8.0;
            let margin = 8.0;
            let response = Frame::none()
                .rounding(Rounding {
                    ne: rounding,
                    nw: 0.0,
                    se: rounding,
                    sw: rounding,
                })
                .inner_margin(margin)
                .outer_margin(margin)
                .fill(msg_color)
                .show(ui, |ui| {
                    ui.with_layout(Layout::top_down(Align::Min), |ui| {
                        ui.label(name);
                        ui.label(content);
                    });
                })
                .response;


            // Draw a triangle pointing to the sender.
            let points = {
                let top = response.rect.left_top() + Vec2::splat(margin);
                let arrow_rect = Rect::from_two_pos(
                    top,
                    top + Vec2::new(-f32::from(rounding), rounding.into()),
                );

                vec![
                    arrow_rect.left_top(),
                    arrow_rect.right_top(),
                    arrow_rect.right_bottom(),
                ]
            };

            ui.painter()
                .add(Shape::convex_polygon(points, msg_color, Stroke::NONE))
        });
    }
}