//
//  MyWorkCollectionViewController.swift
//  MyVoice
//
//  Created by PB014 on 07/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

private let reuseIdentifier = "WorkCell"

class MyWorkCollectionViewController: BaseNestedTabViewController {
    
    var myWorks = [MyWork]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add dummy data
        for i in 1...4 {
            let dummyWork = MyWork()
            dummyWork.description = "Description of work \(i)"
            dummyWork.title = "Title of work \(i)"
            dummyWork.date = MyUtils.getCurrentDateInlong()
            myWorks.append(dummyWork)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    override func onActionButtonClick(sender: AnyObject) {
         let controller = MyUtils.presentViewController(self, identifier: "EditWorkViewController")
        if let editController = controller as? BaseEditViewController {
            editController.setDataSourceWith(.NEW, and: nil)
        }
    }

}

extension MyWorkCollectionViewController : UICollectionViewDelegate{
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let controller = MyUtils.presentViewController(self, identifier: "EditWorkViewController")
        if let editController = controller as? BaseEditViewController {
            editController.setDataSourceWith(.EDIT, and: myWorks[indexPath.row])
        }
    }
    
}



extension MyWorkCollectionViewController : UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return myWorks.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        // indexPath.section
        // indexPath.row
        // Configure the cell
        
        return cell
    }
    
    
}

extension MyWorkCollectionViewController : UICollectionViewDelegateFlowLayout{
    
    //    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    //    {
    //        return CGSize(width: Int(collectionView.frame.size.width) - 5, height: Int(collectionView.frame.size.height))
    //    }
    
}