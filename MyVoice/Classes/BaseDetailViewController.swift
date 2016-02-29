//
//  BaseDetailViewController.swift
//  MyVoice
//
//  Created by PB014 on 21/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit


protocol BaseDetaiViewControllerDelegate : class{
    func onEditButtonClick(index:Int)
}

class BaseDetailViewController: UIViewController {
     static let leftSideOffset:CGFloat = 105
      let commentSectionIndex = 1
    let addCommentSectionIndex = 2
      let reponseSectionIndex = 3

    //MARK: data source fields
    var data:BaseData?
    var dataArray:[BaseData]?
    var dataIndex = 0
    
    //MARK: UI parameters
    // container
    var containerTableView:UITableView!

    var baseDetailHeight:CGFloat = 300
    var descptionHeight:CGFloat = 21
    
    weak var delegate:BaseDetaiViewControllerDelegate?
    
    var numberOfSection = 1
    
    var mainTitle:String = ""{
        didSet {
            (self.view.viewWithTag(10) as? UINavigationBar)?.items![0].title = mainTitle + MyStrings.detail
        }
    }

    
    deinit {
        log.debug(" base detail controller  .......... is deallocated ..:)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        containerTableView = view.viewWithTag(99) as! UITableView
        containerTableView.dataSource = self
        containerTableView.delegate = self
        containerTableView.separatorColor = UIColor.clearColor()
        containerTableView.rowHeight = view.frame.size.height
        //let container = view.viewWithTag(100)
        
        containerTableView.canCancelContentTouches = false
        //scrollView.delaysContentTouches
        
        
        let myNavigationItem = (self.view.viewWithTag(10) as? UINavigationBar)?.items![0]
        let item = myNavigationItem?.leftBarButtonItems![0]
        item?.action = "onBackButtonClick"
        item?.target = self
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // As intially the height of coment and response section is unknow
        containerTableView.reloadData()
        EventUtils.addObserForKeyBoardEvents(self)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        EventUtils.removeObserver(self)
    }
    
    func setDataSourceWith(data :[BaseData]?, index:Int){
        self.data = data![index]
        self.dataArray = data
        self.dataIndex = index
        fetchMoreDetailFromServer()
    }
    
    func fetchMoreDetailFromServer(){
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func onBackButtonClick(){
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func getCellIdentifier(indexPath:NSIndexPath) -> String {
        return indexPath.row == 0 ? "baseDetailCell" : ""
    }
    
    
    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize =  (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
               let kbHeight = keyboardSize.height
                //self.animateTextField(true)
                
                if containerTableView != nil{
                        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbHeight, 0.0);
                        containerTableView!.contentInset = contentInsets;
                        containerTableView!.scrollIndicatorInsets = contentInsets;
                        
                        // If active text field is hidden by keyboard, scroll it so it's visible
                        // Your app might not need or want this behavior.
                        var aRect = self.view.frame;
                        aRect.size.height -= kbHeight;
                    // if (!CGRectContainsPoint(aRect, (activeTextField?.superview!.frame.origin)!) ) {
                    //   var frame = activeTextField?.superview?.frame;
                    //       frame?.origin.y = (frame?.origin.y)! + 10
                            // containerTableView?.scrollRectToVisible((frame)!, animated: true)
                    //    }
                    }
               
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        // self.animateTextField(false)
        // activeTextField = nil
        let contentInsets = UIEdgeInsetsZero;
        if containerTableView != nil {
            containerTableView!.contentInset = contentInsets;
            containerTableView!.scrollIndicatorInsets = contentInsets;
        }
    }
    

}

extension BaseDetailViewController : UITextViewDelegate {
    
}


    //MARK: UITableViewDataSource
extension BaseDetailViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return numberOfSection
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(getCellIdentifier(indexPath), forIndexPath: indexPath) as UITableViewCell
        configureCell(cell, forRowAtIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, forRowAtIndexPath: NSIndexPath) {
        if let c = cell as? BaseDetailCell {
            c.actionDelgate = self
            c.delegate = self
            c.updateViewsWith(data)
            if (descptionHeight != c.descriptionLabel.frame.size.height) {
            descptionHeight =  c.descriptionLabel.frame.size.height
                containerTableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.None)
            }
        }
    }
    
}

extension BaseDetailViewController : ActionsDelegate {
   
    
    func onActionButtonClick(action: Actions) {
        switch (action) {
        case .Comment:
            onCommentButtonClick()
            break;
        case .Subscribe:
            onSubscribeClick()
            break
        case .Flag :
            onFlag()
            break
        default:
            break;
        }
    }
    
    func onCommentButtonClick(){
    }
    
    func onSubscribeClick(){
        guard let d = data as? IssueData else {
            log.error("invalid data")
            return
        }
        
        if (d.isSubscribed == 0){
            // unsubscribed
            ServerRequestInitiater.i.postMessageToServerForStringResponse(ServerUrls.subscribeIssueUrl, postData: ["userid":CurrentSession.i.userId,"issueid":d.id], completionHandler: { (result) -> Void in
                print(result)
                switch (result) {
                case .Success(_):
                    // ToastUtils.displayToastWith("Subscribed")
                    d.isSubscribed = 1
                    break
                case .Failure(_):
                    ToastUtils.displayToastWith(MyStrings.unableToSubscribe)

                    break
                default:
                    break;
                }
            })
        }
        else {
            ServerRequestInitiater.i.postMessageToServerForStringResponse(ServerUrls.subscribeIssueUrl, postData: ["userid":CurrentSession.i.userId,"issueid":d.id], completionHandler: { (result) -> Void in
                switch (result) {
                case .Success(_):
                    // ToastUtils.displayToastWith("Subscribed")
                    d.isSubscribed = 0
                    break
                case .Failure(_):
                    ToastUtils.displayToastWith(MyStrings.unableToUnsubscribe)
                    
                    break
                default:
                    break;
                }
            })
        }
        
    }
    
    func onFlag(){
        
    }
    
    func onMessage(){
        
    }
    
    func onShare(){
        
    }

}


extension BaseDetailViewController :UITableViewDelegate {
        //MARK: UITableViewDelegate
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//    }
//    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return baseDetailHeight + descptionHeight
    }
//
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        
//    }
//    
//    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        
//    }
//    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//    }
//    
//    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        
//    }
    
}


extension BaseDetailViewController : BaseDetailCellDelegate {
    func onEditButtonClick() {
            delegate?.onEditButtonClick(dataIndex)
            dismissViewControllerAnimated(true, completion: nil)
    }
}

class BaseCommentDetailViewController: BaseDetailViewController {
    var comments:[CommentData] = [CommentData]()
    var commentView:UIView?
    var commentController:CommentController?
    let commentIdentifier = "commentSection"
    let addCellIdentifier = "addResponseSection"

    var commentSectionHeight:CGFloat = 0
    
    var isShowFooter = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseDetailHeight = 560
        numberOfSection = 3
        
        containerTableView.registerClass(CommentController.self, forCellReuseIdentifier: commentIdentifier)
        containerTableView.registerClass(PostCommentCell.self, forCellReuseIdentifier: addCellIdentifier)

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        EventUtils.addObserver(self, selector: "changeInTableElement:", key: EventUtils.changeInTableViewElement)
        EventUtils.addObserver(self, selector: "onTextViewEditingBegin:", key: EventUtils.commentFieldBeginEditing)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func changeInTableElement(notification: NSNotification){
        if let e = notification.object as? CommentController {
            commentSectionHeight = e.tableView.contentSize.height
            containerTableView.reloadSections(NSIndexSet(index: 1), withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func onTextViewEditingBegin(notification: NSNotification){
        if let e = notification.object as? UITextView {
            textViewDidBeginEditing(e)
        }
    }

    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        EventUtils.removeObserver(self)
    }
    
    override func getCellIdentifier(indexPath: NSIndexPath) -> String {
        switch (indexPath.section) {
        case addCommentSectionIndex:
            return addCellIdentifier
        case 1:
            return commentIdentifier
        default:
            return super.getCellIdentifier(indexPath)
        }
    }
    
    override func configureCell(cell: UITableViewCell, forRowAtIndexPath: NSIndexPath) {
        if let c = cell as? CommentController {
            c.updateComments(comments)
            commentSectionHeight = c.tableView.contentSize.height
//            if ( commentSectionHeight != c.tableView.contentSize.height ){
//                containerTableView.reloadSections(NSIndexSet(index: 1), withRowAnimation: UITableViewRowAnimation.Automatic)
//            }
        }
        else if forRowAtIndexPath.section == addCommentSectionIndex {
            if let c = cell as? PostCommentCell {
                c.setDelegate(self)
                c.setWidthOfCell(cell.frame.width)
                c.postView.type = PostCommentType.Comment
                c.postView.descriptionField.delegate = self
            }
            
        }
        else{
            super.configureCell(cell, forRowAtIndexPath: forRowAtIndexPath)
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch (indexPath.section) {
        case commentSectionIndex:
            return commentSectionHeight
        case addCommentSectionIndex :
            return isShowFooter ? Constants.addCommentViewHeight: 0

        default:
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)

        }
    }
    
//    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        if isShowFooter && section == commentSectionIndex{
//            return Constants.addCommentViewHeight
//        }
//        else{
//            return 0
//        }
//    }
    
    //    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //
    //    }
    
//    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let container = UIView()
//        let view = PostCommentView(frame: CGRect(x: BaseDetailViewController.leftSideOffset, y: 0, width: (tableView.frame.width) - 2 * BaseDetailViewController.leftSideOffset , height: Constants.addCommentViewHeight))
//        view.delegate = self
//        view.type = .Comment
//        container.addSubview(view)
//        return container
//    }
    
    override func onCommentButtonClick(){
        isShowFooter = !isShowFooter
        containerTableView.reloadSections(NSIndexSet(index: commentSectionIndex), withRowAnimation: UITableViewRowAnimation.Automatic)
        if isShowFooter {
        containerTableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: addCommentSectionIndex), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
        }
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        
        var sv : UIView? = textView
        var visibleFrame = textView.frame
        visibleFrame.origin.y = 0
        visibleFrame.size.height += 100
        
        while(sv != nil) {
            
            if sv == containerTableView {
                containerTableView.scrollRectToVisible(visibleFrame, animated: true)
                return
            }
            print(visibleFrame)
            visibleFrame.origin.y += (sv?.frame.origin.y) ?? 0
            sv = sv?.superview
        }
        
        //  containerTableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: addResponseSectionIndex), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
        
    }
}


extension BaseCommentDetailViewController : PostCommentDelegate {
    
    func onPostCommentClic(data : String , view :PostCommentView) {
    
    }
}


class BaseImageDetailViewController: BaseCommentDetailViewController {
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerTableView.rowHeight = 560
    }
    
    override func setDataSourceWith(data: [BaseData]?, index: Int) {
        super.setDataSourceWith(data, index: index)
    }
}



class TestingView : UIView {
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        let b = super.pointInside(point, withEvent: event)
        log.info("\(point) .......is prsent ...........\(b)..")
        return b
    }
}
