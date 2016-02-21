//
//  ResponseConroller.swift
//  MyVoice
//
//  Created by PB014 on 05/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit


class ResponseConroller: CommentController {
    
    
    override func registerClassForTableView() {
        super.registerClassForTableView()
        tableView.registerClass(ResponseCell.self, forCellReuseIdentifier: "rCell")
    }
    
    override func getCellIdentifier(indexPath: NSIndexPath) -> String{
        if indexPath.row == 0 {
            return "rCell"
        }
        else {
            return super.getCellIdentifier(indexPath)
        }
    }
}