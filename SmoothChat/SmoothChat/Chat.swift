//
//  Chat.swift
//  SmoothChat
//
//  Created by Oleksii Oliinyk on 25.03.25.
//

import Foundation

struct Chat: Identifiable, Hashable {
    let id: String
    let name: String
    let messages: [Message]
    
    static func mockHistory() -> [Chat] {
        let randomGreating = ["Hello!", "Hi!", "Hey!", "What's up?"]
        return [
            .init(
                id: "1",
                name: "Karen",
                messages: (0..<100).map {
                    .init(id: "\($0)",
                          text: randomGreating.randomElement()!)
                }
            ),
            .init(
                id: "2",
                name: "Bill",
                messages: [
                    .init(id: "1", text: "Hey! 􀝻"),
                    .init(id: "3", text: "How are you?"),
                    .init(id: "2", text: "Up for a run Today?")
                ])
        ]
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

struct Message: Identifiable, Hashable {
    let id: String
    let text: String
}
