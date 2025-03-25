//
//  ChatController.swift
//  SmoothChat
//
//  Created by Oleksii Oliinyk on 25.03.25.
//

import Foundation
import Observation
import SmoothUI

@Observable
final class ChatController: BaseChatController {
    
    var selectedChat: Chat?
    
    // MARK: - View
    
    func select(chat: Chat) {
        selectedChat = chat
    }
    
    // MARK: - BaseChatController
    
    override func bubbles_count() -> UInt {
        guard let selectedChat else {
            return 0
        }
        return UInt(selectedChat.messages.count)
    }
    
    override func bubble_at_index(index: UInt) -> ChatBubble {
        guard let selectedChat else {
            fatalError("Bubble requested without selected chat")
        }
        let message = selectedChat.messages[Int(index)]
        return .init(sender: selectedChat.name.intoRustString(),
                     text: message.text.intoRustString())
    }
}
