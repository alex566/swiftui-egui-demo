//
//  InputOutputHandlingView.swift
//  SmoothChat
//
//  Created by Oleksii Oliinyk on 25.03.25.
//

import AppKit
import SmoothUI

class InputOutputHandlingView: NSView {
    
    private var trackingArea: NSTrackingArea?
    private var gatheredEvents: [InputEvent] = []
    
    private var currentCursor: NSCursor?
    
    override var acceptsFirstResponder: Bool {
        true
    }
    
    func draingEvents() -> RustVec<InputEvent> {
        let events = gatheredEvents
        gatheredEvents = []
        
        let result = RustVec<InputEvent>()
        for event in events {
            result.push(value: event)
        }
        return result
    }
    
    func handle(output: OutputState) {
        let setCursor = output.get_cursor_icon()
        let newCursor = cursorToNSCursor(setCursor)
        
        if currentCursor != newCursor {
            if let activeCursor = currentCursor {
                activeCursor.pop()
                currentCursor = nil
            }
            
            newCursor.push()
            currentCursor = newCursor
        }
    }

    func resetCursor() {
        if let activeCursor = currentCursor {
            activeCursor.pop()
            currentCursor = nil
        }
    }
    
    func cursorToNSCursor(_ cursor: CursorIconRef) -> NSCursor {
        if cursor.is_default() {
            .arrow
        } else if cursor.is_pointing_hand() {
            .pointingHand
        } else if cursor.is_text() {
            .iBeam
        } else if cursor.is_resize_horizontal(), #available(macOS 15.0, *) {
            .columnResize
        } else if cursor.is_resize_horizontal() {
            .resizeLeftRight
        } else if cursor.is_resize_vertical(), #available(macOS 15.0, *) {
            .rowResize
        } else if cursor.is_resize_vertical() {
            .resizeUpDown
        } else {
            .arrow
        }
    }
    
    override func updateTrackingAreas() {
        super.updateTrackingAreas()
        
        if let trackingArea {
            removeTrackingArea(trackingArea)
        }
        
        // Use activeInKeyWindow so that the tracking is only active when the window is key.
        let options: NSTrackingArea.Options = [
            .mouseEnteredAndExited,
            .mouseMoved,
            .activeInKeyWindow
        ]
        let trackingArea = NSTrackingArea(rect: bounds, options: options, owner: self, userInfo: nil)
        addTrackingArea(trackingArea)
        
        self.trackingArea = trackingArea
    }
    
    override func mouseEntered(with event: NSEvent) {
        handleMouseMove(event: event)
    }
    
    override func mouseMoved(with event: NSEvent) {
        handleMouseMove(event: event)
    }
    
    override func mouseExited(with event: NSEvent) {
        handleMouseMove(event: event)
    }
    
    // MARK: - Mouse Button and Scroll Events
    
    override func mouseDown(with event: NSEvent) {
        handleMouseMove(event: event)
        super.mouseDown(with: event)
    }
    
    override func mouseUp(with event: NSEvent) {
        handleMouseMove(event: event)
        super.mouseUp(with: event)
    }
    
    override func mouseDragged(with event: NSEvent) {
        handleMouseMove(event: event)
        super.mouseDragged(with: event)
    }
    
    override func rightMouseDown(with event: NSEvent) {
        handleMouseMove(event: event)
        super.rightMouseDown(with: event)
    }
    
    override func rightMouseUp(with event: NSEvent) {
        handleMouseMove(event: event)
        super.rightMouseUp(with: event)
    }
    
    override func rightMouseDragged(with event: NSEvent) {
        handleMouseMove(event: event)
        super.rightMouseDragged(with: event)
    }
    
    override func scrollWheel(with event: NSEvent) {
        handleMouseMove(event: event)
        super.scrollWheel(with: event)
    }
    
    // MARK: - Mapping
    
    private func handleMouseMove(event: NSEvent) {
        let point = convert(event.locationInWindow, from: nil)
        let size = bounds.size
        
        switch event.type {
        case .leftMouseDown:
            gatheredEvents.append(
                .from_left_mouse_down(
                    Float(point.x),
                    Float(size.height - point.y),
                    true
                )
            )
        case .leftMouseUp:
            gatheredEvents.append(
                .from_left_mouse_down(
                    Float(point.x),
                    Float(size.height - point.y),
                    false
                )
            )
        case .rightMouseDown:
            gatheredEvents.append(
                .from_right_mouse_down(
                    Float(point.x),
                    Float(size.height - point.y),
                    true
                )
            )
        case .rightMouseUp:
            gatheredEvents.append(
                .from_right_mouse_down(
                    Float(point.x),
                    Float(size.height - point.y),
                    false
                )
            )
        case .mouseMoved, .leftMouseDragged, .rightMouseDragged:
            gatheredEvents.append(
                .from_pointer_moved(
                    Float(point.x),
                    Float(size.height - point.y)
                )
            )
        case .mouseEntered:
            gatheredEvents.append(
                .from_window_focused(true)
            )
        case .mouseExited:
            gatheredEvents.append(
                .from_window_focused(false)
            )
            resetCursor()
        case .scrollWheel:
            gatheredEvents.append(
                .from_mouse_wheel(
                    Float(event.scrollingDeltaX),
                    Float(event.scrollingDeltaY)
                )
            )
        default:
            break
        }
    }
}
