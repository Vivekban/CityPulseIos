//
//  DescriptionView.swift
//  MyVoice
//
//  Created by PB014 on 09/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class DescriptionView: UIView {
    
    
    
    @IBOutlet weak var textView: FloatLabelTextView!
    
    
    var text :String {
        set(newText){
            textView.text = newText
        }
        
        get {
            return textView.text
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        // text = ""
        super.init(coder: aDecoder)
        initView()
    }
    
    func initView(){
        let view = NSBundle.mainBundle().loadNibNamed("DescriptionView", owner: self, options: nil)[0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGrayColor().CGColor
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
}
