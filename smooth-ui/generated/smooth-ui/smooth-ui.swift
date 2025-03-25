@_cdecl("__swift_bridge__$BaseChatController$bubbles_count")
func __swift_bridge__BaseChatController_bubbles_count (_ this: UnsafeMutableRawPointer) -> UInt {
    Unmanaged<BaseChatController>.fromOpaque(this).takeUnretainedValue().bubbles_count()
}

@_cdecl("__swift_bridge__$BaseChatController$bubble_at_index")
func __swift_bridge__BaseChatController_bubble_at_index (_ this: UnsafeMutableRawPointer, _ index: UInt) -> __swift_bridge__$ChatBubble {
    Unmanaged<BaseChatController>.fromOpaque(this).takeUnretainedValue().bubble_at_index(index: index).intoFfiRepr()
}

public struct ChatBubble {
    public var sender: RustString
    public var text: RustString

    public init(sender: RustString,text: RustString) {
        self.sender = sender
        self.text = text
    }

    @inline(__always)
    func intoFfiRepr() -> __swift_bridge__$ChatBubble {
        { let val = self; return __swift_bridge__$ChatBubble(sender: { let rustString = val.sender.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), text: { let rustString = val.text.intoRustString(); rustString.isOwned = false; return rustString.ptr }()); }()
    }
}
extension __swift_bridge__$ChatBubble {
    @inline(__always)
    func intoSwiftRepr() -> ChatBubble {
        { let val = self; return ChatBubble(sender: RustString(ptr: val.sender), text: RustString(ptr: val.text)); }()
    }
}
extension __swift_bridge__$Option$ChatBubble {
    @inline(__always)
    func intoSwiftRepr() -> Optional<ChatBubble> {
        if self.is_some {
            return self.val.intoSwiftRepr()
        } else {
            return nil
        }
    }

    @inline(__always)
    static func fromSwiftRepr(_ val: Optional<ChatBubble>) -> __swift_bridge__$Option$ChatBubble {
        if let v = val {
            return __swift_bridge__$Option$ChatBubble(is_some: true, val: v.intoFfiRepr())
        } else {
            return __swift_bridge__$Option$ChatBubble(is_some: false, val: __swift_bridge__$ChatBubble())
        }
    }
}

public class InputEvent: InputEventRefMut {
    var isOwned: Bool = true

    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }

    deinit {
        if isOwned {
            __swift_bridge__$InputEvent$_free(ptr)
        }
    }
}
extension InputEvent {
    class public func from_pointer_moved(_ x: Float, _ y: Float) -> InputEvent {
        InputEvent(ptr: __swift_bridge__$InputEvent$from_pointer_moved(x, y))
    }

    class public func from_mouse_wheel(_ x: Float, _ y: Float) -> InputEvent {
        InputEvent(ptr: __swift_bridge__$InputEvent$from_mouse_wheel(x, y))
    }

    class public func from_left_mouse_down(_ x: Float, _ y: Float, _ pressed: Bool) -> InputEvent {
        InputEvent(ptr: __swift_bridge__$InputEvent$from_left_mouse_down(x, y, pressed))
    }

    class public func from_right_mouse_down(_ x: Float, _ y: Float, _ pressed: Bool) -> InputEvent {
        InputEvent(ptr: __swift_bridge__$InputEvent$from_right_mouse_down(x, y, pressed))
    }

    class public func from_window_focused(_ focused: Bool) -> InputEvent {
        InputEvent(ptr: __swift_bridge__$InputEvent$from_window_focused(focused))
    }
}
public class InputEventRefMut: InputEventRef {
    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }
}
public class InputEventRef {
    var ptr: UnsafeMutableRawPointer

    public init(ptr: UnsafeMutableRawPointer) {
        self.ptr = ptr
    }
}
extension InputEvent: Vectorizable {
    public static func vecOfSelfNew() -> UnsafeMutableRawPointer {
        __swift_bridge__$Vec_InputEvent$new()
    }

    public static func vecOfSelfFree(vecPtr: UnsafeMutableRawPointer) {
        __swift_bridge__$Vec_InputEvent$drop(vecPtr)
    }

    public static func vecOfSelfPush(vecPtr: UnsafeMutableRawPointer, value: InputEvent) {
        __swift_bridge__$Vec_InputEvent$push(vecPtr, {value.isOwned = false; return value.ptr;}())
    }

    public static func vecOfSelfPop(vecPtr: UnsafeMutableRawPointer) -> Optional<Self> {
        let pointer = __swift_bridge__$Vec_InputEvent$pop(vecPtr)
        if pointer == nil {
            return nil
        } else {
            return (InputEvent(ptr: pointer!) as! Self)
        }
    }

    public static func vecOfSelfGet(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<InputEventRef> {
        let pointer = __swift_bridge__$Vec_InputEvent$get(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return InputEventRef(ptr: pointer!)
        }
    }

    public static func vecOfSelfGetMut(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<InputEventRefMut> {
        let pointer = __swift_bridge__$Vec_InputEvent$get_mut(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return InputEventRefMut(ptr: pointer!)
        }
    }

    public static func vecOfSelfAsPtr(vecPtr: UnsafeMutableRawPointer) -> UnsafePointer<InputEventRef> {
        UnsafePointer<InputEventRef>(OpaquePointer(__swift_bridge__$Vec_InputEvent$as_ptr(vecPtr)))
    }

    public static func vecOfSelfLen(vecPtr: UnsafeMutableRawPointer) -> UInt {
        __swift_bridge__$Vec_InputEvent$len(vecPtr)
    }
}


public class OutputState: OutputStateRefMut {
    var isOwned: Bool = true

    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }

    deinit {
        if isOwned {
            __swift_bridge__$OutputState$_free(ptr)
        }
    }
}
public class OutputStateRefMut: OutputStateRef {
    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }
}
public class OutputStateRef {
    var ptr: UnsafeMutableRawPointer

    public init(ptr: UnsafeMutableRawPointer) {
        self.ptr = ptr
    }
}
extension OutputStateRef {
    public func get_cursor_icon() -> CursorIconRef {
        CursorIconRef(ptr: __swift_bridge__$OutputState$get_cursor_icon(ptr))
    }
}
extension OutputState: Vectorizable {
    public static func vecOfSelfNew() -> UnsafeMutableRawPointer {
        __swift_bridge__$Vec_OutputState$new()
    }

    public static func vecOfSelfFree(vecPtr: UnsafeMutableRawPointer) {
        __swift_bridge__$Vec_OutputState$drop(vecPtr)
    }

    public static func vecOfSelfPush(vecPtr: UnsafeMutableRawPointer, value: OutputState) {
        __swift_bridge__$Vec_OutputState$push(vecPtr, {value.isOwned = false; return value.ptr;}())
    }

    public static func vecOfSelfPop(vecPtr: UnsafeMutableRawPointer) -> Optional<Self> {
        let pointer = __swift_bridge__$Vec_OutputState$pop(vecPtr)
        if pointer == nil {
            return nil
        } else {
            return (OutputState(ptr: pointer!) as! Self)
        }
    }

    public static func vecOfSelfGet(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<OutputStateRef> {
        let pointer = __swift_bridge__$Vec_OutputState$get(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return OutputStateRef(ptr: pointer!)
        }
    }

    public static func vecOfSelfGetMut(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<OutputStateRefMut> {
        let pointer = __swift_bridge__$Vec_OutputState$get_mut(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return OutputStateRefMut(ptr: pointer!)
        }
    }

    public static func vecOfSelfAsPtr(vecPtr: UnsafeMutableRawPointer) -> UnsafePointer<OutputStateRef> {
        UnsafePointer<OutputStateRef>(OpaquePointer(__swift_bridge__$Vec_OutputState$as_ptr(vecPtr)))
    }

    public static func vecOfSelfLen(vecPtr: UnsafeMutableRawPointer) -> UInt {
        __swift_bridge__$Vec_OutputState$len(vecPtr)
    }
}


public class CursorIcon: CursorIconRefMut {
    var isOwned: Bool = true

    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }

    deinit {
        if isOwned {
            __swift_bridge__$CursorIcon$_free(ptr)
        }
    }
}
public class CursorIconRefMut: CursorIconRef {
    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }
}
public class CursorIconRef {
    var ptr: UnsafeMutableRawPointer

    public init(ptr: UnsafeMutableRawPointer) {
        self.ptr = ptr
    }
}
extension CursorIconRef {
    public func is_default() -> Bool {
        __swift_bridge__$CursorIcon$is_default(ptr)
    }

    public func is_pointing_hand() -> Bool {
        __swift_bridge__$CursorIcon$is_pointing_hand(ptr)
    }

    public func is_resize_horizontal() -> Bool {
        __swift_bridge__$CursorIcon$is_resize_horizontal(ptr)
    }

    public func is_resize_vertical() -> Bool {
        __swift_bridge__$CursorIcon$is_resize_vertical(ptr)
    }

    public func is_text() -> Bool {
        __swift_bridge__$CursorIcon$is_text(ptr)
    }
}
extension CursorIcon: Vectorizable {
    public static func vecOfSelfNew() -> UnsafeMutableRawPointer {
        __swift_bridge__$Vec_CursorIcon$new()
    }

    public static func vecOfSelfFree(vecPtr: UnsafeMutableRawPointer) {
        __swift_bridge__$Vec_CursorIcon$drop(vecPtr)
    }

    public static func vecOfSelfPush(vecPtr: UnsafeMutableRawPointer, value: CursorIcon) {
        __swift_bridge__$Vec_CursorIcon$push(vecPtr, {value.isOwned = false; return value.ptr;}())
    }

    public static func vecOfSelfPop(vecPtr: UnsafeMutableRawPointer) -> Optional<Self> {
        let pointer = __swift_bridge__$Vec_CursorIcon$pop(vecPtr)
        if pointer == nil {
            return nil
        } else {
            return (CursorIcon(ptr: pointer!) as! Self)
        }
    }

    public static func vecOfSelfGet(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<CursorIconRef> {
        let pointer = __swift_bridge__$Vec_CursorIcon$get(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return CursorIconRef(ptr: pointer!)
        }
    }

    public static func vecOfSelfGetMut(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<CursorIconRefMut> {
        let pointer = __swift_bridge__$Vec_CursorIcon$get_mut(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return CursorIconRefMut(ptr: pointer!)
        }
    }

    public static func vecOfSelfAsPtr(vecPtr: UnsafeMutableRawPointer) -> UnsafePointer<CursorIconRef> {
        UnsafePointer<CursorIconRef>(OpaquePointer(__swift_bridge__$Vec_CursorIcon$as_ptr(vecPtr)))
    }

    public static func vecOfSelfLen(vecPtr: UnsafeMutableRawPointer) -> UInt {
        __swift_bridge__$Vec_CursorIcon$len(vecPtr)
    }
}


public class Renderer: RendererRefMut {
    var isOwned: Bool = true

    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }

    deinit {
        if isOwned {
            __swift_bridge__$Renderer$_free(ptr)
        }
    }
}
extension Renderer {
    public convenience init(_ layer_ptr: UnsafeMutableRawPointer, _ width: UInt32, _ height: UInt32, _ display_scale: Float) {
        self.init(ptr: __swift_bridge__$Renderer$new(layer_ptr, width, height, display_scale))
    }
}
public class RendererRefMut: RendererRef {
    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }
}
extension RendererRefMut {
    public func resize(_ width: UInt32, _ height: UInt32) {
        __swift_bridge__$Renderer$resize(ptr, width, height)
    }

    public func render(_ time: Double, _ input_events: RustVec<InputEvent>, _ controller: BaseChatController) -> OutputState {
        OutputState(ptr: __swift_bridge__$Renderer$render(ptr, time, { let val = input_events; val.isOwned = false; return val.ptr }(), Unmanaged.passRetained(controller).toOpaque()))
    }
}
public class RendererRef {
    var ptr: UnsafeMutableRawPointer

    public init(ptr: UnsafeMutableRawPointer) {
        self.ptr = ptr
    }
}
extension Renderer: Vectorizable {
    public static func vecOfSelfNew() -> UnsafeMutableRawPointer {
        __swift_bridge__$Vec_Renderer$new()
    }

    public static func vecOfSelfFree(vecPtr: UnsafeMutableRawPointer) {
        __swift_bridge__$Vec_Renderer$drop(vecPtr)
    }

    public static func vecOfSelfPush(vecPtr: UnsafeMutableRawPointer, value: Renderer) {
        __swift_bridge__$Vec_Renderer$push(vecPtr, {value.isOwned = false; return value.ptr;}())
    }

    public static func vecOfSelfPop(vecPtr: UnsafeMutableRawPointer) -> Optional<Self> {
        let pointer = __swift_bridge__$Vec_Renderer$pop(vecPtr)
        if pointer == nil {
            return nil
        } else {
            return (Renderer(ptr: pointer!) as! Self)
        }
    }

    public static func vecOfSelfGet(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<RendererRef> {
        let pointer = __swift_bridge__$Vec_Renderer$get(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return RendererRef(ptr: pointer!)
        }
    }

    public static func vecOfSelfGetMut(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<RendererRefMut> {
        let pointer = __swift_bridge__$Vec_Renderer$get_mut(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return RendererRefMut(ptr: pointer!)
        }
    }

    public static func vecOfSelfAsPtr(vecPtr: UnsafeMutableRawPointer) -> UnsafePointer<RendererRef> {
        UnsafePointer<RendererRef>(OpaquePointer(__swift_bridge__$Vec_Renderer$as_ptr(vecPtr)))
    }

    public static func vecOfSelfLen(vecPtr: UnsafeMutableRawPointer) -> UInt {
        __swift_bridge__$Vec_Renderer$len(vecPtr)
    }
}


@_cdecl("__swift_bridge__$BaseChatController$_free")
func __swift_bridge__BaseChatController__free (ptr: UnsafeMutableRawPointer) {
    let _ = Unmanaged<BaseChatController>.fromOpaque(ptr).takeRetainedValue()
}



