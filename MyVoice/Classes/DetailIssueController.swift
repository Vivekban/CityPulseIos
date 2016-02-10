//
//  DetailIssueController.swift
//  MyVoice
//
//  Created by PB014 on 03/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class DetailIssueController: BaseImageDetailViewController {
    
    let responseIdentifier = "responseSection"
    var responseSectionHeight:CGFloat = 0
    
    
    var responses:[ResponseData] = [ResponseData]()
    var responsesView:UIView?
    var responsesController:ResponseConroller?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseDetailHeight = 600
        numberOfSection = 3
        
        tableView.registerClass(ResponseConroller.self, forCellReuseIdentifier: responseIdentifier)
        
        
        for i in 1...2 {
            let comnt = CommentData()
            comnt.description = "This is descption of comment number \(i)"
            comnt.disPlayDate = TimeDateUtils.getShortDateInString(NSDate())
            comnt.ownerName = "Name \(i)"
            comnt.ownerArea = "Sirsa \(i)"
            
            comnt.reply = [CommentData]()
            
            for j in 1..<2 {
                let scomnt = CommentData()
                scomnt.description = "This is descption of sub comment number \(j)"
                scomnt.disPlayDate = TimeDateUtils.getShortDateInString(NSDate())
                scomnt.ownerName = "Sub Name \(j)"
                scomnt.ownerArea = "Sub Sirsa \(j)"
                comnt.reply?.append(scomnt)
            }
            comments.append(comnt)
        }
        
        for i in 1...3 {
            let comnt = ResponseData()
            comnt.description = "This is descption of reponse number \(i)"
            comnt.disPlayDate = TimeDateUtils.getShortDateInString(NSDate())
            comnt.ownerName = "Response \(i)"
            comnt.ownerArea = "Sirsa \(i)"
            
            // comnt.reply = [CommentData]()
            //            for j in 1...2 {
            //                let scomnt = CommentData()
            //                scomnt.description = "This is descption of sub comment number \(j)"
            //                scomnt.date = MyUtils.getShortDateInString(NSDate())
            //                scomnt.ownerName = "Sub Name \(j)"
            //                scomnt.ownerArea = "Sub Sirsa \(j)"
            //                comnt.reply?.append(scomnt)
            //            }
            responses.append(comnt)
        }
        
        commentController?.updateComments(comments)
        
        responsesView = view.viewWithTag(1000)
        //        if responsesView != nil {
        //            responsesController = ResponseConroller(frame: CGRectMake(0, 0, (responsesView?.frame.width)!, (responsesView?.frame.height)!), data: responses)
        //            responsesView!.addSubview(responsesController!)
        //        }
        // Do any additional setup after loading the view.
    }
    
    
    
    override func fetchMoreDetailFromServer() {
        ServerRequestInitiater.i.postMessageToServer(ServerUrls.getIssueByIdUrl, postData: ["issueid": "1"]) { (r) -> Void in
            switch r {
            case .Success(let data):
                if let d = data {
                    print(d)
                }
                break
            case .Failure(let error):
                print(error)
                
            }
            
        }
        
        
    }
    
    override func getCellIdentifier(indexPath: NSIndexPath) -> String {
        switch (indexPath.section) {
        case 2:
            return responseIdentifier
        default:
            return super.getCellIdentifier(indexPath)
        }
    }
    
    override func configureCell(cell: UITableViewCell, forRowAtIndexPath: NSIndexPath) {
        if forRowAtIndexPath.section == 2 {
            if let c = cell as? ResponseConroller {
                c.updateComments(responses)
                if ( responseSectionHeight != c.tableView.contentSize.height ){
                    responseSectionHeight = c.tableView.contentSize.height
                    tableView.reloadSections(NSIndexSet(index: 2), withRowAnimation: UITableViewRowAnimation.Automatic)
                }
            }
        }
        else{
            super.configureCell(cell, forRowAtIndexPath: forRowAtIndexPath)
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch (indexPath.section) {
        case 2:
            return responseSectionHeight
        default:
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
