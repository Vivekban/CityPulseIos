//
//  ProfileStructs.swift
//  MyVoice
//
//  Created by PB014 on 11/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit


class MyWork {
    
    var title:String = ""
    var date:Double = MyUtils.getCurrentDateInlong()
    var description:String = ""
    var imagesUrl = [String]()
    
}

class MyWorkUI:MyWork {
    var images = [UIImage]()
    
    override init() {
        super.init()
    }
    
    init(work: MyWork){
        super.init()
        self.title = work.title
        self.date = work.date
        self.description = work.description
        self.imagesUrl = work.imagesUrl
    }
}

class EditInfoData {
    var type = 0
    
    init(type: Int){
        self.type = type
    }
    
}