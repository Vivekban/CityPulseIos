//
//  EditCommentPopViewController.swift
//  MyVoice
//
//  Created by PB014 on 05/05/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

protocol EditCommentPopDelegate :class {
    
    func onSave(cell : CommentCell);
    func onCancel();
}

class EditCommentPopViewController: UIViewController {
    
    @IBOutlet weak var commentField: UITextView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    private weak var delegate : EditCommentPopDelegate?
    private var cell : CommentCell!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let d = cell.data as? CommentData else{
            return
        }
        
        commentField.text = d.description
        
        if cell.data is ResponseData {
            titleLabel.text = MyStrings.editResponse
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onCancel(sender: UIButton) {
        if delegate != nil {
            delegate?.onCancel()
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    @IBAction func onSaveButton(sender: AnyObject) {
        
        if delegate != nil {
            (cell.data as! CommentData).description = commentField.text
            delegate?.onSave(cell)
        }
        dismissViewControllerAnimated(true, completion: nil)

        
    }
    
     func setData(cell : CommentCell, delegate: EditCommentPopDelegate) {
        self.cell = cell
        self.delegate = delegate
        
       
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
