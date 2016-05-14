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
        delegate?.onCommentActionClick(334)
    }
    
    
    func onVoteUp(){
        delegate?.onCommentActionClick(333)
        
    }
    
}


class ResponseCell: CommentCell {
    
    var isVoting = false
    
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
        commentView.delegate = self
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
    
    override func onCommentActionClick(tag: Int) {
        if tag == 333 {
            onVoteUpIssueClick()
        }
        else if tag == 334 {
            onVoteDownClick()
        }
        else {
            super.onCommentActionClick(tag)

        }
        
        
    }
    
    
    func onVoteUpIssueClick() {
        if isVoting {
            return
        }
        
        if let d = data as? ResponseData  {
            if d.isVoted < 1 {
                onVoteRequest(1)
            }
            else{
                UIAlertUtils.createOkAlertFor(self, with: MyStrings.alreadyVoteUp)
            }

            
        }
    }
    
    func onVoteDownClick() {
        if let d = data as? ResponseData where !isVoting{
            if d.isVoted > -1 {
                onVoteRequest(-1)
            }
            else{
                UIAlertUtils.createOkAlertFor(self, with: MyStrings.alreadyVoteDown)
            }

            
        }
    }
    
    
    func onVoteRequest (change : Int){
        isVoting = true
        
        guard let d = data as? ResponseData else {
            return
        }
        
        let param = MyUtils.appendKayToJSONString("{\"votes\":\(change),\"issueid\":\(d.id),\"userid\":\(CurrentSession.i.userId)} ")
        
        print(param)
        ServerRequestInitiater.i.postMessageToServerForStringResponse(ServerUrls.voteResponseUrl, postData: ["json": param]) { [weak self] (r) -> Void in
            
            self?.isVoting = false
            switch r {
            case .Success(let data):
                self?.changeVote(change)
                if let d = data {
                    print(d)
                    
                }
                break
            case .Failure(let error):
                print(error)
                ToastUtils.displayToastWith(change > 0 ? MyStrings.unableToVoteUp : MyStrings.unableToVoteDown)
                break
            default :
                break
            }
            
        }
        
    }
    
    
    func changeVote(change : Int){
        guard let d = data as? ResponseData else {
            return
        }
        
        
        let fi = d.isVoted + change
        
        if fi > -2 && fi < 2 {
            d.isVoted = fi
            d.votes += change
           
            if let v = commentView as? ResponseView {
                v.totalVotes.text =  "\(d.votes)"
                return
            }
        }
    }
    
    
}

