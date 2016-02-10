//
//  FloatingTextLabel.swift
//  MyVoice
//
//  Created by PB014 on 10/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

@IBDesignable class FloatingTextLabel: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    @IBInspectable var fontSize:CGFloat = 0.0 {
        didSet {
            titleField.font = UIFont.systemFontOfSize(fontSize)

        }
    }
    
    @IBInspectable var floatFontSize:CGFloat = 0.0 {
        didSet {
            titleField.title.font = UIFont.systemFontOfSize(fontSize)
        }
    }
    
    
    
    var text : String {
        didSet{
            titleField.text = text
        }
    }
    
    
    @IBOutlet weak var titleField: FloatLabelTextField!
    
    
    required init?(coder aDecoder: NSCoder) {
        text = ""
        super.init(coder: aDecoder)
        
        let view = NSBundle.mainBundle().loadNibNamed("FloatingTextLabel", owner: self, options: nil)[0] as!UIView
        view.frame = self.frame
        addSubview(view)
    }
    
    
    

}
