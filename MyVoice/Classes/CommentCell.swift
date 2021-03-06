//
//  CommentCell.swift
//  MyVoice
//
//  Created by PB014 on 03/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

protocol CommentViewDelegate:class{
    func onCommentActionClick(tag: Int);
}

protocol CommentCellDelegate:class{
    func onCommentActionClick( action: Actions, cell : CommentCell);
}




class CommentView: UIView {
    
    var leftSpacer:UIView?
    var leftSpacerWidthConstraint:NSLayoutConstraint?
    
    var profilePic:UIImageView!
    var name: UILabel!
    var area:UILabel!
    var descrption:UILabel!
    var date: UILabel!
    var actionButtons:[UIButton] = [UIButton]()
    
    weak var delegate:CommentViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profilePic = self.viewWithTag(1) as! UIImageView
        
        name = self.viewWithTag(2) as! UILabel
        area = self.viewWithTag(3) as! UILabel
        descrption = self.viewWithTag(4) as! UILabel
        date = self.viewWithTag(5) as! UILabel
        leftSpacer = self.viewWithTag(25)
        if leftSpacer != nil {
            leftSpacerWidthConstraint = NSLayoutConstraint(item: leftSpacer!, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 0)
            leftSpacer?.addConstraint(leftSpacerWidthConstraint!)
        }
        
        for i in 50...54 {
            guard let button = self.viewWithTag(i) as? UIButton else{
                continue
            }
            
            button.addTarget(self, action: "onActionButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
            actionButtons.append(button)
        }
        
        
        // Initialization code
    }
    
    func onActionButtonClick(sender:UIButton){
        delegate?.onCommentActionClick(sender.tag)
    }
    
    
    @IBAction func onCommentClick(sender: UIButton) {
        
    }
    
    func updateView(data : CommentData){
        date.text = data.disPlayDate
        name.text = data.ownerName
        area.text = data.ownerArea
        descrption.text = data.description
        ServerImageFetcher.i.loadProfileImageWithDefaultsIn(profilePic, url: data.ownerPic)
        
        if(data.owner == CurrentSession.i.userId){
            let view = self.viewWithTag(Actions.Edit.rawValue) // edit button
            view?.hidden = false
        }
        else{
            self.viewWithTag(Actions.Edit.rawValue)?.hidden = true
        }
        
    }
    
    
    func setSpacerWidth(level :Int){
        if leftSpacerWidthConstraint != nil {
            let newWidth:CGFloat = (CGFloat)(level * 50)
            leftSpacerWidthConstraint?.constant = newWidth
            layoutIfNeeded()
        }
    }
    
}

class CommentCell: UITableViewCell {
    
    var commentView:CommentView!
    var level = 0 {
        didSet{
            if level == 1 {
                commentView.actionButtons[0].addWidthContraint(0)
                commentView.actionButtons[0].hidden = true
            }
            commentView.setSpacerWidth(level)
        }
    }
    weak var delegate:CommentCellDelegate?
    
    var data :BaseData!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        prepareView()
        
    }
    
    func prepareView(){
        if commentView == nil {
            commentView = NSBundle.mainBundle().loadNibNamed("Comment", owner: self, options: nil)[0] as! CommentView
            commentView.frame = self.bounds
            commentView.delegate = self
            self.addSubview(commentView)
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func initViewWithData(data:CommentData){
        self.data = data
        commentView.updateView(data)
    }
    
}

extension CommentCell : CommentViewDelegate {
  
    func onCommentActionClick(tag: Int) {
        
        delegate?.onCommentActionClick(Actions(rawValue: tag)!, cell: self)
        
//        switch (tag) {
//        case 50:
//            onCommentButtonClick()
//            break;
//        case 51:
//            onFlagButtonClick()
//            break
//        case 52:
//            onMessageButtonClick()
//        default:
//            
//            break;
//        }
        
    }
    
}
