
use crate::renderer::Renderer;
use crate::input_output::{InputEvent, OutputState, CursorIcon};

use std::ffi::c_void;

#[swift_bridge::bridge]
pub mod ffi {

    #[swift_bridge(swift_repr = "struct")]
    struct ChatBubble {
        sender: String,
        text: String
    }

    extern "Rust" {
        type InputEvent;

        #[swift_bridge(associated_to = InputEvent)]
        fn from_pointer_moved(x: f32, y: f32) -> InputEvent;

        #[swift_bridge(associated_to = InputEvent)]
        fn from_mouse_wheel(x: f32, y: f32) -> InputEvent;

        #[swift_bridge(associated_to = InputEvent)]
        fn from_left_mouse_down(x: f32, y: f32, pressed: bool) -> InputEvent;

        #[swift_bridge(associated_to = InputEvent)]
        fn from_right_mouse_down(x: f32, y: f32, pressed: bool) -> InputEvent;

        #[swift_bridge(associated_to = InputEvent)]
        fn from_window_focused(focused: bool) -> InputEvent;
    }

    extern "Rust" {
        type OutputState;

        fn get_cursor_icon(&self) -> &CursorIcon;
    }

    extern "Rust" {
        type CursorIcon;

        fn is_default(&self) -> bool;

        fn is_pointing_hand(&self) -> bool;

        fn is_resize_horizontal(&self) -> bool;

        fn is_resize_vertical(&self) -> bool;

        fn is_text(&self) -> bool;
    }

    extern "Rust" {
        type Renderer;

        #[swift_bridge(init)]
        fn new(layer_ptr: *mut c_void, width: u32, height: u32, display_scale: f32) -> Renderer;

        fn resize(&mut self, width: u32, height: u32);

        fn render(&mut self, time: f64, input_events: Vec<InputEvent>, controller: BaseChatController) -> OutputState;
    }

    extern "Swift" {
        type BaseChatController;

        fn bubbles_count(&self) -> usize;

        fn bubble_at_index(&self, index: usize) -> ChatBubble;
    }
}

// Extra interface for accessing the Input event from swift
impl InputEvent {
    
    fn from_pointer_moved(x: f32, y: f32) -> Self {
        Self::PointerMoved(x, y)
    }

    fn from_mouse_wheel(x: f32, y: f32) -> Self {
        Self::MouseWheel(x, y)
    }

    fn from_left_mouse_down(x: f32, y: f32, pressed: bool) -> Self {
        Self::LeftMouseDown(x, y, pressed)
    }

    fn from_right_mouse_down(x: f32, y: f32, pressed: bool) -> Self {
        Self::RightMouseDown(x, y, pressed)
    }

    fn from_window_focused(focused: bool) -> Self {
        Self::WindowFocused(focused)
    }
}

impl CursorIcon {
    
    fn is_default(&self) -> bool {
        match self {
            Self::Default => true,
            _ => false
        }
    }

    fn is_pointing_hand(&self) -> bool {
        match self {
            Self::PointingHand => true,
            _ => false
        }
    }

    fn is_resize_horizontal(&self) -> bool {
        match self {
            Self::ResizeHorizontal => true,
            _ => false
        }
    }

    fn is_resize_vertical(&self) -> bool {
        match self {
            Self::ResizeVertical => true,
            _ => false
        }
    }

    fn is_text(&self) -> bool {
        match self {
            Self::Text => true,
            _ => false
        }
    }
}
