//
//  CommentController.swift
//  MyVoice
//
//  Created by PB014 on 04/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class CommentController : UIView {
    var tableView: UITableView!
    var expandedRows = Set<Int>()
    var comments: [CommentData]!
    var level = 0
    
     init(frame: CGRect, data:[CommentData]) {
      super.init(frame: frame)
        self.comments = data
        initViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
    }
    
    func initViews(){
        tableView = UITableView(frame: CGRectMake(0, 0, self.frame.width, self.frame.height))
        // tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorColor = UIColor.clearColor()
        tableView.rowHeight = 200
        tableView.delegate = self
        tableView.dataSource = self
        tableView.scrollEnabled = false
        tableView.canCancelContentTouches = false
        tableView.delaysContentTouches = false
        //table.registerClass(CommentController.self, forHeaderFooterViewReuseIdentifier: "footer")
        registerClassForTableView()
        addSubview(tableView)
        
    }
    
    func updateComments(data : [CommentData]){
        comments = data
        tableView.reloadData()
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
            c.initViewWithData(comments[forRowAtIndexPath.row])
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
    
//    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        
//    }
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//    }
    
//    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        
//    }

}


// MARK: - Actions

extension CommentController : CommentCellDelegate {
    func onCommentActionClick(action: CommentActions, cell: CommentCell) {
        switch (action) {
        case .Comment:
            onCommentButtonClick(cell)
            break;
        case .Flag:
            onFlagButtonClick(cell)
        default:
            break;
        }
    }
}

extension CommentController {
    
    func onCommentButtonClick(cell:CommentCell){
        
    }
    
    func onFlagButtonClick(cell:CommentCell){
        
    }
    
    func onMessageButtonClick(cell:CommentCell){
        
    }
    
    
    
}



