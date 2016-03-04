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
        
                for i in 0...2{
                    let d = TitleDescriptionData()
                    
                    switch (i) {
                    case 0:
                        d.title = MyStrings.sentimentTimeline
                        break;
                    case 1:
                        d.title = MyStrings.sentimentMap
                        break
                    case 2:
                        d.title = MyStrings.reviewAnalysis
                        break
                    default:
                        break;
                    }
                    
                    entries.append(d)
                }
        
        collecView = collectionView
        
        collectionView.registerClass(TimeLineCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.registerClass(ReviewAnalysisCell.self, forCellWithReuseIdentifier: "reviewCell")
        collectionView.registerClass(SentimentMapCell.self, forCellWithReuseIdentifier: "sentimentMapCell")

        isEditButtonHidden = true
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
    
    
    
    override func getDataForNewItem() ->BaseData {
        return TitleDescriptionData()
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var identifier = reuseIdentifier
        
        if indexPath.section == 2 {
            identifier = "reviewCell"
        }
        else if (indexPath.section == 1){
            identifier = "sentimentMapCell"

        }
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! BaseAnalyticsCell
        
        // Configure the cell
    //        if let d = entries[indexPath.section] as? TitleDescriptionData{
//            cell.loaction.text = d.location?.city
//            cell.descrption.text = d.description
//            cell.website.text = d.website
//            cell.time.text = d.startTime + "  " + d.endTime
//            
//            ServerImageFetcher.i.loadImageWithDefaultsIn(cell.image, url: d.imagesUrls.count > 0 ? d.imagesUrls[0]: "" )
            
        //       }
        
        return cell
    }
    
    override func getTitleForHeader(index: Int) -> String {
        return (entries[index] as! TitleDescriptionData).title
    }

//    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
//        
//        
//        let view = super.collectionView(collectionView, viewForSupplementaryElementOfKind: kind, atIndexPath: indexPath)
//        
//        if let header = view as? BasicInfoHeader {
//            header.editButton.hidden = true
//        }
//        
//        return view
//        
//    }

}


extension AnalyticsViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        print(collectionView.frame.height)
        
        if indexPath.section == 2 {
            return CGSize(width: (collectionView.frame.size.width), height: 450 + collectionView.frame.height)
        }
        
        return CGSize(width: (collectionView.frame.size.width), height: 400)
    }
    
    
}