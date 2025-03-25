//
//  ContentView.swift
//  SmoothChat
//
//  Created by Oleksii Oliinyk on 24.03.25.
//

import SwiftUI

struct ChatListView: View {
    
    @State
    var controller = ChatController()
    
    @State
    var history = Chat.mockHistory()
    
    var body: some View {
        NavigationSplitView {
            List(selection: $controller.selectedChat) {
                Section("Today") {
                    ForEach(Chat.mockHistory()) { chat in
                        ChatListEntryView(chat: chat)
                            .tag(chat)
                    }
                }
            }
            .onAppear {
                if let first = history.first {
                    controller.select(chat: first)
                }
            }
        } detail: {
            SmoothView(controller: controller)
        }
    }
}
