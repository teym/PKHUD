//
//  HUDContentView.swift
//  PKHUD
//
//  Created by Philip Kluz on 6/17/14.
//  Copyright (c) 2014 NSExceptional. All rights reserved.
//

import UIKit
import QuartzCore

/// Provides a square view, which you can subclass and add additional views to.
@objc public class PKHUDSquareBaseView: UIView {
    
    public override init(frame: CGRect = CGRect(origin: CGPointZero, size: CGSize(width: 156.0, height: 156.0))) {
        super.init(frame: frame)
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

/// Provides a wide base view, which you can subclass and add additional views to.
@objc public class PKHUDWideBaseView: UIView {
    public override init(frame: CGRect = CGRect(origin: CGPointZero, size: CGSize(width: 265.0, height: 90.0))) {
        super.init(frame: frame)
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

/// Provides a wide, three line text view, which you can use to display information.
@objc public class PKHUDTextView: PKHUDWideBaseView {
    public init(text: String?) {
        super.init(frame: CGRect(origin: CGPointZero, size: CGSize(width: 265.0, height: 90.0)))
        commonInit(text)
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit("")
    }
    
    private func commonInit(text: String?) {
        titleLabel.text = text
        addSubview(titleLabel)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let padding: CGFloat = 10.0
        titleLabel.frame = CGRectInset(bounds, padding, padding)
    }
    
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .Center
        label.font = UIFont.boldSystemFontOfSize(17.0)
        label.textColor = UIColor.blackColor().colorWithAlphaComponent(0.85)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 3
        return label
        }()
}

/// Provides a square view, which you can use to display a single image.
@objc public class PKHUDImageView: PKHUDSquareBaseView {
    public init(image: UIImage?) {
        super.init(frame: CGRect(origin: CGPointZero, size: CGSize(width: 156.0, height: 156.0)))
        commonInit(image)
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit(nil)
    }
    
    private func commonInit(image: UIImage?) {
        imageView.image = image
        addSubview(imageView)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
    public let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.alpha = 0.85
        imageView.clipsToBounds = true
        imageView.contentMode = .Center
        return imageView
        }()
}

/// Provides a square (indeterminate) progress view.
@objc public final class PKHUDProgressView: PKHUDImageView {
    public init() {
        super.init(image: UIImage(named: "progress"))
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private override func commonInit(image: UIImage?) {
        super.commonInit(image)
        
        let progressImage = PKHUDAssets.progressImage
        
        imageView.image = progressImage
        imageView.layer.addAnimation({
            let animation = CABasicAnimation(keyPath: "transform.rotation.z")
            animation.toValue = NSNumber(float: 2.0 * Float(M_PI))
            animation.duration = 1.2
            animation.cumulative = true
            animation.repeatCount = Float(INT_MAX)
            return animation
            }(), forKey: "transform.rotation.z")
        imageView.alpha = 0.9
    }
}

//// Provides the system UIActivityIndicatorView as an alternative.
@objc public final class PKHUDSystemActivityIndicatorView: UIView {
    
    required public init() {
        super.init(frame: CGRectMake(0.0, 0.0, 120.0, 120.0))
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func commonInit () {
        self.backgroundColor = UIColor.clearColor()
        self.alpha = 0.8
        
        let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        activity.color = UIColor.blackColor()
        activity.startAnimating()
        
        self.addSubview(activity)
        
        activity.center = self.center
    }
}

/// Provides a square view, which you can use to display a picture and a title (above the image).
@objc public final class PKHUDTitleView: PKHUDImageView {
    public init(title: String?, image: UIImage?) {
        super.init(image: image)
        commonInit(title)
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit("");
    }
    
    private func commonInit(title: String?) {
        titleLabel.text = title
        addSubview(titleLabel)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let viewWidth: CGFloat = bounds.size.width
        let viewHeight: CGFloat = bounds.size.height
        
        let halfHeight = CGFloat(ceilf(CFloat(viewHeight / 2.0)))
        let quarterHeight = CGFloat(ceilf(CFloat(viewHeight / 4.0)))
        let threeQuarterHeight = CGFloat(ceilf(CFloat(viewHeight / 4.0 * 3.0)))
        
        let opticalOffset: CGFloat = 10.0
        
        titleLabel.frame = CGRect(origin: CGPoint(x:0.0, y:opticalOffset), size: CGSize(width: viewWidth, height: quarterHeight))
        imageView.frame = CGRect(origin: CGPoint(x:0.0, y:quarterHeight - opticalOffset), size: CGSize(width: viewWidth, height: threeQuarterHeight))
    }
    
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .Center
        label.font = UIFont.boldSystemFontOfSize(17.0)
        label.textColor = UIColor.blackColor().colorWithAlphaComponent(0.85)
        return label
        }()
}

/// Provides a square view, which you can use to display a picture and a subtitle (beneath the image).
@objc public final class PKHUDSubtitleView: PKHUDImageView {
    public init(subtitle: String?, image: UIImage?) {
        super.init(image: image)
        commonInit(subtitle)
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit("");
    }
    
    private func commonInit(subtitle: String?) {
        subtitleLabel.text = subtitle
        addSubview(subtitleLabel)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let viewWidth: CGFloat = bounds.size.width
        let viewHeight: CGFloat = bounds.size.height
        
        let halfHeight = CGFloat(ceilf(CFloat(viewHeight / 2.0)))
        let quarterHeight = CGFloat(ceilf(CFloat(viewHeight / 4.0)))
        let threeQuarterHeight = CGFloat(ceilf(CFloat(viewHeight / 4.0 * 3.0)))
        
        let opticalOffset: CGFloat = 10.0
        
        imageView.frame = CGRect(origin: CGPoint(x: 0.0, y: opticalOffset), size: CGSize(width: viewWidth, height: threeQuarterHeight - opticalOffset))
        subtitleLabel.frame = CGRect(origin: CGPoint(x:0.0, y:threeQuarterHeight - opticalOffset), size: CGSize(width: viewWidth, height: quarterHeight))
    }
    
    public let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .Center
        label.font = UIFont.boldSystemFontOfSize(17.0)
        label.textColor = UIColor.blackColor().colorWithAlphaComponent(0.85)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
        }()
}

/// Provides a square view, which you can use to display a picture, a title and a subtitle. This type of view replicates the Apple HUD one to one.
@objc public final class PKHUDStatusView: PKHUDImageView {
    public init(title: String?, subtitle: String?, image: UIImage?) {
        super.init(image: image)
        commonInit(title, subtitle: subtitle)
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit("", subtitle: "")
    }
    
    private func commonInit(title: String?, subtitle: String?) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let viewWidth = bounds.size.width
        let viewHeight = bounds.size.height
        
        let halfHeight = CGFloat(ceilf(CFloat(viewHeight / 2.0)))
        let quarterHeight = CGFloat(ceilf(CFloat(viewHeight / 4.0)))
        let threeQuarterHeight = CGFloat(ceilf(CFloat(viewHeight / 4.0 * 3.0)))
        
        titleLabel.frame = CGRect(origin: CGPointZero, size: CGSize(width: viewWidth, height: quarterHeight))
        imageView.frame = CGRect(origin: CGPoint(x:0.0, y:quarterHeight), size: CGSize(width: viewWidth, height: halfHeight))
        subtitleLabel.frame = CGRect(origin: CGPoint(x:0.0, y:threeQuarterHeight), size: CGSize(width: viewWidth, height: quarterHeight))
    }
    
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .Center
        label.font = UIFont.boldSystemFontOfSize(17.0)
        label.textColor = UIColor.blackColor().colorWithAlphaComponent(0.85)
        return label
        }()
    
    public let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(14.0)
        label.textColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
        }()
}

@objc public final class PKHUDSpinner: PKHUDSquareBaseView {
    // MARK: - Init
    
    //
    // Custom init to build the spinner UI
    //
    public convenience init(title:String){
        self.init(frame: CGRect(origin: CGPointZero, size: CGSize(width: 156.0, height: 156.0)))
        self.title = title
        self.animating = false
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        let titleScale: CGFloat = 0.85
        titleLabel.frame.size = CGSize(width: frameSize.width * titleScale, height: frameSize.height * titleScale)
        titleLabel.font = defaultTitleFont
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .Center
        titleLabel.lineBreakMode = .ByWordWrapping
        titleLabel.adjustsFontSizeToFitWidth = true
        
        addSubview(titleLabel)
        
        outerCircleView.frame.size = frameSize
        
        outerCircle.path = UIBezierPath(ovalInRect: CGRect(x: 0.0, y: 0.0, width: frameSize.width, height: frameSize.height)).CGPath
        outerCircle.lineWidth = 8.0
        outerCircle.strokeStart = 0.0
        outerCircle.strokeEnd = 0.45
        outerCircle.lineCap = kCALineCapRound
        outerCircle.fillColor = UIColor.clearColor().CGColor
        outerCircle.strokeColor = UIColor.whiteColor().CGColor
        outerCircleView.layer.addSublayer(outerCircle)
        
        outerCircle.strokeStart = 0.0
        outerCircle.strokeEnd = 1.0
        
        addSubview(outerCircleView)
        
        innerCircleView.frame.size = frameSize
        
        let innerCirclePadding: CGFloat = 12
        innerCircle.path = UIBezierPath(ovalInRect: CGRect(x: innerCirclePadding, y: innerCirclePadding, width: frameSize.width - 2*innerCirclePadding, height: frameSize.height - 2*innerCirclePadding)).CGPath
        innerCircle.lineWidth = 4.0
        innerCircle.strokeStart = 0.5
        innerCircle.strokeEnd = 0.9
        innerCircle.lineCap = kCALineCapRound
        innerCircle.fillColor = UIColor.clearColor().CGColor
        innerCircle.strokeColor = UIColor.grayColor().CGColor
        innerCircleView.layer.addSublayer(innerCircle)
        
        innerCircle.strokeStart = 0.0
        innerCircle.strokeEnd = 1.0
        
        addSubview(innerCircleView)
        
        titleLabel.center = center
        outerCircleView.center = center
        innerCircleView.center = center
    }
    
    // MARK: - Public interface
    
    //
    // Show the spinner activity on screen, if visible only update the title
    //
    public func update(title: String, animated: Bool = true) {
        self.title = title
        self.animating = animated
    }
    
    //
    // Show the spinner activity on screen with custom font, if visible only update the title
    // Note that the custom font will be discarded when hiding the spinner
    // To permanently change the title font, set the defaultTitleFont property
    //
    public func update(title: String, withFont font: UIFont, animated: Bool = true) {
        titleLabel.font = font
        update(title, animated: true)
    }
    
    //
    // The spinner title
    //
    public var title: String = "" {
        didSet {
            UIView.animateWithDuration(0.15, delay: 0.0, options: .CurveEaseOut, animations: {
                self.titleLabel.transform = CGAffineTransformMakeScale(0.75, 0.75)
                self.titleLabel.alpha = 0.2
                }, completion: {_ in
                    self.titleLabel.text = self.title
                    UIView.animateWithDuration(0.35, delay: 0.0, usingSpringWithDamping: 0.35, initialSpringVelocity: 0.0, options: nil, animations: {
                        self.titleLabel.transform = CGAffineTransformIdentity
                        self.titleLabel.alpha = 1.0
                        }, completion: nil)
            })
        }
    }
    
    //
    // Start the spinning animation
    //
    
    public var animating: Bool = false {
        
        willSet (shouldAnimate) {
            if shouldAnimate && !animating {
                spinInner()
                spinOuter()
            }
        }
        
        didSet {
            // update UI
            if animating {
                self.outerCircle.strokeStart = 0.0
                self.outerCircle.strokeEnd = 0.45
                self.innerCircle.strokeStart = 0.5
                self.innerCircle.strokeEnd = 0.9
            } else {
                self.outerCircle.strokeStart = 0.0
                self.outerCircle.strokeEnd = 1.0
                self.innerCircle.strokeStart = 0.0
                self.innerCircle.strokeEnd = 1.0
            }
        }
    }
    
    // MARK: - Private interface
    
    lazy var titleLabel = UILabel()
    var defaultTitleFont = UIFont(name: "HelveticaNeue", size: 18.0)
    let frameSize = CGSize(width: 136.0, height: 136.0)
    
    private lazy var outerCircleView = UIView()
    private lazy var innerCircleView = UIView()
    
    private let outerCircle = CAShapeLayer()
    private let innerCircle = CAShapeLayer()
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("Not coder compliant")
    }
    
    private var currentOuterRotation: CGFloat = 0.0
    private var currentInnerRotation: CGFloat = 0.1
    
    private func spinOuter() {
        
        if superview == nil {
            return
        }
        
        let duration = Double(Float(arc4random()) /  Float(UInt32.max)) * 2.0 + 1.5
        let randomRotation = Double(Float(arc4random()) /  Float(UInt32.max)) * M_PI_4 + M_PI_4
        
        //outer circle
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: nil, animations: {
            self.currentOuterRotation -= CGFloat(randomRotation)
            self.outerCircleView.transform = CGAffineTransformMakeRotation(self.currentOuterRotation)
            }, completion: {_ in
                let waitDuration = Double(Float(arc4random()) /  Float(UInt32.max)) * 1.0 + 1.0
                self.delay(seconds: waitDuration, completion: {
                    if self.animating {
                        self.spinOuter()
                    }
                })
        })
    }
    
    private func spinInner() {
        if superview == nil {
            return
        }
        
        //inner circle
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: nil, animations: {
            self.currentInnerRotation += CGFloat(M_PI_4)
            self.innerCircleView.transform = CGAffineTransformMakeRotation(self.currentInnerRotation)
            }, completion: {_ in
                self.delay(seconds: 0.5, completion: {
                    if self.animating {
                        self.spinInner()
                    }
                })
        })
    }
    
    // MARK: - Util methods
    
    func delay(#seconds: Double, completion:()->()) {
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
        
        dispatch_after(popTime, dispatch_get_main_queue()) {
            completion()
        }
    }
    
}
