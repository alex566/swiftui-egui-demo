//
//  ChatListEntryView.swift
//  SmoothChat
//
//  Created by Oleksii Oliinyk on 25.03.25.
//

import SwiftUI

struct ChatListEntryView: View {
    let chat: Chat
    
    var body: some View {
        HStack(alignment: .top) {
            ZStack {
                Circle()
                    .fill(.green)
                    .frame(width: 44.0, height: 44.0)
                Text(chat.name.prefix(2).uppercased())
                    .font(.title2)
            }
            VStack(alignment: .leading) {
                Text(chat.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                if let lastConversation = chat.messages.last {
                    Text(lastConversation.text)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .fontDesign(.rounded)
    }
}
