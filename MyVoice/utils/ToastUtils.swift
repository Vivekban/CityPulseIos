//
//  ToastUtils.swift
//  MyVoice
//
//  Created by PB014 on 18/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class ToastUtils {

    
   static func displayToastWith(message : String , time : Double = 3){
        
        
        let toast =    UIAlertView(title: nil, message: message, delegate: nil, cancelButtonTitle: nil)
        toast.show()
        
        
        MyUtils.delay(time) { () -> () in
            toast.dismissWithClickedButtonIndex(0, animated: true)
        }
        
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
