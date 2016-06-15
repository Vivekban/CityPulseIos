//
//  EventsViewController.swift
//  MyVoice
//
//  Created by PB014 on 13/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class EventsViewController: BaseProfileHeaderCollectionView {
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        serverListRequestType = PersonInfoRequestType.Event.rawValue

        super.viewDidLoad()

        expandedRows.insert(0)
        columns = 1
        reuseIdentifier = "EventCell"
        editControlllerIdentifier = "EditEventViewController"
        
        entries = CurrentSession.i.personController.person.eventsListManager.entries
        
//        for _ in 0...3{
//            entries.append(EventData())
//        }
        
        collecView = collectionView
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if super.collectionView(collectionView, numberOfItemsInSection: section) > 0{
            return 1
        }
        return 0
    }

    
    
    override func reloadData(index:Int) {
        collectionView.reloadData()
    }
    
    override func getDataForNewItem() ->BaseData {
        return EventData()
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! EventCollectionViewCell
        
        // Configure the cellmamamamdsma
        if let d = entries[indexPath.section] as? EventData{
            cell.loaction.text = d.location?.city
            cell.descrption.text = d.description
            cell.website.text = d.website
            cell.time.text = d.startTime + " " + MyStrings.to + " " + d.endTime
            
            ServerImageFetcher.i.loadImageWithDefaultsIn(cell.image, url: d.imagesUrls.count > 0 ? d.imagesUrls[0]: "" )
           
        }
    
        return cell
    }
    
    override func getTitleForHeader(index: Int) -> String {
        return (entries[index] as! EventData).title
    }
    
            
    override func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSize(width: Int(collectionView.frame.size.width)/columns, height: 160)
    }
    
    
}

