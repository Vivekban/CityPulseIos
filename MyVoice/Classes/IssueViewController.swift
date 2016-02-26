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
    
    var issueType = IssueType.Community
    
    var newIssueButton = UIButton(type:.System)
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        serverListRequestType = currentFilter?.dataRequestType ?? 0
        
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
    
    override func viewWillAppear(animated: Bool) {
        print(view.superview?.frame)
        entries = getAllEntries()
        super.viewWillAppear(animated)
        
        // collecView?.reloadData()
        
        if newIssueButton.superview == nil {
            if let parentView = view.superview {
                print(newIssueButton.frame)
                // newIssueButton.frame = CGRect(x: parentView.frame.width - 120, y: 8, width: 100, height: newIssueButton.frame.height)
                parentView.addSubview(newIssueButton)
                //parentView.addConstraint(NSLayoutConstraint(item: newIssueButton, attribute: .Trailing, relatedBy: .Equal, toItem: parentView, attribute: .Trailing, multiplier: 1, constant: 8))
                
            }
        }
    }
    
    
    override func getParameterForListFetching(type: Int) -> [String : AnyObject] {
        var params = super.getParameterForListFetching(type)
        params["tab"] = issueType.rawValue
        params["index"] = currentFilter?.index ?? 0
        return params
    }
    
    func getAllEntries() -> [BaseData] {
        return CurrentSession.i.issueController.issuesData.issueListsManager[currentFilter?.index ?? 0].entries
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func onCatergoryChange(text:String, item index:Int){
        if currentCategory != text {
            currentCategory = text
            currentCategoryIndex = index
            filterEntriesByCategory()
        }
    }
    
    func filterEntriesByCategory() {
        let allEntries = getAllEntries()
        entries.removeAll()
        
        if currentCategoryIndex != 0 {
            for i in allEntries {
                if let d = i as? IssueData {
                    if d.category == currentCategory {
                        entries.append(d)
                    }
                }
            }
            
        }
        else{
            entries.appendContentsOf(allEntries)
        }
        if collectionView != nil {
            self.collectionView.reloadData()
        }

    }
    
    override func onFilterChange() {
        
        
        if serverListRequestType != currentFilter?.dataRequestType ?? 0 {
            serverListRequestType = currentFilter?.dataRequestType ?? 0
            fetchListFromStart()
        }
    }
    
    override func updateListEntries(parameter: [String : AnyObject]) {
        let c = currentFilter?.index ?? 0
        
        if let index = parameter["index"] as?Int {
            if index == c {
                entries = CurrentSession.i.issueController.issuesData.issueListsManager[c].entries
                filterEntriesByCategory()
                updateEntries()
            }
        }
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
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return entries.count
        
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
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        showDetailViewController(indexPath.row)
    }
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    
    
    //    override func afterSaveDetail(type: EditControllerType, modifiedData: [BaseData], index: Int) {
    //        super.afterSaveDetail(type, modifiedData: modifiedData, index: index)
    //        
    //    }
}




