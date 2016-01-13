//
//  OneOrientaionImagePickerController.swift
//  MyVoice
//
//  Created by PB014 on 11/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class OneOrientaionImagePickerController: UIImagePickerController {
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
//    override func shouldAutorotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation) -> Bool {
//        return UIInterfaceOrientationIsLandscape(toInterfaceOrientation)
//    }
//    

   
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Landscape;

    }
   
}
