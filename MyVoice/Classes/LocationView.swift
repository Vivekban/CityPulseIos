//
//  LocationView.swift
//  MyVoice
//
//  Created by PB014 on 16/06/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit
import CoreLocation


class MyPlacemark {
    
    var subThoroughfare:String?
    var thoroughfare:String?
    var subLocality:String?
    var locality:String?
    var subAdministrativeArea:String?
    var administrativeArea:String?
    var address:String?
    var pincode:String?
    var cordinate:CLLocationCoordinate2D?
    
    func initWithPlacemark(p : CLPlacemark)  {
        
        subThoroughfare = p.subThoroughfare ?? ""
        thoroughfare = p.thoroughfare ?? ""
        subLocality = p.subLocality ?? ""
        locality =  p.locality ?? ""
        subAdministrativeArea = p.subAdministrativeArea ?? ""
        administrativeArea = p.administrativeArea ?? ""
        pincode = p.postalCode
        cordinate  = p.location?.coordinate
    }
    
}



class LocationView: UIView {
    
    @IBOutlet weak var myLocation: UILabel!
    @IBOutlet weak var otherLocation: UITableView!
    
    
    var mainLocaiton: MyPlacemark?
    var locations = [MyPlacemark]()
    
    var offset:Float = 0.03 {
        didSet{
            if offsetLabel != nil {
                offsetLabel.text = "\(offset)"
            }
        }
    }
    
    var change:Float = 0.0
    
    
    
    @IBOutlet weak var offsetLabel: UILabel!
    
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        otherLocation.dataSource = self
        otherLocation.estimatedRowHeight = 220.0
        otherLocation.rowHeight = UITableViewAutomaticDimension
        
         offsetLabel.text = "\(offset)"
        
        for _ in 0...7 {
            locations.append(MyPlacemark())
        }
    }
    
    func updateLocations( location : MyPlacemark, index: Int) {
        self.locations[index] = location
        otherLocation.reloadRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
        
    }
    
    func updateMainLocation(location : MyPlacemark) {
        mainLocaiton = location
        myLocation.text = getInfo(mainLocaiton!)
        
    }
    
    
    //MARK: UITableViewDelegate
    
    func getInfo(p : MyPlacemark) -> String {
        
        var info = ""
        
//        if p.cordinate != nil {
//            info += ("\(p.cordinate!)")
//        }
        
//        info +=  "\n Throughfare - \(p.thoroughfare ?? "") \n"
//        info += " Sub Locality - \(p.subLocality ?? ""), Locality -\(p.locality ?? "") \n Sub Admistrative Area  \(p.subAdministrativeArea ?? ""), Admistrative Area - \( p.administrativeArea ?? "") \n Postal Code \(p.pincode ?? "") \n Address - \(p.address ?? "" ), "
//        

        info += "Address - \(p.address ?? "")"
        
        return info;
        
    }
    
    @IBAction func dcreaseOffset(sender: UIButton) {
        
        if change < 0 {
            change -= 0.005
        }
        else{
            change = -0.005
            
        }
        
        offset += change;
        
    }
    
    
    @IBAction func increaseOffset(sender: AnyObject) {
        if change > 0 {
            change += 0.005
        }
        else{
            change = 0.005
            
        }
        
        offset += change;
        
    }
    
}



extension LocationView : UITableViewDataSource {
    //MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell?
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        
        configureCell(cell!, forRowAtIndexPath: indexPath)
        return cell!
    }
    
    func configureCell(cell: UITableViewCell, forRowAtIndexPath: NSIndexPath) {
        
        cell.textLabel?.text =  getInfo(locations[forRowAtIndexPath.row])
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.layoutIfNeeded()
    }
}