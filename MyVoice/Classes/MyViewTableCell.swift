//
//  MyViewTableCell.swift
//  MyVoice
//
//  Created by PB014 on 30/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit

class MyViewTableCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var arrowLabel: UILabel!
    
    @IBOutlet weak var heading: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var header: UIView!
    
    @IBOutlet weak var dateField: UILabel!

    var isExpanded = true{
        didSet{
            updateArrowLabel()
        }
    }
   
    
    weak var touchDelegate:ListHeaderDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("onHeaderClick:"))
        header.addGestureRecognizer(tapGesture)
        // to extend in case of more
        let tapGesture2 = UITapGestureRecognizer(target: self, action: Selector("onDetailLabelClick:"))
        detailLabel.addGestureRecognizer(tapGesture2)
        detailLabel.lineBreakMode = .ByWordWrapping
        
    }
    
    
    func onHeaderClick(gesture: UIGestureRecognizer){
        //        if isExpanded {
        //            detailLabel.removeFromSuperview()
        //        }
        //        else{
        //            addSubview(detailLabel)
        //        }
    
        touchDelegate?.onHeaderClick(self.tag)
    }
    
    func onDetailLabelClick(gesture : UIGestureRecognizer){
        if detailLabel.numberOfLines > 0 {
            detailLabel.numberOfLines = 0
        }
        else{
            detailLabel.numberOfLines = 6
        }
        touchDelegate?.onDetailClick(self.tag)
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //MARK: Actions
    
    @IBAction func onEditButtonClick(sender: UIButton) {
        touchDelegate?.onEditButtonclick(self.tag)
    }
    
    func updateArrowLabel(){
        if let a = arrowLabel {
            print("Animating................\(isExpanded)..........")
            a.layer.removeAllAnimations()
            if isExpanded {
                UIView.animateWithDuration(1, animations: { () -> Void in
                    a.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
                })
            }
            else{
                UIView.animateWithDuration(1, animations: { () -> Void in
                    a.transform = CGAffineTransformMakeRotation(CGFloat(0))
                })
                
            }
        }
    }
}








