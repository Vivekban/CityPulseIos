//
//  CommentController.swift
//  MyVoice
//
//  Created by PB014 on 04/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

protocol CommentControllerDelegate : class {
    func postCommentOnComment(controller : CommentController,parent: CommentData, info : PostCommentData)
    func editComment(controller : CommentController, info: CommentCell)

}

class CommentController : UITableViewCell {
    var tableView: UITableView!
    var expandedRows = Set<Int>()
    var comments: [CommentData] = [CommentData]()
    var level = 0
    
    var isShowFooter = -1
    
    var footerHeight = Constants.addCommentViewHeight;
    
    weak var delegate : CommentControllerDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViews()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
    }
    
    func initViews(){
        tableView = UITableView(frame: CGRectMake(105, 0, self.frame.width - 105 - 20, self.frame.height))
        // tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorColor = UIColor.clearColor()
        tableView.rowHeight = 210
        tableView.delegate = self
        tableView.dataSource = self
        tableView.scrollEnabled = false
        tableView.canCancelContentTouches = false
        tableView.delaysContentTouches = false
        tableView.allowsSelection = false
        //table.registerClass(CommentController.self, forHeaderFooterViewReuseIdentifier: "footer")
        registerClassForTableView()
        addSubview(tableView)
        
    }
    
    func updateComments(data : [CommentData]){
        comments.removeAll()
        comments.appendContentsOf(data)
        tableView.reloadData()
        tableView.frame.size.height = tableView.contentSize.height
        tableView.frame.size.width = self.frame.width - 105 - 55
        
        
    }
    
    func addComment(data : CommentData){
        comments.append(data)
        tableView.reloadData();//insertRowsAtIndexPaths([NSIndexPath(forRow: comments.count - 1, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
        EventUtils.postNotification(EventUtils.changeInTableViewElement, object: self)
        
    }
    
    func onCommentPosted(parent : CommentData , newComment : PostCommentData){
        let data = CommentData()
        data.initWithPostCommentData(newComment)
        data.initWithOwner(CurrentSession.i.personController.person.basicInfo)
        data.ownerArea = "sdfaf"
        parent.addReply(data);
        isShowFooter = -1
        tableView.reloadData();//insertRowsAtIndexPaths([NSIndexPath(forRow: comments.count - 1, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
        tableView.frame.size.height = tableView.contentSize.height
        EventUtils.postNotification(EventUtils.changeInTableViewElement, object: self)
        
    }
    
    func registerClassForTableView(){
        tableView.registerClass(CommentCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    func getHeightOfView()->CGFloat {
        return tableView.contentSize.height
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
}

//MARK: UITableViewDataSource
extension CommentController : UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return comments.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if expandedRows.contains(section){
            return (1 + comments[section].getTotalComments())
        }
        return 1 + comments[section].getTotalComments()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(getCellIdentifier(indexPath), forIndexPath: indexPath) as UITableViewCell
        configureCell(cell, forRowAtIndexPath: indexPath)
        return cell
    }
    
    func getCellIdentifier(indexPath: NSIndexPath) -> String{
        return "cell"
    }
    
    func configureCell(cell: UITableViewCell, forRowAtIndexPath: NSIndexPath) {
        if let c = cell as? CommentCell {
            c.delegate = self
            if forRowAtIndexPath.row == 0 {
                c.initViewWithData(comments[forRowAtIndexPath.section])
            }
            else{
                c.level = 1
                c.initViewWithData(comments[forRowAtIndexPath.section].reply![forRowAtIndexPath.row-1])
            }
        }
    }
    
}

extension CommentController :UITableViewDelegate {
    
    //MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    //    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    //
    //    }
    
    //    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //
    //    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if isShowFooter == section{
            return footerHeight
        }
        else{
            return 0
        }
    }
    
    //    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //
    //    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let container = UIView()
        let view = PostCommentView(frame: CGRect(x: BaseDetailViewController.leftSideOffset / 2, y: 0, width: tableView.frame.width - BaseDetailViewController.leftSideOffset/2, height: Constants.addCommentViewHeight))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setDelegate(self)
        container.addSubview(view)
        container.pinViewOnAllDirection(view, left: BaseDetailViewController.leftSideOffset / 2, top: 0, right: -BaseDetailViewController.leftSideOffset/2, bottom: 0)
        return container
    }
    
    func onCommentEdit(cell : CommentCell){
        tableView.reloadData()
    }
}


// MARK: - Actions

extension CommentController : CommentCellDelegate {
    func onCommentActionClick(action: Actions, cell: CommentCell) {
        switch (action) {
        case .Comment:
            onCommentButtonClick(cell)
            break;
        case .Flag:
            onFlagButtonClick(cell)
            break;
        case .Edit:
            onEditButtonClick(cell)
            break;
        default:
            break;
        }
    }
}


extension CommentController : PostCommentDelegate {
    func onPostCommentClic(data : String, view :PostCommentView) {
        
        let selectedComment = comments[isShowFooter]
        
        let obj = PostCommentData()
        obj.userid = CurrentSession.i.userId
        obj.comment = data
        obj.type = "comment"
        obj.id = selectedComment.id
        
        
        guard let d = delegate else { assertionFailure(); return }
        
        
        d.postCommentOnComment(self, parent: selectedComment, info: obj)
        
               
    }
    
    func onPostCommentHeightChange(height: CGFloat, view : PostCommentView) {
        footerHeight = height
        tableView.beginUpdates()
        tableView.endUpdates()
        tableView.frame.size.height = tableView.contentSize.height
        view.frame.size.height = tableView.contentSize.height + 15
        EventUtils.postNotification(EventUtils.changeInTableViewElement, object: self)
        
        
    }
}


extension CommentController {
    
    func onCommentButtonClick(cell:CommentCell){
        if let index = tableView.indexPathForCell(cell) {
            if ( isShowFooter != index.section) {
                isShowFooter = index.section
            }
            else {
                isShowFooter = -1
            }
            tableView.reloadData()//reloadRowsAtIndexPaths([index], withRowAnimation: UITableViewRowAnimation.Automatic)
            print("previous size..\(tableView.frame)..........\(frame)")
            tableView.frame.size.height = tableView.contentSize.height
            
            EventUtils.postNotification(EventUtils.changeInTableViewElement, object: self)
            
        }
    }
    
    func onFlagButtonClick(cell:CommentCell){
        
    }
    
    func onMessageButtonClick(cell:CommentCell){
        
    }
    
    func onEditButtonClick(cell : CommentCell){
//        var alert = UIAlertController(title: "Edit", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
//        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
//        alert.ad
//        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
//            textField.placeholder = "Enter text:"
//            textField.secureTextEntry = true
//        })
//        self.presentViewController(alert, animated: true, completion: nil)
        
        guard let d = delegate else { assertionFailure(); return }
        
        d.editComment(self, info: cell)

       
    }
    
    
    
}



