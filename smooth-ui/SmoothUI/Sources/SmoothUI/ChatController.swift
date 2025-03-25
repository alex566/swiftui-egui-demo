//
//  File.swift
//  SmoothUI
//
//  Created by Alexey Oleynik on 25.03.25.
//

import Foundation

open class BaseChatController {
    
    public init() {
    }
    
    open func bubbles_count() -> UInt {
        fatalError("Not implemented")
    }
    
    open func bubble_at_index(index: UInt) -> ChatBubble {
        fatalError("Not implemented")
    }
}
