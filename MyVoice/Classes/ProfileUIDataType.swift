//
//  ProfileUIDataType.swift
//  MyVoice
//
//  Created by PB014 on 19/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

struct ImageWithIndex {
    var index = 0
    var image:UIImage!
    
    init(indx : Int , image : UIImage){
        self.index = indx
        self.image = image
    }
}
