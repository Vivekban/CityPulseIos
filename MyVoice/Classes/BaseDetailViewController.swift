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
    let responseSectionIndex = 3
    
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
        item?.tintColor = UIColor.whiteColor()
        item?.action = #selector(BaseDetailViewController.onBackButtonClick)
        item?.target = self
        
        // Do any additional setup after loading the view.ou
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // MyUtils.setStatusBarBackgroundColor(UIColor.whiteColor())
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // As intially the height of coment and response section is unknow
        containerTableView.reloadData()
        EventUtils.addObserForKeyBoardEvents(self)

    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        // MyUtils.setStatusBarBackgroundColor(Constants.primaryColor)

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
        
        //        UIView.animateWithDuration(0.4,
        //            delay: 0.0,
        //            options: UIViewAnimationOptions.CurveEaseInOut,
        //            animations: {
        //                    self.view.transform = CGAffineTransformMakeTranslation(-self.view.frame.size.width, 20)
        //
        //            },
        //            completion: { finished in
        //                //currentController.presentViewController(newController, animated: false, completion: nil)
        //                //currentController.view.window?.rootViewController?.presentViewController(newController, animated: false, completion: nil)
        //
        //            }
        //        )
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
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
    
    func updateTableSize(){
        containerTableView.beginUpdates()
        containerTableView.endUpdates()
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
                //containerTableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.None)
                updateTableSize()
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
            let req = ServerRequest(url: ServerUrls.subscribeIssueUrl, postData: ["userid":CurrentSession.i.userId,"issueid":d.id], completionHandler: { (result) -> Void in
                print(result)
                LoaderUtils.i.hideLoader()
                
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
            req.responseType = .Normal
            sendRequestToServer(req)
        }
        else {
            
            let req = ServerRequest(url: ServerUrls.subscribeIssueUrl, postData: ["userid":CurrentSession.i.userId,"issueid":d.id], completionHandler: { (result) -> Void in
                LoaderUtils.i.hideLoader()
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
            req.responseType = .Normal
            sendRequestToServer(req)
            
        }
        
    }
    
    func onFlag(){
        
    }
    
    func onMessage(){
        
    }
    
    func onShare(){
        
    }
    
    func sendRequestToServer(request : ServerRequest){
        LoaderUtils.i.showLoader(self.view)
        ServerRequestInitiater.i.initiateServerRequest(request)
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
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
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
        let index = dataIndex
        delegate?.onEditButtonClick(index)

        //dismissViewControllerAnimated(true, completion: nil)
    }
}

class BaseCommentDetailViewController : BaseDetailViewController {
    var commentView:UIView?
    var commentController:CommentController?
    let commentIdentifier = "commentSection"
    let addCellIdentifier = "addResponseSection"
    
    private var commentSectionHeight:CGFloat = 0
    private var addCommentHeight:CGFloat = Constants.addCommentViewHeight
    
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
            // updateTableSize()
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
            commentController = c
            commentController?.delegate = self
            commentSectionHeight = c.tableView.contentSize.height
            guard let d = data as? IssueData else{
                return
            }
            
            if d.comments != nil {
                c.updateComments(d.comments!)
                c.hidden = false
                
            }
            else{
                c.hidden = true
            }
            
            //            if ( commentSectionHeight != c.tableView.contentSize.height ){
            //                containerTableView.reloadSections(NSIndexSet(index: 1), withRowAnimation: UITableViewRowAnimation.Automatic)
            //            }
        }
        else if forRowAtIndexPath.section == addCommentSectionIndex {
            if let c = cell as? PostCommentCell {
                c.setDelegate(self)
                c.setWidthOfCell(cell.frame.width)
                c.postView.type = PostCommentType.Comment
                // c.postView.descriptionField.delegate = self
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
            return isShowFooter ? addCommentHeight: 0
        default:
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
            
        }
    }
    
    func getHeightForFooterInSection(section: Int) -> CGFloat {
        guard let d = data as? ImageCommentData else{
            return 20
        }
        
        if section == numberOfSection - 1{
             containerTableView.footerViewForSection(section)?.hidden = true
        return 0
        }
        
        switch (section) {
        case commentSectionIndex:
            return (d.comments == nil || d.comments?.count == 0) ? 0 : 20
        case addCommentSectionIndex :
            return isShowFooter ? 20 : 0
        default:
            return 20
            
        }
        
        
    }
    
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return getHeightForFooterInSection(section)
        
    }
    
    
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let container = tableView.footerViewForSection(section) ?? UIView()
        let view = UIView(frame: CGRect(x: BaseDetailViewController.leftSideOffset, y: 10, width: (tableView.frame.width) -  BaseDetailViewController.leftSideOffset - 10, height: 1))
        
        if getHeightForFooterInSection(section) == 0 {
            view.backgroundColor = UIColor.clearColor()
            
        }
        else{
            view.backgroundColor = Constants.grayColor_217
        }
        container.addSubview(view)
        return container
    }
    
    override func onCommentButtonClick(){
        isShowFooter = !isShowFooter
        //containerTableView.reloadSections(NSIndexSet(index: commentSectionIndex), withRowAnimation: UITableViewRowAnimation.Automatic)
        updateTableSize()
        
        if isShowFooter {
            containerTableView.footerViewForSection(addCommentSectionIndex)?.hidden = false            //containerTableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: addCommentSectionIndex), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
        }
        else{
            containerTableView.footerViewForSection(addCommentSectionIndex)?.hidden = true            //containerTableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: addCommentSectionIndex), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
            
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
            //  print(visibleFrame)
            visibleFrame.origin.y += (sv?.frame.origin.y) ?? 0
            sv = sv?.superview
        }
        
        //  containerTableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: addResponseSectionIndex), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
        
    }
    
    
    func postMessageToServer(info : String, completionHandler: ServerRequestCallback){
        print(info)
        
        let req = ServerRequest(url: ServerUrls.resposeIssueUrl, postData: ["json" : info], completionHandler: completionHandler)
        req.retryCount = 2
        req.responseType = .Normal
        sendRequestToServer(req)
        
    }
    
    func onCommentAdd(data : PostCommentData){
        let comnt = CommentData()
        comnt.initWithPostCommentData(data)
        comnt.initWithOwner(CurrentSession.i.personController.person.basicInfo)
        
        guard let d = self.data as? IssueData else{
            return
        }
        
        d.addComment(comnt)
        if d.comments?.count == 1 {
            containerTableView.reloadSections(NSIndexSet(index: commentSectionIndex), withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        else {
            commentController?.updateComments(d.comments!)
        }
        commentSectionHeight = (commentController?.tableView.contentSize.height) ?? commentSectionHeight
        updateTableSize()
        // containerTableView.reloadSections(NSIndexSet(index: responseSectionIndex), withRowAnimation: UITableViewRowAnimation.Automatic)
        // EventUtils.postNotification(EventUtils.changeInTableViewElement, object: reposnse)
        
    }
    
}

extension BaseCommentDetailViewController : CommentControllerDelegate {
    
    func postCommentOnComment(controller: CommentController, parent: CommentData, info: PostCommentData) {
        
        view.endEditing(true)
        
        let m = info.isReadyToSave()
        
        if !m.isEmpty {
            UIAlertUtils.createOkAlertFor(self, with: m)
            return
        }
        
        let param =  MyUtils.appendKayToJSONString(info.toJSONString() ?? "")
        
        postMessageToServer(param, completionHandler: {[weak self] (result) -> Void in
            
            LoaderUtils.i.hideLoader()
            
            guard let s = self else{
                return
            }
            print(result)
            switch (result) {
            case .Success( _):
                controller.onCommentPosted(parent, newComment: info)
                //   s.onCommentAdd(data)
                // view.descriptionField.text = ""
                break
            case .Failure( _):
                UIAlertUtils.createTryAgainWithCancelAlertFor(s, with: MyStrings.unableToPostResponse, tryAgainHandler: { (action) -> Void in
                    
                    s.postCommentOnComment(controller, parent: parent, info:info)
                })
                break
            default:
                break;
            }
            })
    }
    
    func editComment(controller: CommentController, info: CommentCell) {
        
        let controller = MyUtils.getViewControllerFromStoryBoard("Home", controllerName: "EditCommetPopController")!
        
        guard let edit = controller as? EditCommentPopViewController else{
            return
        }
        
        edit.setData(info, delegate: self)
        
        
        controller.modalPresentationStyle = UIModalPresentationStyle.FormSheet
        //controller.view.layer.shadowColor = UIColor.clearColor().CGColor
        // popPickerVC.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.Up
        
        // popPickerVC.tableView.reloadData()
        controller.preferredContentSize = CGSizeMake(self.view.frame.width / 1.4,self.view.frame.height / 1.8 )
        
        presentViewController(controller, animated: true, completion: nil)
        
//        popover = popVC.popoverPresentationController
//        if let _popover = popover {
//            
//            // _popover.sourceView = textField
//            // _popover.sourceRect = CGRectMake(self.offset,textField.bounds.size.height,0,0)
//            
//            
//        }

    }
}

extension BaseCommentDetailViewController: EditCommentPopDelegate{
    
    func onSave(cell: CommentCell) {
        commentController?.onCommentEdit(cell)
    }
    
    func onCancel() {
        
    }
    
}


extension BaseCommentDetailViewController : PostCommentDelegate {
    
    func onPostCommentClic(data : String , view :PostCommentView) {
        
        view.endEditing(true)
        
        guard let d = self.data as? IssueData else {
            log.error("in valid data")
            return
        }
        
        if view.type == .Comment {
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
                    
                    var response = d as! String
                    
                     response = response.stringByReplacingOccurrencesOfString("(", withString: "")
                    response = response.stringByReplacingOccurrencesOfString(")", withString: "")

                    obj.id = Int(response) ?? 0
                    s.onCommentAdd(obj)
                    view.descriptionField.text = ""
                    s.onCommentButtonClick()
                    break
                case .Failure( _):
                    UIAlertUtils.createTryAgainWithCancelAlertFor(s, with: MyStrings.unableToPostResponse, tryAgainHandler: { (action) -> Void in
//                        let v = PostCommentView()
//                        v.type = .Comment
                        s.onPostCommentClic(data, view: view)
                    })
                    break
                default:
                    break;
                }
                })
            
            
        }
        
    }
    
    func onPostCommentHeightChange(height: CGFloat, view : PostCommentView) {
        
        if view.type == .Comment{
            addCommentHeight = height
        }
        
        containerTableView.beginUpdates()
        containerTableView.endUpdates()
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
