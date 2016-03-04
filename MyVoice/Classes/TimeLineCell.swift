//
//  TimeLineView.swift
//  MyVoice
//
//  Created by PB014 on 04/03/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit


class TimeLineCell: BaseAnalyticsCell {
    var firstButton:DLRadioButton!
    var secondButton:DLRadioButton!
    
    override func prepareForData() {
        let controller = TimeLineChartController()
        controller.title = MyStrings.last3Month
        controllers.append(controller)
        
        let controller2 = TimeLineChartController()
        controller2.title = MyStrings.last6Month
        controller2.type = .Last6Month
        controllers.append(controller2)
        
        let controller3 = TimeLineChartController()
        controller3.title = MyStrings.lastYear
        controller3.type = .LastYear
        controllers.append(controller3)
    }
    
    override func addExtraViewOnTabBar(view: UIView) {
        firstButton = DLRadioButton(frame: CGRect(x: view.frame.width - 250, y: 10, width: 220, height: 30))
        firstButton.setTitle(MyStrings.cityPusle, forState: UIControlState.Normal)
        firstButton.setTitleColor(Constants.grayColor_101, forState: UIControlState.Normal)
        firstButton.iconColor = Constants.accentColor
        firstButton.indicatorColor = Constants.accentColor
        firstButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        
        firstButton.addTarget(self, action: "onCityPulseClick", forControlEvents: UIControlEvents.TouchUpInside)
        
        firstButton.selected = true
        
        secondButton = DLRadioButton(frame: CGRect(x: view.frame.width - 110, y: 10, width: 80, height: 30))
        secondButton.setTitle(MyStrings.web, forState: UIControlState.Normal)
        secondButton.setTitleColor(Constants.grayColor_101, forState: UIControlState.Normal)
        secondButton.iconColor = Constants.accentColor
        secondButton.indicatorColor = Constants.accentColor
        secondButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        
        secondButton.addTarget(self, action: "onWebClick", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        view.addSubview(firstButton)
        view.addSubview(secondButton)
        
    }
    
    func onCityPulseClick() {
        
    }
    
    func onWebClick(){
        secondButton.selected = false
    }
    
    
}
