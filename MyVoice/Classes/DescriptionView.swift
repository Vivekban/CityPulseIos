//
//  DescriptionView.swift
//  MyVoice
//
//  Created by PB014 on 09/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class DescriptionView: UIView {
    
    private var  heightConstraint:NSLayoutConstraint!
    private var  minHeightConstraint:NSLayoutConstraint!
    private var  maxHeightConstraint:NSLayoutConstraint!
    
    
    weak var textView: FloatLabelTextView!
    
    
    var text :String {
        set(newText){
            textView.text = newText
        }
        
        get {
            return textView.text
        }
    }
    
    var hint:String = ""{
        didSet {
            textView.hint = self.hint
        }
    }
    
   weak var delegate:UITextViewDelegate?{
        didSet{
            textView.delegate = delegate
        }
    }
    
    weak var sizeDelegate : TextViewSizeChangeDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        // text = ""
        super.init(coder: aDecoder)
        initView()
    }
    
    func initView(){
        let view = NSBundle.mainBundle().loadNibNamed("DescriptionView", owner: self, options: nil)[0] as! UIView
        textView = view.viewWithTag(1) as! FloatLabelTextView
        textView.sizeChangeDelegate = self
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.frame = self.frame
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        pinViewOnAllDirection(view)

        
        // layer.borderWidth = 1
        // layer.borderColor = UIColor.lightGrayColor().CGColor
        associateConstraints()
    }
    
    
    
    func associateConstraints(){
        // iterate through all text view's constraints and identify
        // height, max height and min height constraints.
        
        for constraint in self.constraints{
            if (constraint.firstAttribute == NSLayoutAttribute.Height) {
                
                if (constraint.relation == NSLayoutRelation.Equal) {
                    self.heightConstraint = constraint;
                }
                    
                else if (constraint.relation == NSLayoutRelation.LessThanOrEqual) {
                    self.maxHeightConstraint = constraint;
                }
                    
                else if (constraint.relation == NSLayoutRelation.GreaterThanOrEqual) {
                    self.minHeightConstraint = constraint;
                }
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
}

extension DescriptionView : TextViewSizeChangeDelegate {
    func heightChange(newHeight: CGFloat) {
        
        print("new height is \(newHeight)")
        
        if heightConstraint != nil {
            self.heightConstraint.constant = newHeight
        }
        layoutIfNeeded()
        sizeDelegate?.heightChange(newHeight)
    }
}
