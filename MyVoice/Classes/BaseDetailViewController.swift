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
    
    //MARK: data source fields
    var data:BaseData?
    var dataArray:[BaseData]?
    var dataIndex = 0
    
    //MARK: UI parameters
    var tableView:UITableView!

    var baseDetailHeight:CGFloat = 300
    var descptionHeight:CGFloat = 21
    
    weak var delegate:BaseDetaiViewControllerDelegate?
    
    var numberOfSection = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView = view.viewWithTag(99) as! UITableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = UIColor.clearColor()
        // tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = view.frame.size.height
        //let container = view.viewWithTag(100)
        
        tableView.canCancelContentTouches = false
        //scrollView.delaysContentTouches
        
        
        let myNavigationItem = (self.view.viewWithTag(10) as? UINavigationBar)?.items![0]
        let item = myNavigationItem?.leftBarButtonItems![0]
        item?.action = "onBackButtonClick"
        item?.target = self
        
        // Do any additional setup after loading the view.
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
            c.updateViewsWith(data)
            if (descptionHeight != c.descriptionLabel.frame.size.height) {
            descptionHeight =  c.descriptionLabel.frame.size.height
                tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.None)
            }
        }
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
    
    var commentSectionHeight:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseDetailHeight = 560
        numberOfSection = 2
        
        tableView.registerClass(CommentController.self, forCellReuseIdentifier: commentIdentifier)
        
//        if commentView != nil {
//            commentHeightContraint = LayoutConstraintUtils.getHeightContraint(commentView!, height: 40)
//            commentView?.addConstraint(commentHeightContraint)
//            commentController = CommentController(frame: CGRectMake(0, 0, (commentView?.frame.width)!, 500), data: comments)
//            commentController?.tableView.canCancelContentTouches = false
//            commentView!.addSubview(commentController!)
//        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        // commentView?.frame.size.height = (commentController?.getHeightOfView())!
//        commentController?.tableView.frame.size.height = (commentView?.frame.height)!
//        tableView.contentSize.height += (commentView?.frame.size.height)!
//        commentView?.layoutIfNeeded()
//        //view.viewWithTag(100)!.frame.size.height = scrollView.contentSize.height;
//        view.layoutIfNeeded()
    }
    
    override func getCellIdentifier(indexPath: NSIndexPath) -> String {
        switch (indexPath.section) {
        case 1:
            return commentIdentifier
        default:
            return super.getCellIdentifier(indexPath)
        }
    }
    
    override func configureCell(cell: UITableViewCell, forRowAtIndexPath: NSIndexPath) {
        if let c = cell as? CommentController {
            c.updateComments(comments)
            if ( commentSectionHeight != c.tableView.contentSize.height ){
                commentSectionHeight = c.tableView.contentSize.height
                tableView.reloadSections(NSIndexSet(index: 1), withRowAnimation: UITableViewRowAnimation.Automatic)
            }
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch (indexPath.section) {
        case 0:
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        default:
            return commentSectionHeight
        }
    }
    
}



class BaseImageDetailViewController: BaseCommentDetailViewController {
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 560
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
