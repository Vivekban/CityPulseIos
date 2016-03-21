//
//  TopImageUIButton.swift
//  MyVoice
//
//  Created by PB014 on 14/03/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class TopImageUIButton: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let imageView = self.imageView {
            imageView.frame.origin.x = (self.bounds.size.width - imageView.frame.size.width) / 2.0
            imageView.frame.origin.y = (self.bounds.size.height - imageView.frame.size.height) / 2.0 - 4

        }
        titleLabel?.sizeToFit()
        if let titleLabel = self.titleLabel {
            titleLabel.frame.origin.x = (self.bounds.size.width - titleLabel.frame.size.width) / 2.0
            titleLabel.frame.origin.y = (self.bounds.size.height + titleLabel.frame.size.height) / 2.0 + 4
        }
    }

}
