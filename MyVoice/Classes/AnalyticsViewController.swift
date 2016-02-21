//
//  AnalyticsViewController.swift
//  MyVoice
//
//  Created by PB014 on 19/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class AnalyticsViewController: BaseHeaderCollectionView {

    @IBOutlet weak var collectionView: UICollectionView!

    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        expandedRows.insert(0)
        columns = 1
        reuseIdentifier = "AnalyticsCell"
        
        entries = CurrentSession.i.personController.person.eventsListManager.entries
        
                for _ in 0...3{
                    entries.append(EventData())
                }
        
        collecView = collectionView
        
        collectionView.registerClass(TimeLineView.self, forCellWithReuseIdentifier: reuseIdentifier)
        // isReloadEntries = false
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if super.collectionView(collectionView, numberOfItemsInSection: section) > 0{
            return 1
        }
        return 0
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return entries.count
    }
    
    override func reloadData(index:Int) {
        collectionView.reloadData()
    }
    
    override func getDataForNewItem() ->BaseData {
        return EventData()
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! BaseAnalyticsCell
        
        // Configure the cell
        if let d = entries[indexPath.section] as? EventData{
//            cell.loaction.text = d.location?.city
//            cell.descrption.text = d.description
//            cell.website.text = d.website
//            cell.time.text = d.startTime + "  " + d.endTime
//            
//            ServerImageFetcher.i.loadImageWithDefaultsIn(cell.image, url: d.imagesUrls.count > 0 ? d.imagesUrls[0]: "" )
            
        }
        
        return cell
    }
    
    override func getTitleForHeader(index: Int) -> String {
        return (entries[index] as! EventData).title
    }

}


extension AnalyticsViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSize(width: Int(collectionView.frame.size.width) - 25, height: 400)
    }
    
    
}