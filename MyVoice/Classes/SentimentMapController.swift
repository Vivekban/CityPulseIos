//
//  SentimentMapController.swift
//  MyVoice
//
//  Created by PB014 on 04/03/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit



class SentimentMapController :BaseBarChartController {
    var currentSelection = -1
    
    
    
    override func viewDidLoad() {
       let mainView = NSBundle.mainBundle().loadNibNamed("SentimentMapView", owner: self, options: nil)[0] as! UIView
        
        mainView.frame = view.frame
        view.addSubview(mainView)

    }
    
}

