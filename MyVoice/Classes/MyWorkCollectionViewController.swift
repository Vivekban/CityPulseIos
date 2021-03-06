//
//  MyWorkCollectionViewController.swift
//  MyVoice
//
//  Created by PB014 on 07/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit


class MyWorkCollectionViewController: BaseProfileNestedViewController {
    
    @IBOutlet weak var collecitonView: UICollectionView!

    override func viewDidLoad() {
        serverListRequestType = PersonInfoRequestType.Work.rawValue
        super.viewDidLoad()
        
        columns = 3
        numberOfSections = 1
        reuseIdentifier = "WorkCell"
        editControlllerIdentifier = "EditWorkViewController"
        detailControllerIdentifier = "MyWorkDetailController"
        // add dummy data
//        for i in 1...2 {
//            let dummyWork = MyWorkData()
//            dummyWork.description = "Description of work \(i)"
//            dummyWork.title = "Title of work \(i)"
//            dummyWork.date = "20/12/2009"
//            entries.append(dummyWork)
//        }
        collecView = collecitonView
        entries = CurrentSession.i.personController.person.worksListManager.entries
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func getDataForNewItem() ->BaseData {
        return MyWorkData()
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return entries.count
        
    }
    
    
    
//    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
//        let controller = MyUtils.presentViewController(self, identifier: "EditWorkViewController")
//        if let editController = controller as? BaseEditViewController {
//            editController.setDataSourceWith(.EDIT, and: entries[indexPath.row])
//        }
//    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MyWorkCollectionViewCell
        
        // indexPath.section
        // indexPath.row
        // Configure the cell
        if let info = entries[indexPath.row] as? MyWorkData{
            cell.details.text = info.description
            cell.date.text = info.disPlayDate
            cell.title.text = info.title
            cell.likes.text = "\(info.likes)"
            cell.comments.text = "\(info.comments?.count ?? 0)"
            cell.category.text = info.category
        }
        
        return cell
    }
    

    
}

