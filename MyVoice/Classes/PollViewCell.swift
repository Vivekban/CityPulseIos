//
//  PollViewCell.swift
//  MyVoice
//
//  Created by PB014 on 09/03/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit
import MapKit

class PollViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var locationView: MKMapView!

    
    
    @IBOutlet weak var supportesLabel: UILabel!
    
    @IBOutlet weak var opposersLabel: UILabel!
    
    
    @IBAction func onYesButtonClick(sender: AnyObject) {
    }
    @IBAction func onNoButtonClick(sender: AnyObject) {
    }
    
}
