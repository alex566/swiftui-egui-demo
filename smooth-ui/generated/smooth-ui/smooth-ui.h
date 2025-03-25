// File automatically generated by swift-bridge.
#include <stdint.h>
#include <stdbool.h>
typedef struct __swift_bridge__$ChatBubble { void* sender; void* text; } __swift_bridge__$ChatBubble;
typedef struct __swift_bridge__$Option$ChatBubble { bool is_some; __swift_bridge__$ChatBubble val; } __swift_bridge__$Option$ChatBubble;
typedef struct InputEvent InputEvent;
void __swift_bridge__$InputEvent$_free(void* self);

void* __swift_bridge__$Vec_InputEvent$new(void);
void __swift_bridge__$Vec_InputEvent$drop(void* vec_ptr);
void __swift_bridge__$Vec_InputEvent$push(void* vec_ptr, void* item_ptr);
void* __swift_bridge__$Vec_InputEvent$pop(void* vec_ptr);
void* __swift_bridge__$Vec_InputEvent$get(void* vec_ptr, uintptr_t index);
void* __swift_bridge__$Vec_InputEvent$get_mut(void* vec_ptr, uintptr_t index);
uintptr_t __swift_bridge__$Vec_InputEvent$len(void* vec_ptr);
void* __swift_bridge__$Vec_InputEvent$as_ptr(void* vec_ptr);

typedef struct OutputState OutputState;
void __swift_bridge__$OutputState$_free(void* self);

void* __swift_bridge__$Vec_OutputState$new(void);
void __swift_bridge__$Vec_OutputState$drop(void* vec_ptr);
void __swift_bridge__$Vec_OutputState$push(void* vec_ptr, void* item_ptr);
void* __swift_bridge__$Vec_OutputState$pop(void* vec_ptr);
void* __swift_bridge__$Vec_OutputState$get(void* vec_ptr, uintptr_t index);
void* __swift_bridge__$Vec_OutputState$get_mut(void* vec_ptr, uintptr_t index);
uintptr_t __swift_bridge__$Vec_OutputState$len(void* vec_ptr);
void* __swift_bridge__$Vec_OutputState$as_ptr(void* vec_ptr);

typedef struct CursorIcon CursorIcon;
void __swift_bridge__$CursorIcon$_free(void* self);

void* __swift_bridge__$Vec_CursorIcon$new(void);
void __swift_bridge__$Vec_CursorIcon$drop(void* vec_ptr);
void __swift_bridge__$Vec_CursorIcon$push(void* vec_ptr, void* item_ptr);
void* __swift_bridge__$Vec_CursorIcon$pop(void* vec_ptr);
void* __swift_bridge__$Vec_CursorIcon$get(void* vec_ptr, uintptr_t index);
void* __swift_bridge__$Vec_CursorIcon$get_mut(void* vec_ptr, uintptr_t index);
uintptr_t __swift_bridge__$Vec_CursorIcon$len(void* vec_ptr);
void* __swift_bridge__$Vec_CursorIcon$as_ptr(void* vec_ptr);

typedef struct Renderer Renderer;
void __swift_bridge__$Renderer$_free(void* self);

void* __swift_bridge__$Vec_Renderer$new(void);
void __swift_bridge__$Vec_Renderer$drop(void* vec_ptr);
void __swift_bridge__$Vec_Renderer$push(void* vec_ptr, void* item_ptr);
void* __swift_bridge__$Vec_Renderer$pop(void* vec_ptr);
void* __swift_bridge__$Vec_Renderer$get(void* vec_ptr, uintptr_t index);
void* __swift_bridge__$Vec_Renderer$get_mut(void* vec_ptr, uintptr_t index);
uintptr_t __swift_bridge__$Vec_Renderer$len(void* vec_ptr);
void* __swift_bridge__$Vec_Renderer$as_ptr(void* vec_ptr);

void* __swift_bridge__$InputEvent$from_pointer_moved(float x, float y);
void* __swift_bridge__$InputEvent$from_mouse_wheel(float x, float y);
void* __swift_bridge__$InputEvent$from_left_mouse_down(float x, float y, bool pressed);
void* __swift_bridge__$InputEvent$from_right_mouse_down(float x, float y, bool pressed);
void* __swift_bridge__$InputEvent$from_window_focused(bool focused);
void* __swift_bridge__$OutputState$get_cursor_icon(void* self);
bool __swift_bridge__$CursorIcon$is_default(void* self);
bool __swift_bridge__$CursorIcon$is_pointing_hand(void* self);
bool __swift_bridge__$CursorIcon$is_resize_horizontal(void* self);
bool __swift_bridge__$CursorIcon$is_resize_vertical(void* self);
bool __swift_bridge__$CursorIcon$is_text(void* self);
void* __swift_bridge__$Renderer$new(void* layer_ptr, uint32_t width, uint32_t height, float display_scale);
void __swift_bridge__$Renderer$resize(void* self, uint32_t width, uint32_t height);
void* __swift_bridge__$Renderer$render(void* self, double time, void* input_events, void* controller);


