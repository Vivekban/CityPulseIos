//
//  SecondPersonProfileViewController.swift
//  MyVoice
//
//  Created by PB014 on 23/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class SecondPersonProfileViewController: ProfileViewController {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func didMoveToPage(controller: UIViewController, index: Int) {
        changeVisibilityOfActionButton(false)
    }

}
