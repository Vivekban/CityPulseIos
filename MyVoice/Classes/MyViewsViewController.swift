//
//  MyViewsViewController.swift
//  MyVoice
//
//  Created by PB014 on 30/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit

class MyViewsViewController: BaseProfileHeaderCollectionView {
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        serverListRequestType = PersonInfoRequestType.Views.rawValue
        super.viewDidLoad()
        
        //  self.collectionView.estimatedRowHeight = 70
        // self.collectionView.rowHeight = UITableViewAutomaticDimension
        columns = 1
        expandedRows.insert(0)
        
        editControlllerIdentifier = "EditViewsViewController"
        detailControllerIdentifier = "MyViewDetailController"
        reuseIdentifier = "MyViewsCell"
        
        let data = CurrentSession.i.personController.person.viewsListManager.entries
        entries = data
        
//        for i in 1...3 {
//            let e = MyViewData()
//            e.title = "Testing titel"
//            e.description = "This is tedtin g descrptio ifo event "
//            entries.append(e)
//        }
        
        self.collecView = collectionView
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func getDataForNewItem() ->BaseData {
        return MyViewData()
    }
    
    override func updateListEntries(parameter: [String : AnyObject]) {
        entries = CurrentSession.i.personController.person.viewsListManager.entries
         super.updateListEntries(parameter)
    }
    // MARK: - Table view data source
   
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MyViewTableCell
        
        // Configure the cell
        if let entry = entries[indexPath.section] as? MyViewData{
            print(entry.description)
            cell.detailLabel.text = entry.description
            // cell.detailLabel.sizeToFit()
            // cell.layoutIfNeeded()
            cell.dateField.text = entry.disPlayDate
        }
        return cell
    }

    
    
    override func getTitleForHeader(index: Int) -> String {
        return (entries[index] as! MyViewData).title
    }

    
    override func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSize(width: Int(collectionView.frame.size.width)/columns, height: 140)
    }
    
    
}


