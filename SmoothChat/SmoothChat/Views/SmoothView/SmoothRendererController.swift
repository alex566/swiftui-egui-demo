//
//  SmoothRendererController.swift
//  SmoothChat
//
//  Created by Oleksii Oliinyk on 24.03.25.
//

import Metal
import AppKit
import SmoothUI

@MainActor
final class SmoothRendererController: NSObject {
    let controller: BaseChatController
    
    private weak var view: SmoothNSView!
    private var displayLink: CADisplayLink!
    
    private var renderer: Renderer!
    
    init(controller: BaseChatController) {
        self.controller = controller
    }
    
    deinit {
        MainActor.assumeIsolated {
            displayLink.invalidate()
        }
    }
    
    func initialize(view: SmoothNSView, size: CGSize, scale: CGFloat) {
        self.view = view
        
        let layer = view.metalLayer
        layer.framebufferOnly = true
        layer.pixelFormat = .bgra8Unorm_srgb
        layer.drawableSize = size
        layer.contentsScale = scale
        
        let rawPointer = Unmanaged.passUnretained(layer).toOpaque()
        renderer = Renderer(
            rawPointer,
            UInt32(max(size.width, 100.0) * scale),
            UInt32(max(size.height, 100.0) * scale),
            Float(scale)
        )
    }
    
    func start(view: SmoothNSView) {
        let link = view.displayLink(target: self, selector: #selector(render))
        link.add(to: .main, forMode: .common)
        self.displayLink = link
    }
    
    @objc
    func render(displayLink: CADisplayLink) {
        let events = view.draingEvents()
        let state = renderer.render(
            displayLink.timestamp,
            events,
            controller
        )
        view.handle(output: state)
    }
    
    func resize(to size: CGSize, scale: CGFloat) {
        guard size.width > 0 && size.height > 0 else {
            return
        }
        renderer.resize(
            UInt32(size.width * scale),
            UInt32(size.height * scale)
        )
    }
}
