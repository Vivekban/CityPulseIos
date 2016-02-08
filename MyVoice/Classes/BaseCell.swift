//
//  BaseCell.swift
//  MyVoice
//
//  Created by PB014 on 07/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell , DataBinding{

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        // MyUtils.createShadowOnView(self)
    }
    
    func bindValues(model : AnyObject){
        
    }

}


protocol DataBinding{
    func bindValues(model : AnyObject);
}