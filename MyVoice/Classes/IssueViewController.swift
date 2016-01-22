//
//  IssueViewController.swift
//  MyVoice
//
//  Created by PB014 on 30/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit

private let reuseIdentifier = "IssueCell"

class IssueViewController: UIViewController {
    
    var type = IssuesConrollerType.Own
    
    var newIssueButton = UIButton(type:.System)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

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
    
    override func viewWillDisappear(animated: Bool) {
        print("view will disapper")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func newIssue(){
        print("on new issue")
    }
    
}

extension IssueViewController : UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 6
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        // indexPath.section
        // indexPath.row
        // Configure the cell
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        //1
        switch kind {
            //2
        case UICollectionElementKindSectionHeader:
            //3
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind,withReuseIdentifier: "BasicInfoHeaderView",forIndexPath: indexPath)
            return headerView
        default:
            //4
            assert(false, "Unexpected element kind")
        }
        return UICollectionReusableView()
    }
    
}
extension IssueViewController : UICollectionViewDelegateFlowLayout{
    
    //    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    //    {
    //        return CGSize(width: Int(collectionView.frame.size.width) - 5, height: Int(collectionView.frame.size.height))
    //    }
    
}
