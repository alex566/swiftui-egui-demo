//
//  SmoothView.swift
//  SmoothChat
//
//  Created by Oleksii Oliinyk on 24.03.25.
//

import SwiftUI
import AppKit
import SmoothUI

struct SmoothView: View {
    let controller: BaseChatController
    
    @Environment(\.displayScale)
    var displayScale
    
    var body: some View {
        GeometryReader { proxy in
            SmoothNSViewRepresentable(
                controller: controller,
                size: proxy.size,
                scale: displayScale
            )
        }
    }
}

private struct SmoothNSViewRepresentable: NSViewRepresentable {
    let controller: BaseChatController
    let size: CGSize
    let scale: CGFloat
    
    func makeNSView(context: Context) -> SmoothNSView {
        let view = SmoothNSView(frame: .zero)
        context.coordinator.initialize(view: view, size: size, scale: scale)
        context.coordinator.start(view: view)
        return view
    }
    
    func updateNSView(_ nsView: SmoothNSView, context: Context) {
        context.coordinator.resize(to: size, scale: scale)
    }
    
    func makeCoordinator() -> SmoothRendererController {
        SmoothRendererController(controller: controller)
    }
}
