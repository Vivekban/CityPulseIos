	//
//  DetailIssueController.swift
//  MyVoice
//
//  Created by PB014 on 03/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class DetailIssueController: BaseImageDetailViewController {
    
    let addResponseSectionIndex = 4
    
    let responseIdentifier = "responseSection"

    var responseSectionHeight:CGFloat = 0
    
    
    var responses:[ResponseData] = [ResponseData]()
    var responsesView:UIView?
    var responsesController:ResponseConroller?
    
    weak var postResponseField :UITextView!
    
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        baseDetailHeight = 600
        numberOfSection = 5
        
        containerTableView.registerClass(ResponseConroller.self, forCellReuseIdentifier: responseIdentifier)

        
        for i in 1...1 {
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
        
        responseSectionHeight = -1
//
        for i in 0...1 {
            let comnt = ResponseData()
            comnt.description = "This is descption of reponse number \(i)"
            comnt.disPlayDate = TimeDateUtils.getShortDateInString(NSDate())
            comnt.ownerName = "Response \(i)"
            comnt.ownerArea = "Sirsa \(i)"
            
             comnt.reply = [CommentData]()
                        for j in 1...1 {
                            let scomnt = CommentData()
                            scomnt.description = "This is descption of sub comment number \(j)"
                            scomnt.disPlayDate = TimeDateUtils.getShortDateInString(NSDate())
                            scomnt.ownerName = "Sub Name \(j)"
                            scomnt.ownerArea = "Sub Sirsa \(j)"
                            comnt.reply?.append(scomnt)
                        }
            responses.append(comnt)
        }
        
        //     commentController?.updateComments(comments)
        
//        responsesView = view.viewWithTag(1000)
//                if responsesView != nil {
//                    responsesController = ResponseConroller(frame: CGRectMake(0, 0, (responsesView?.frame.width)!, (responsesView?.frame.height)!), data: responses)
//                    responsesView!.addSubview(responsesController!)
//                }
        // Do any additional setup after loading the view.
        
        
       
        
    }
    
    
    
    override func fetchMoreDetailFromServer() {
        ServerRequestInitiater.i.postMessageToServerForJsonResponse(ServerUrls.getIssueByIdUrl, postData: ["issueid": "1"]) { (r) -> Void in
            switch r {
            case .Success(let data):
                if let d = data {
                    print(d)
                }
                break
            case .Failure(let error):
                print(error)
                break
            default :
                break
            }
            
        }
        
        
    }
    
    override func getCellIdentifier(indexPath: NSIndexPath) -> String {
        switch (indexPath.section) {
        case addResponseSectionIndex :
            return addCellIdentifier
        case reponseSectionIndex:
            return responseIdentifier
        default:
            return super.getCellIdentifier(indexPath)
        }
    }
    
    override func configureCell(cell: UITableViewCell, forRowAtIndexPath: NSIndexPath) {
        if forRowAtIndexPath.section == reponseSectionIndex {
            if let c = cell as? ResponseConroller {
                c.updateComments(responses)
                responseSectionHeight = c.tableView.contentSize.height

//                if ( responseSectionHeight != c.tableView.contentSize.height ){
//                    containerTableView.reloadSections(NSIndexSet(index: 2), withRowAnimation: UITableViewRowAnimation.Automatic)
//                }
            }
        }
        else if forRowAtIndexPath.section == addResponseSectionIndex {
            if let c = cell as? PostCommentCell {
                c.setDelegate(self)
                c.setWidthOfCell(cell.frame.width)
                c.postView.type = PostCommentType.Response
                c.postView.descriptionField.delegate = self
                postResponseField = c.postView.descriptionField
            }

        }
        else{
            super.configureCell(cell, forRowAtIndexPath: forRowAtIndexPath)
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch (indexPath.section) {
        case addResponseSectionIndex :
            return Constants.addCommentViewHeight
        case reponseSectionIndex:
            return responseSectionHeight
        default:
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func changeInTableElement(notification: NSNotification){
        if let e = notification.object as? ResponseConroller {
            responseSectionHeight = e.tableView.contentSize.height
            containerTableView.reloadSections(NSIndexSet(index: reponseSectionIndex), withRowAnimation: UITableViewRowAnimation.Automatic)
            return
        }
        super.changeInTableElement(notification)
    }
    
    
//    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        if section == reponseSectionIndex || section == addResponseSectionIndex{
//            return 0
//        }
//        else{
//          return  super.tableView(tableView, heightForFooterInSection: section)
//        }
//    }
    
    //    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //
    //    }
    
//    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
////        if section == reponseSectionIndex {
////            
////            
////        }
////        else {
//            return super.tableView(tableView, viewForFooterInSection : section)
//            // }
//    }

    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // for partion between comments and response
        if section == reponseSectionIndex {
        return 45
        }
        return 0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let container = UIView()
        let view = UIView(frame: CGRect(x: BaseDetailViewController.leftSideOffset, y: 15, width: (tableView.frame.width) - BaseDetailViewController.leftSideOffset - 20, height: 1))
        view.backgroundColor = Constants.grayColor_217
        container.addSubview(view)
        return container
        
    }
    
    
    func onResponseAdd(data : String){
        let comnt = ResponseData()
        comnt.description = data
        comnt.initWithOwner(CurrentSession.i.personController.person.basicInfo)
        responses.append(comnt)
        responsesController?.addComment(comnt)
        // EventUtils.postNotification(EventUtils.changeInTableViewElement, object: reposnse)

    }
    
    override func onPostCommentClic(data: String, view: PostCommentView) {
        guard let d = self.data as? IssueData else {
            log.error("in valid data")
            return
        }
        
        if view.type == .Response {
            let obj = PostCommentData()
            obj.userid = CurrentSession.i.userId
            obj.comment = data
            obj.issueid = d.id
            
            let param =  MyUtils.appendKayToJSONString(obj.toJSONString() ?? "")
            
            print(param)
            
          let req = ServerRequest(url: ServerUrls.resposeIssueUrl, postData: ["json" : param], completionHandler: {[weak self] (result) -> Void in
                
                guard let s = self else{
                    return
                }
                print(result)
                switch (result) {
                case .Success( _):
                    s.onResponseAdd(data)
                    break
                case .Failure( _):
                     UIAlertUtils.createTryAgainWithCancelAlertFor(s, with: MyStrings.unableToPostResponse, tryAgainHandler: { (action) -> Void in
                        let v = PostCommentView()
                        v.type = .Response
                        s.onPostCommentClic(data, view: v)
                     })
                    break
                default:
                    break;
                  }
                })
            req.retryCount = 3
            ServerRequestInitiater.i.initiateServerRequest(req)
        }
            
        super.onPostCommentClic(data, view: view)
        
    }


}
