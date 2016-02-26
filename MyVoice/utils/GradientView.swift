//
//  GradientView.swift
//  MyVoice
//
//  Created by PB014 on 21/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable public class GradientView: UIView {
    @IBInspectable public var topColor: UIColor? {
        didSet {
            configureGradientView()
        }
    }
    @IBInspectable public var bottomColor: UIColor? {
        didSet {
            configureGradientView()
        }
    }
    @IBInspectable public var middleColor: UIColor? {
        didSet {
            configureGradientView()
        }
    }
    @IBInspectable var startX: CGFloat = 0.0 {
        didSet{
            configureGradientView()
        }
    }
    @IBInspectable var startY: CGFloat = 1.0 {
        didSet{
            configureGradientView()
        }
    }
    @IBInspectable var endX: CGFloat = 0.0 {
        didSet{
            configureGradientView()
        }
    }
    @IBInspectable var endY: CGFloat = 0.0 {
        didSet{
            configureGradientView()
        }
    }
    override public class func layerClass() -> AnyClass {
        return CAGradientLayer.self
    }
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        configureGradientView()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureGradientView()
    }
    public override func tintColorDidChange() {
        super.tintColorDidChange()
        configureGradientView()
    }
    func configureGradientView() {
        let color1 = topColor ?? self.tintColor as UIColor
        let color2 = middleColor ?? self.tintColor as UIColor
        let color3 = bottomColor ?? UIColor.blackColor() as UIColor
        let colors: Array <AnyObject> = [ color1.CGColor, color2.CGColor,color2.CGColor, color3.CGColor ]
        let layer = self.layer as! CAGradientLayer
        layer.colors = colors
        layer.locations = [0.0,0.45,0.55,1.0]
        layer.startPoint = CGPointMake(startX, startY)
        layer.endPoint = CGPointMake(endX, endY)
    }
}