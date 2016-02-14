//
//  BaseNestedTabViewController.swift
//  MyVoice
//
//  Created by PB014 on 28/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit


class BaseNestedTabViewController :UIViewController{
    var columns = 0
    var numberOfSections = 1
    var expandedRows = Set<Int>()
    var entries:[BaseData] = [BaseData]()
    var reuseIdentifier = ""
    var editControlllerIdentifier = ""
    var detailControllerIdentifier = ""
    
    // collections table
    var collecView:UICollectionView?
    var tablView:UITableView?
    
    // data fetching..
    var serverRequestType:Int?
    var serverDataManager: ServerDataManager?
    var isMoreEntriesAvailable = true
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        collecView?.reloadData()
        tablView?.reloadData()
    }
    
    
    
    func reloadData(index:Int){
        preconditionFailure("This method must be overridern")
    }
    
    func getDataForEditing(index :Int) ->BaseData {
        return entries[index]
    }
    func getDataForNewItem() ->BaseData {
        assertionFailure("must be overide")
        return ImageUrlData()
    }
    
    func showDetailViewController(index:Int) -> UIViewController?{
        let controller = MyUtils.presentViewController(self, identifier: detailControllerIdentifier)
        if let editController = controller as? BaseDetailViewController {
            editController.setDataSourceWith(entries, index: index)
            editController.delegate = self
        }
        return controller
    }
    
    func showEditViewController(type: EditControllerType,index:Int) -> UIViewController?{
        var controller = MyUtils.presentViewController(self, identifier: editControlllerIdentifier)
        if let con = controller as? BaseEditViewController {
            con.setDataSourceWith(type, data: &entries, index: index)
            con.delegate = self
            
        }
        return controller
    }
    
    
    // MARK: - Data fetching from server
    
    func fetchInfoFromServer(){
        
        if let manager = serverDataManager {
            
            if let d = serverRequestType {
                manager.fetchData(d, completionHandler: { [weak self](result) -> Void in
                    
                    switch (result)  {
                    case ServerResult.EveryThingUpdated :
                        self?.isMoreEntriesAvailable = false
                        return
                    default:
                        break
                    }
                    self?.updateEntries()
                })
            }
        }
    }
    
    func fetchListFromServer(parameter:[String:AnyObject]){
        if let manager = serverDataManager {
            
            if let d = serverRequestType {
                manager.fetchData(d,parameter: parameter,completionHandler: { [weak self](result) -> Void in
                    switch (result)  {
                    case ServerResult.EveryThingUpdated :
                        self?.isMoreEntriesAvailable = false
                        return
                    default:
                        break
                    }
                    self?.updateListEntries(parameter)
                })
            }
        }
    }
    
    
    func updateEntries(){
        tablView?.reloadData()
        collecView?.reloadData()
    }
    
    func updateListEntries(parameter:[String:AnyObject]){
        
    }

}





// MARK: - Scrollview delegate

extension BaseNestedTabViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // log.info("scroll view is getting event  \(scrollView.panGestureRecognizer.velocityInView(scrollView.superview))")
        NSNotificationCenter.defaultCenter().postNotificationName(Constants.notification_center_scroll_key, object: scrollView)
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        NSNotificationCenter.defaultCenter().postNotificationName(Constants.notification_center_scroll_event_key, object: 1)
        
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        NSNotificationCenter.defaultCenter().postNotificationName(Constants.notification_center_scroll_event_key, object: 2)
        
    }
    
}


extension BaseNestedTabViewController : BaseDetaiViewControllerDelegate {
    func onEditButtonClick(index: Int) {
        
        MyUtils.delay(0.05) {[weak self] () -> () in
            self?.showEditViewController(EditControllerType.EDIT,index: index)
        }
        
        //  performSelector("showEditViewController:", withObject: index, afterDelay: 0.1)
        //
    }
}

extension BaseNestedTabViewController : BaseEditViewControllerDelegate {
    func afterSaveDetail(type: EditControllerType, modifiedData: [BaseData], index: Int) {
        switch (type) {
        case .NEW:
            entries = modifiedData
            break;
        default:
            break;
        }
    }
}

extension BaseNestedTabViewController : BaseNestedTabProtocoal{
    
    func onActionButtonClick(sender: AnyObject) {
        showEditViewController(EditControllerType.NEW, index: -1)
    }
}

extension BaseNestedTabViewController : UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return numberOfSections
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !expandedRows.contains(section){
            return 0
        }
        return 1
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        return cell
    }
    
}




extension BaseNestedTabViewController :UICollectionViewDelegate{
    
}

extension BaseNestedTabViewController :UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier)!
        configureTableCell(cell, indexPath: indexPath)
        return cell
    }
    
    func configureTableCell(cell:UITableViewCell, indexPath:NSIndexPath){
        
    }
    
}

extension BaseNestedTabViewController :UITableViewDelegate{
    
}



extension BaseNestedTabViewController : ListHeaderDelegate {
    
    func onEditButtonclick(index: Int) {
        showEditViewController(EditControllerType.EDIT,index: index)
    }
    
    func onHeaderClick(index: Int) {
        if expandedRows.contains(index) {
            expandedRows.remove(index)
        }
        else{
            expandedRows.insert(index)
        }
        reloadData(index)
    }
    
    func onDetailClick(index: Int) {
        showDetailViewController(index)
    }
    
}


//class BaseNestedTabCollectionViewController : UICollectionViewController{
//
//}
//
//
//
//class BaseNestedTabTableViewController : UITableViewController{
//
//}
//
//extension BaseNestedTabTableViewController : BaseNestedTabProtocoal{
//
//
//    func onActionButtonClick(sender: AnyObject) {
//
//    }
//}

protocol BaseNestedTabExpansion{
    
    
}


protocol BaseNestedTabProtocoal{
    
    func onActionButtonClick(sender: AnyObject)
    
}



class BaseHeaderCollectionView: BaseNestedTabViewController {
    
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        switch kind {
            //2
        case UICollectionElementKindSectionHeader:
            //3
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind,withReuseIdentifier: "BasicInfoHeaderView",forIndexPath: indexPath) as! BasicInfoHeader
            headerView.delegate = self
            headerView.headerLabel.text = getTitleForHeader(indexPath.section)
            headerView.tag =  indexPath.section
            headerView.updateArrowLabel(expandedRows.contains(indexPath.section))
            return headerView
        default:
            //4
            assert(false, "Unexpected element kind")
        }
        return UICollectionReusableView()
        
    }
    
    func getTitleForHeader(index :Int) -> String {
        preconditionFailure("ethod must be ovveriidern ")
    }
    
}




