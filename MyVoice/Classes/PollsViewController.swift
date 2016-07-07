//
//  PollsViewController.swift
//  MyVoice
//
//  Created by PB014 on 09/03/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit
import MapKit

class PollsViewController: HomeBaseNestedTabController {
    
    @IBOutlet weak var collectionView: UICollectionView!


    override func viewDidLoad() {
        tab = 2
        serverListRequestType = currentFilter?.dataRequestType ?? 0
        
        columns = 3
        
        super.viewDidLoad()

        collecView = collectionView
        editControlllerIdentifier = "EditPollControlller"
        reuseIdentifier = "PollCell"
        
        entries = getAllEntries()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func getAllEntries() -> [BaseData] {
        return CurrentSession.i.issueController.homeDataLists.pollsListsManager[currentFilter?.index ?? 0].entries
    }
 
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PollViewCell
        
        
        if let d = entries[indexPath.row] as? PollData{
            cell.title.text = d.title
            cell.category.text = d.category
            cell.date.text = d.disPlayDate
            cell.supportesLabel.text = d.supporters.toString()
            cell.opposersLabel.text = d.opposers.toString()
            
            
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
    
    
        
    

}
