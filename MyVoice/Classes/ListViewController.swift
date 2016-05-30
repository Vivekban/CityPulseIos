//
//  ListViewController.swift
//  MyVoice
//
//  Created by PB014 on 23/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class ListViewController: BaseNestedTabViewController {
    
    let searchTabPostion = 3

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchView: FloatLabelTextField!
    
    @IBOutlet weak var searchLayoutHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reuseIdentifier = "cell"
        
        tablView = tableView

        tablView?.registerClass(CommunityHubItemCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        tablView?.rowHeight = 67
        tablView!.delegate = self
        tablView!.dataSource = self
        
        serverDataManager = CurrentSession.i.communityHubDataManager
        serverListRequestType = 1
        entries = CurrentSession.i.communityHubDataManager.lists[tabPosition].entries
        
        
        var d = CommunityItemData()
        
        let info = CurrentSession.i.personController.person.profileData
        
        d.credits = info.credits
        d.title = info.name
        d.picUrl = info.profileImageUrl
        
        for _ in 0...3{
            entries.append(d)
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        if (tabPosition != searchTabPostion){
            searchLayoutHeight.constant = 0
            
        }
        super.viewWillLayoutSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func configureTableCell(cell: UITableViewCell, indexPath: NSIndexPath) {
        if let c = cell as? CommunityHubItemCell {
                c.initViewWithData(entries[indexPath.row] as! CommunityItemData)
        }
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
