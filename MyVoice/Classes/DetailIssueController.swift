    //
    //  DetailIssueController.swift
    //  MyVoice
    //
    //  Created by PB014 on 03/02/16.
    //  Copyright © 2016 Vivek. All rights reserved.
    //
    
    import UIKit
    import ObjectMapper
    import SwiftyJSON
    
    class DetailIssueController: BaseImageDetailViewController {
        
        let addResponseSectionIndex = 4
        
        let responseIdentifier = "responseSection"
        
        var responseSectionHeight:CGFloat = 0
        
        var responsesView:UIView?
        var responsesController:ResponseConroller?
        
        // weak var postResponseField :UITextView!
        
        // Height of add response section...it change as size of comment changes
        private var addResponseHeight = Constants.addCommentViewHeight;
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            baseDetailHeight = 590
            numberOfSection = 5
            
            containerTableView.registerClass(ResponseConroller.self, forCellReuseIdentifier: responseIdentifier)
            
            
            //            for i in 1...1 {
            //                let comnt = CommentData()
            //                comnt.description = "This is descption of comment number \(i)"
            //                comnt.disPlayDate = TimeDateUtils.getShortDateInString(NSDate())
            //                comnt.ownerName = "Name \(i)"
            //                comnt.ownerArea = "Sirsa \(i)"
            //
            //                comnt.reply = [CommentData]()
            //
            //                //                        for j in 1..<2 {
            //                //                            let scomnt = CommentData()
            //                //                            scomnt.description = "This is descption of sub comment number \(j)"
            //                //                            scomnt.disPlayDate = TimeDateUtils.getShortDateInString(NSDate())
            //                //                            scomnt.ownerName = "Sub Name \(j)"
            //                //                            scomnt.ownerArea = "Sub Sirsa \(j)"
            //                //                            comnt.reply?.append(scomnt)
            //                //                        }
            //                comments.append(comnt)
            //            }
            
            responseSectionHeight = -1
            //
            //            for _ in 0..<1 {
            //                let comnt = ResponseData()
            //                comnt.description = "I feel sorry to hear the inconvenience you have been facing. The park fall under our jurisdiction and I will make sure to send somebody from our department to inspect it at he earliest. We are here for you and incase you want to report something directly, please email us at parkdeptt@ca.gov "
            //                comnt.disPlayDate = TimeDateUtils.getShortDateInString(NSDate())
            //                comnt.ownerName = "Margaret"
            //                comnt.ownerArea = "California"
            //
            //                comnt.reply = [CommentData]()
            //                for j in 1..<1 {
            //                    let scomnt = CommentData()
            //                    scomnt.description = "This is descption of sub comment number \(j)"
            //                    scomnt.disPlayDate = TimeDateUtils.getShortDateInString(NSDate())
            //                    scomnt.ownerName = "Sub Name \(j)"
            //                    scomnt.ownerArea = "Sub Sirsa \(j)"
            //                    comnt.reply?.append(scomnt)
            //                }
            //                responses.append(comnt)
            //            }
            
            //     commentController?.updateComments(comments)
            
            //        responsesView = view.viewWithTag(1000)
            //                if responsesView != nil {
            //                    responsesController = ResponseConroller(frame: CGRectMake(0, 0, (responsesView?.frame.width)!, (responsesView?.frame.height)!), data: responses)
            //                    responsesView!.addSubview(responsesController!)
            //                }
            // Do any additional setup after loading the view.
            
            
            containerTableView.tableHeaderView?.frame.size.height = 1
        }
        
//        override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//            return CGFloat.min
//        }
        
        override func fetchMoreDetailFromServer() {
            
            guard let d = data as? IssueData  else {return}
            
            ServerRequestInitiater.i.postMessageToServerForJsonResponse(ServerUrls.getIssueDetails, postData: ["id": "\(d.id)","getby": "issue","userid": "\(CurrentSession.i.userId)"]) { [weak self](r) -> Void in
                switch r {
                case .Success(let data):
                   
                    self?.onServerResponse(data)
                    
                    break
                case .Failure(let error):
                    print(error)
                    break
                default :
                    break
                }
            }
            
            
        }
        
        func onServerResponse(data: AnyObject?){
            guard let d = data else {return}
            print(d)
            let viewArray = JSON(d)
            for (_,obj) in viewArray {
                if let finalString = obj.rawString() {
                    // print(" value is \(i)...+....\(finalString)")
                    if let view = Mapper<IssueData>().map(finalString) {
                        self.data?.update(view)
                        //self.responseSectionHeight = -1
                        self.containerTableView.reloadData()
                        // self.containerTableView.reloadSections(NSIndexSet(index: responseSectionIndex), withRowAnimation: UITableViewRowAnimation.Automatic)
                    }
                }
            }

        }
        
        override func getCellIdentifier(indexPath: NSIndexPath) -> String {
            switch (indexPath.section) {
            case addResponseSectionIndex :
                return addCellIdentifier
            case responseSectionIndex:
                return responseIdentifier
            default:
                return super.getCellIdentifier(indexPath)
            }
        }
        
        override func configureCell(cell: UITableViewCell, forRowAtIndexPath: NSIndexPath) {
            if forRowAtIndexPath.section == responseSectionIndex {
                if let c = cell as? ResponseConroller {

                    guard let d = data as? IssueData else{
                        return
                    }
                    
                    if d.response != nil {
                        c.updateComments(d.response!)
                        c.hidden = false
                    }
                    else{
                        c.hidden = true
                    }
                    responsesController = c
                    responsesController?.delegate = self

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
                    
                    // c.postView.delegate = self
                    // postResponseField = c.postView.descriptionField.textView
                }
                
            }
            else{
                super.configureCell(cell, forRowAtIndexPath: forRowAtIndexPath)
            }
        }
        
        override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            switch (indexPath.section) {
            case addResponseSectionIndex :
                return addResponseHeight
            case responseSectionIndex:
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
                updateTableSize()
                //containerTableView.reloadSections(NSIndexSet(index: responseSectionIndex), withRowAnimation: UITableViewRowAnimation.Automatic)
                return
            }
            super.changeInTableElement(notification)
        }
        
        
        
        //        func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //            // for partion between comments and response
        //            if section == responseSectionIndex {
        //                return 0
        //            }
        //            return 0
        //        }
        //
        //        func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //            let container = UIView()
        //            container.backgroundColor = UIColor.whiteColor()
        //            let view = UIView(frame: CGRect(x: BaseDetailViewController.leftSideOffset, y: 15, width: (tableView.frame.width) - BaseDetailViewController.leftSideOffset - 20, height: 1))
        //            view.backgroundColor = Constants.grayColor_217
        //            container.addSubview(view)
        //            return container
        //
        //        }
        
        
        func onResponseAdd(data : PostCommentData){
            let comnt = ResponseData()
            comnt.initWithPostCommentData(data)
            comnt.initWithOwner(CurrentSession.i.personController.person.basicInfo)
            
            guard let d = self.data as? IssueData else{
                return
            }
            
            d.response?.append(comnt)
            responsesController?.updateComments(d.response!)
            responseSectionHeight = (responsesController?.tableView.contentSize.height) ?? responseSectionHeight
            updateTableSize()
            // containerTableView.reloadSections(NSIndexSet(index: responseSectionIndex), withRowAnimation: UITableViewRowAnimation.Automatic)
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
                let m = obj.isReadyToSave()
                if !m.isEmpty {
                    UIAlertUtils.createOkAlertFor(self, with: m)
                    return
                }
                
                let param =  MyUtils.appendKayToJSONString(obj.toJSONString() ?? "")
                
                postMessageToServer(param, completionHandler: {[weak self] (result) -> Void in
                    
                    LoaderUtils.i.hideLoader()
                    
                    guard let s = self else{
                        return
                    }
                    print(result)
                    switch (result) {
                    case .Success(let d):
                        print(d)
                        obj.id = Int(d! as! NSNumber)
                        s.onResponseAdd(obj)
                        view.descriptionField.text = ""
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
                
                
            }
            
            super.onPostCommentClic(data, view: view)
            
        }
        
        override func onPostCommentHeightChange(height: CGFloat,  view : PostCommentView) {
            
            if view.type == .Response{
                addResponseHeight = height
                
            }
            super.onPostCommentHeightChange(height, view: view)
            //containerTableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: addResponseSectionIndex)], withRowAnimation: UITableViewRowAnimation.Automatic)
            
        }
        
        
        override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//            if  section == addResponseSectionIndex{
//                tableView.footerViewForSection(section)?.hidden = true
//                return 0
//            }
//            else{
                return super.tableView(tableView, heightForFooterInSection: section)
            //           }
            
        }
        
        
        override func getHeightForFooterInSection(section: Int) -> CGFloat {
            guard let d = data as? IssueData else{
                return 20
            }
            
            switch (section) {
            case responseSectionIndex:
                return 0 //(d.response == nil || d.response?.count == 0) ? 0 : 20
            case addResponseSectionIndex :
                return  0
            default:
                return super.getHeightForFooterInSection(section)
                
            }
            
            
        }
        
        
        //    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        //        if section == responseSectionIndex || section == addResponseSectionIndex{
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
        ////        if section == responseSectionIndex {
        ////
        ////
        ////        }
        ////        else {
        //            return super.tableView(tableView, viewForFooterInSection : section)
        //            // }
        //    }
        
    }
