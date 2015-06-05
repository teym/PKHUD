//
//  HUDView.swift
//  PKHUD
//
//  Created by Philip Kluz on 6/16/14.
//  Copyright (c) 2014 NSExceptional. All rights reserved.
//

import UIKit

/// Provides the general look and feel of the PKHUD, into which the eventual content is inserted.
internal class FrameView: UIView {
    internal required init() {
        super.init(frame: CGRectZero)
        commonInit()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
//        backgroundColor = UIColor(white: 0.8, alpha: 0.6)
        layer.cornerRadius = 9.0
        layer.masksToBounds = true
        
        _blurView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
        _blurView.frame = bounds
        addSubview(_blurView)
        
        _blurView.contentView.addSubview(self.content)
        
        let offset = 20.0
        
        let motionEffectsX = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
        motionEffectsX.maximumRelativeValue = offset
        motionEffectsX.minimumRelativeValue = -offset
        
        let motionEffectsY = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis)
        motionEffectsY.maximumRelativeValue = offset
        motionEffectsY.minimumRelativeValue = -offset
        
        var group = UIMotionEffectGroup()
        group.motionEffects = [motionEffectsX, motionEffectsY]
        
        addMotionEffect(group)
    }
    private var _blurView:UIVisualEffectView!
    private var _content = UIView()
    internal var content: UIView {
        get {
            return _content
        }
        set {
            _content.removeFromSuperview()
            _content = newValue
            _content.alpha = 1.0
            _content.clipsToBounds = true
            _content.contentMode = .Center
            frame.size = _content.bounds.size
            _blurView.frame = bounds
            _blurView.contentView.addSubview(_content)
        }
    }
}
