use egui::{Event, Modifiers};

pub enum InputEvent {
    PointerMoved(f32, f32),
    MouseWheel(f32, f32),
    LeftMouseDown(f32, f32, bool),
    RightMouseDown(f32, f32, bool),
    WindowFocused(bool)
}

impl Into<Event> for InputEvent {
   
    fn into(self) -> Event {
        match self {
            InputEvent::PointerMoved(x, y) => Event::PointerMoved(egui::Pos2::new(x, y)),
            InputEvent::MouseWheel(x, y) => Event::MouseWheel { unit: egui::MouseWheelUnit::Point, delta: egui::vec2(x, y), modifiers: Modifiers::default() },
            InputEvent::LeftMouseDown(x, y, pressed) => Event::PointerButton { pos: egui::Pos2::new(x, y), button: egui::PointerButton::Primary, pressed, modifiers: Modifiers::default() },
            InputEvent::RightMouseDown(x, y, pressed) => Event::PointerButton { pos: egui::Pos2::new(x, y), button: egui::PointerButton::Secondary, pressed, modifiers: Modifiers::default() },
            InputEvent::WindowFocused(focused) => Event::WindowFocused(focused),
        }
    }
}

pub struct OutputState {
    cursor_icon: CursorIcon,
}

impl OutputState {
    
    pub fn new(cursor_icon: CursorIcon) -> Self {
        Self {
            cursor_icon
        }
    }

    pub fn get_cursor_icon(&self) -> &CursorIcon {
        &self.cursor_icon
    }
}

pub enum CursorIcon {
    Default,
    PointingHand,
    ResizeHorizontal,
    ResizeVertical,
    Text,
}

impl From<egui::CursorIcon> for CursorIcon {
    
    fn from(cursor_icon: egui::CursorIcon) -> Self {
        match cursor_icon {
            egui::CursorIcon::Default => Self::Default,
            egui::CursorIcon::PointingHand => Self::PointingHand,
            egui::CursorIcon::ResizeHorizontal | egui::CursorIcon::ResizeColumn => Self::ResizeHorizontal,
            egui::CursorIcon::ResizeVertical | egui::CursorIcon::ResizeRow => Self::ResizeVertical,
            egui::CursorIcon::Text => Self::Text,
            default => {
                println!("Unsupported cursor icon: {:?}", default);
                Self::Default
            }
        }
    }
}