//
//  IssueViewController.swift
//  MyVoice
//
//  Created by PB014 on 30/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit
import CoreLocation

class IssueViewController: HomeBaseNestedTabController {
    
    var issueType = IssueType.Community {
        didSet{
            tab = issueType.rawValue
        }
    }
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        serverListRequestType = currentFilter?.dataRequestType ?? 0
        columns = 3
        super.viewDidLoad()
        
        collecView = collectionView
        editControlllerIdentifier = "EditIssueControlller"
        detailControllerIdentifier = "IssueDetailController"
        reuseIdentifier = "IssueCell"
        
        entries = getAllEntries()
        
        //        for i in 0...4 {
        //            let issue = IssueData()
        //            issue.title = "Title of issue\(i)"
        //            issue.description = "Description of issue\(i) \nDescription of issue\(i) \n and finally line of description of issue\(i) long line it has to be"
        //            issue.category = "Park Recreation"
        //            issue.disPlayDate = TimeDateUtils.getShortDateInString(NSDate())
        //            entries.append(issue)
        //        }
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
  
    
    
    
    override func showEditViewController(type: EditControllerType, index: Int) -> UIViewController? {
        let controller = super.showEditViewController(type, index: index)
        if let editController = controller as? EditIssueViewController {
            editController.issueType = self.issueType
        }
        return controller
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! IssueCollectionViewCell
        
        
        if let d = entries[indexPath.row] as? IssueData{
            cell.title.text = d.title
            cell.detail.text = d.description
            cell.category.text = d.category
            cell.date.text = d.disPlayDate
            cell.response.text = d.responseCount.toString()
            cell.votes.text = d.votes.toString()
            
            if d.status.caseInsensitiveCompare("n") == NSComparisonResult.OrderedSame{
                cell.status.textColor = UIColor.redColor()
            }
            else{
                cell.status.textColor = Constants.closed_color
            }
            cell.status.text = d.displayStatus
            
            if d.imagesUrls.count < 1 {
                MapUtils.centerMapOnLocation(cell.locationView, location: CLLocation(latitude: 21.282778, longitude: -157.829444),regionRadius: 2000)
                cell.locationView.hidden = false
                cell.imageView.hidden = true
            }
            else{
                cell.locationView.hidden = true
                cell.imageView.hidden = false
                ServerImageFetcher.i.loadImageIn(cell.imageView, url: d.imagesUrls[0])
            }
            
        }
        
        // indexPath.section
        // indexPath.row
        // Configure the cell
        
        return cell
    }
    
        
    
    
    
    //    override func afterSaveDetail(type: EditControllerType, modifiedData: [BaseData], index: Int) {
    //        super.afterSaveDetail(type, modifiedData: modifiedData, index: index)
    //        
    //    }
}




