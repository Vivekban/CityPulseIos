//
//  DetailMyWorkViewController.swift
//  MyVoice
//
//  Created by PB014 on 21/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

import ObjectMapper
import SwiftyJSON

class DetailMyWorkViewController: BaseImageDetailViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        baseDetailHeight = 520

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func fetchMoreDetailFromServer() {
        guard let d = data as? MyWorkData  else {return}
        
        ServerRequestInitiater.i.postMessageToServerForJsonResponse(ServerUrls.getWorkUrl, postData: ["id": "\(d.id)","getby": "work","userid": "\(CurrentSession.i.userId)"]) { [weak self](r) -> Void in
            switch r {
            case .Success(let data):
                
                self?.onServerResponse(data)
                
                break
            case .Failure(let error):
                print(error)
                break
            default :
                break
            }
        }

    }
    
    
    func onServerResponse(data: AnyObject?){
        guard let d = data else {return}
        print(d)
        let viewArray = JSON(d)
        for (_,obj) in viewArray {
            if let finalString = obj.rawString() {
                // print(" value is \(i)...+....\(finalString)")
                if let view = Mapper<MyWorkData>().map(finalString) {
                    self.data?.update(view)
                    //self.responseSectionHeight = -1
                    self.containerTableView.reloadData()
                    // self.containerTableView.reloadSections(NSIndexSet(index: responseSectionIndex), withRowAnimation: UITableViewRowAnimation.Automatic)
                }
            }
        }
        
    }
    

    @IBAction func onLikeButtonClick(sender: UIButton) {
    }
    
    @IBAction func onCommentButtonClick(sender: UIButton) {
    }
    
    
    @IBAction func onMessageButtonClick(sender: UIButton) {
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
