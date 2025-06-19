//
//  File.swift
//  DLSectionLayout_Example
//
//  Created by liuhao on 2025/6/19.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

final class FPSMonitor {
    private weak var displayLink: CADisplayLink?
    private var lastTimestamp: CFTimeInterval = 0
    private var frameCount = 0
    
    private let label: UILabel = {
        let lbl = UILabel(frame: CGRect(x: UIScreen.main.bounds.width - 80, y: 40, width: 70, height: 30))
        lbl.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        lbl.textColor = .green
        lbl.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .medium)
        lbl.textAlignment = .center
        lbl.layer.cornerRadius = 5
        lbl.layer.masksToBounds = true
        lbl.isUserInteractionEnabled = false
        return lbl
    }()
    
    public init() {
        let link = CADisplayLink(target: self, selector: #selector(tick(_:)))
        link.add(to: .main, forMode: RunLoopMode.commonModes)
        displayLink = link
        lastTimestamp = 0
        frameCount = 0
    }
    
    deinit {
        displayLink?.invalidate()
    }
    
    @objc private func tick(_ link: CADisplayLink) {
        if lastTimestamp == 0 {
            lastTimestamp = link.timestamp
            return
        }
        frameCount += 1
        let delta = link.timestamp - lastTimestamp
        if delta >= 1 {
            let fps = Int(round(Double(frameCount) / delta))
            label.text = "FPS: \(fps)"
            frameCount = 0
            lastTimestamp = link.timestamp
        }
    }
    
    /// 添加到某个view上显示
    public func attach(to view: UIView) {
        if label.superview == nil {
            view.addSubview(label)
        }
    }
    
    /// 从父视图移除
    public func detach() {
        label.removeFromSuperview()
    }
}
