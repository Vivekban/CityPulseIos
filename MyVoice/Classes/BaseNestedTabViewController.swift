//
//  BaseNestedTabViewController.swift
//  MyVoice
//
//  Created by PB014 on 28/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit


class BaseNestedTabViewController :UIViewController{

}

extension BaseNestedTabViewController : BaseNestedTabProtocoal{
   
    
    func onActionButtonClick(sender: AnyObject) {
        
    }
}

class BaseNestedTabCollectionViewController : UICollectionViewController{
    
}



class BaseNestedTabTableViewController : UITableViewController{
    
}

extension BaseNestedTabTableViewController : BaseNestedTabProtocoal{
    
    
    func onActionButtonClick(sender: AnyObject) {
        
    }
}


protocol BaseNestedTabProtocoal{
    
    func onActionButtonClick(sender: AnyObject)
    
}
