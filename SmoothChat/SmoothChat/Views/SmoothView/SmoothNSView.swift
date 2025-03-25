//
//  SmoothView.swift
//  SmoothChat
//
//  Created by Oleksii Oliinyk on 24.03.25.
//

import Metal
import AppKit
import SmoothUI

@MainActor
final class SmoothNSView: InputOutputHandlingView {
    
    var metalLayer: CAMetalLayer {
        layer as! CAMetalLayer
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func makeBackingLayer() -> CALayer {
        CAMetalLayer()
    }
}
