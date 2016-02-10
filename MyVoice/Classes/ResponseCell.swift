//
//  ResponseCell.swift
//  MyVoice
//
//  Created by PB014 on 03/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class ResponseView: CommentView {
    
    var voteUp: UIButton!
    var votedown: UIButton!
    var totalVotes: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        voteUp = self.viewWithTag(10) as! UIButton
        voteUp.addTarget(self, action: "onVoteUp", forControlEvents: UIControlEvents.TouchUpInside)
        votedown = self.viewWithTag(11) as! UIButton
        votedown.addTarget(self, action: "onVoteDown", forControlEvents: UIControlEvents.TouchUpInside)

        MyUtils.createGreyBorder(voteUp)
        MyUtils.createGreyBorder(votedown)
        
        totalVotes = self.viewWithTag(12) as! UILabel

    }

    func onVoteDown(){
        
    }
    
    
    func onVoteUp(){
        
    }

}


class ResponseCell: CommentCell {
    
    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        prepareView()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//        prepareView()
//    }
    
    override func prepareView(){
        commentView = NSBundle.mainBundle().loadNibNamed("Response", owner: self, options: nil)[0] as! ResponseView
        commentView.frame = self.bounds
        self.addSubview(commentView)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func initViewWithData(data: CommentData) {
        super.initViewWithData(data)
        if let d = data as? ResponseData {
            if let v = commentView as? ResponseView {
                v.totalVotes.text =  "\(d.votes)"
                return
            }
        }
        
        log.error("something is wrong here")
    }
}

