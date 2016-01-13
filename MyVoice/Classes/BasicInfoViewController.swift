//
//  BasicInfoViewController.swift
//  MyVoice
//
//  Created by PB014 on 26/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit
import CocoaLumberjack

private let reuseIdentifier = "BasicInfoCell"

class BasicInfoViewController: UICollectionViewController {
    var columns = 2
    var numberOfSections = 4
    var expandedRows = Set<Int>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        expandedRows.insert(0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDataSource
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return numberOfSections
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if !expandedRows.contains(section){
            return 0
        }
        return CurrentSession.i.personUI!.getInfoItemBy(section).count

    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! BasicInfoCell
        
        // Configure the cell
        var title:String?
        var content:String?
        title = CurrentSession.i.personUI!.getInfoItemBy(indexPath.section)[indexPath.row]
        cell.title.text = title
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        //1
        switch kind {
            //2
        case UICollectionElementKindSectionHeader:
            //3
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind,withReuseIdentifier: "BasicInfoHeaderView",forIndexPath: indexPath) as! BasicInfoHeader
            headerView.delegate = self
            headerView.headerLabel.text =  Constants.personInfoHeader[indexPath.section]
            headerView.tag = indexPath.section
            headerView.updateArrowLabel(expandedRows.contains(indexPath.section))
            return headerView
        default:
            //4
            assert(false, "Unexpected element kind")
        }
    }
}
extension BasicInfoViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSize(width: Int(collectionView.frame.size.width)/columns - 25, height: Int(collectionView.frame.size.height)/10)
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


extension BasicInfoViewController : BasicInfoHeaderDelegate {
    
    func onEditButtonclick(sender: BasicInfoHeader) {
        if let con = MyUtils.presentViewController(self, identifier: "EditInfoViewController") as? BaseEditViewController {
            let data = EditInfoData(type: sender.tag)
            con.setDataSourceWith(.EDIT, and: data)
        }
    }
    
    func onHeaderClick(sender: BasicInfoHeader) {
        if expandedRows.contains(sender.tag) {
            expandedRows.remove(sender.tag)
        }
        else{
            expandedRows.insert(sender.tag)
        }
        self.collectionView?.reloadData()
    }
    
}
