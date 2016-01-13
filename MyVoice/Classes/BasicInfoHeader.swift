//
//  BasicInfoHeader.swift
//  MyVoice
//
//  Created by PB014 on 28/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit

class BasicInfoHeader: UICollectionReusableView {
    //MARK: Properties
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var arrow: UILabel!
    
    var delegate:BasicInfoHeaderDelegate?
    
    var currentAngle = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: "onViewClick"))
    }
    
    func onViewClick(){
        delegate?.onHeaderClick(self)
    }
    
    @IBAction func onEditButtonClick(sender: UIButton) {
        delegate?.onEditButtonclick(self)
        print(sender.tag)
    }
    
    func updateArrowLabel(isExpanded: Bool){
            if let a = arrow {
                print("Animating................\(isExpanded)..........")
                a.layer.removeAllAnimations()
                if isExpanded && currentAngle != 0{
                    UIView.animateWithDuration(0.4, animations: { () -> Void in
                        a.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
                    })
                    currentAngle = 0
                }
                else if !isExpanded && currentAngle != 1{
                    UIView.animateWithDuration(0.4, animations: { () -> Void in
                        a.transform = CGAffineTransformMakeRotation(CGFloat(0))
                    })
                    currentAngle = 1
                }
            }
    }
    
}

protocol BasicInfoHeaderDelegate {
    func onHeaderClick(sender : BasicInfoHeader)
    func onEditButtonclick(sender : BasicInfoHeader)
}
