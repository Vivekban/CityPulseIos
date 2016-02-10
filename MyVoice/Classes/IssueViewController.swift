//
//  IssueViewController.swift
//  MyVoice
//
//  Created by PB014 on 30/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit
import CoreLocation

class IssueViewController: BaseNestedTabViewController {
    
    var type = IssuesConrollerType.Own
    
    var newIssueButton = UIButton(type:.System)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editControlllerIdentifier = "EditIssueControlller"
        detailControllerIdentifier = "IssueDetailController"
        reuseIdentifier = "IssueCell"
        
        for i in 0...4 {
            let issue = IssueData()
            issue.title = "Title of issue\(i)"
            issue.description = "Description of issue\(i) \nDescription of issue\(i) \n and finally line of description of issue\(i) long line it has to be"
            issue.category = "Park Recreation"
            issue.disPlayDate = TimeDateUtils.getShortDateInString(NSDate())
            entries.append(issue)
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        print(view.superview?.frame)
        if newIssueButton.superview == nil {
            if let parentView = view.superview {
                print(newIssueButton.frame)
               // newIssueButton.frame = CGRect(x: parentView.frame.width - 120, y: 8, width: 100, height: newIssueButton.frame.height)
                parentView.addSubview(newIssueButton)
                //parentView.addConstraint(NSLayoutConstraint(item: newIssueButton, attribute: .Trailing, relatedBy: .Equal, toItem: parentView, attribute: .Trailing, multiplier: 1, constant: 8))
                
            }
            
        }
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
            
            if d.status.caseInsensitiveCompare("o") == NSComparisonResult.OrderedSame{
              cell.status.textColor = UIColor.redColor()
            }
            else{
                cell.status.textColor = Constants.closed_color
            }
            cell.status.text = d.displayStatus
            
           MapUtils.centerMapOnLocation(cell.locationView, location: CLLocation(latitude: 21.282778, longitude: -157.829444))

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
    
}




