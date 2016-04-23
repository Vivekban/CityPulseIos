//
//  PostCommentView.swift
//  MyVoice
//
//  Created by PB014 on 17/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit


protocol PostCommentDelegate :class {
    func onPostCommentClic(data : String , view :PostCommentView)
    func onPostCommentHeightChange(height: CGFloat, view :PostCommentView)
}

protocol PostCommentCellDelegate :class {
    func onPostCommentClic(data : String , view :PostCommentCell)
    func onPostCommentHeightChange(height: CGFloat, view :PostCommentCell)
}

enum PostCommentType : Int {
    case Comment = 0, Response
}

class PostCommentView: UIView {

    @IBOutlet weak var descriptionField: DescriptionView!
    @IBOutlet weak var postButton: UIButton!
   
    private weak var delegate : PostCommentDelegate?
    
    var type = PostCommentType.Comment {
        didSet{
            onTypeSet()
        }
    }
    
     override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        self.clipsToBounds = true
        let view = NSBundle.mainBundle().loadNibNamed("PostComment", owner: self, options: nil)[0] as! UIView
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        pinViewOnAllDirection(view)
        postButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10)
        //view.frame = self.bounds
        descriptionField.hint = ""
        descriptionField.delegate = self
        descriptionField.sizeDelegate = self
        onTypeSet()
    }
    
    @IBAction func onPostClick(sender: UIButton) {
        delegate?.onPostCommentClic(descriptionField.text ?? "", view: self)
    }
    

    func onTypeSet(){
        switch (type) {
        case .Comment:
            postButton.setTitle(MyStrings.postComment, forState: UIControlState.Normal)
            descriptionField.hint = MyStrings.comment
            break;
            
        case .Response :
            postButton.setTitle(MyStrings.postResponse, forState: UIControlState.Normal)
            descriptionField.hint = MyStrings.response
            break
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let t = descriptionField.hint
        descriptionField.hint = ""
        descriptionField.hint = t
    }
    
    
    func setDelegate(delegate : PostCommentDelegate){
        self.delegate = delegate
    }
}

extension PostCommentView : UITextViewDelegate {
    func textViewDidBeginEditing(textView: UITextView) {
        EventUtils.postNotification(EventUtils.commentFieldBeginEditing, object: textView)
    }
}

extension PostCommentView : TextViewSizeChangeDelegate{
    func heightChange(newHeight: CGFloat) {
    
        delegate?.onPostCommentHeightChange(newHeight + 55,view: self);
    }
}


class PostCommentCell : UITableViewCell {
    
    var postView : PostCommentView!
    weak var delegate : PostCommentCellDelegate?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
        
        setup()
    }
    
    
    func setup(){
        clipsToBounds = true
        let leftSideOffset = BaseDetailViewController.leftSideOffset
        postView = PostCommentView(frame: CGRect(x: leftSideOffset, y: 0, width: (self.frame.width) - 2 * leftSideOffset , height: 200))
        
        postView.translatesAutoresizingMaskIntoConstraints = false
        
        
        postView.delegate = self
        postView.type = .Response
        addSubview(postView)
        pinViewOnAllDirection(postView, left: leftSideOffset, top: 2, right: -leftSideOffset, bottom: 2)

    }
    
    func setWidthOfCell(width :CGFloat){
        //postView.frame.size.width = width - 2 * BaseDetailViewController.leftSideOffset
    }
    
    func setDelegate(delegate : PostCommentDelegate) {
        postView.delegate = delegate

    }
    
}


extension PostCommentCell : PostCommentDelegate{
    func onPostCommentClic(data : String , view :PostCommentView){
        delegate?.onPostCommentClic(data, view: self)
    }
    func onPostCommentHeightChange(height: CGFloat, view :PostCommentView){
        delegate?.onPostCommentHeightChange(height, view: self)
        frame.size.height = height
        layoutIfNeeded()
    }
}
