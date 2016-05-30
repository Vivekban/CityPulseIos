//
//  PaddingLabel.swift
//  MyVoice
//
//  Created by PB014 on 25/05/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import Foundation


@IBDesignable class PaddingLabel: UILabel {
    
    @IBInspectable var topInset:       CGFloat = 0 {
        didSet{
            setNeedsLayout()
        }
    }
    @IBInspectable var rightInset:     CGFloat = 0{
        didSet{
            setNeedsLayout()
        }
    }

    @IBInspectable var bottomInset:    CGFloat = 0{
        didSet{
            setNeedsLayout()
        }
    }

    @IBInspectable var leftInset:      CGFloat = 0{
        didSet{
            setNeedsLayout()
        }
    }

    
    override func drawTextInRect(rect: CGRect) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: self.topInset, left: self.leftInset, bottom: self.bottomInset, right: self.rightInset)
        self.setNeedsLayout()
        return super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
    }
    
    
    // Override -intrinsicContentSize: for Auto layout code
    override func intrinsicContentSize() -> CGSize {
        let superContentSize = super.intrinsicContentSize()
        let width = superContentSize.width + leftInset + rightInset
        let heigth = superContentSize.height + topInset + bottomInset
        return CGSize(width: width, height: heigth)
    }
    
    // Override -sizeThatFits: for Springs & Struts code
    override func sizeThatFits(size: CGSize) -> CGSize {
        let superSizeThatFits = super.sizeThatFits(size)
        let width = superSizeThatFits.width + leftInset + rightInset
        let heigth = superSizeThatFits.height + topInset + bottomInset
        return CGSize(width: width, height: heigth)
    }
    
}