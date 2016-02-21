//
//  AnalyticsCell.swift
//  MyVoice
//
//  Created by PB014 on 19/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit
import Charts

class BaseAnalyticsCell: UICollectionViewCell {

    var tabsView : CAPSPageMenu!
    var controllers = [UIViewController]()
    var menuItemWidth:CGFloat = 120
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareForData()
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareForData(){
        
    }
    
    func setUp(){
        
//        let firstStoryboard:UIStoryboard = UIStoryboard(name: storyBoardName, bundle: nil)
//        
//        
//        for (i,identifier) in tabIndentifiers.enumerate() {
//            let controller : UIViewController = firstStoryboard.instantiateViewControllerWithIdentifier(identifier)
//            controller.title = tabTitles[i]
//            controllers.append(controller)
//        }
        
        let parameters: [CAPSPageMenuOption] = [
            .MenuItemSeparatorWidth(0),
            .SelectionIndicatorColor(Constants.accentColor),
            .MenuHeight(50),
            //.MenuItemSeparatorWidth(15),
            .SelectionIndicatorHeight(7),
            .MenuItemWidth(menuItemWidth)
        ]
        
        
        tabsView = CAPSPageMenu(viewControllers: controllers, frame: CGRect(x: 0, y: 0, width: Int(frame.width), height: Int(frame.height)), pageMenuOptions: parameters)
        //tabsView?.delegate = self
        addSubview((tabsView?.view)!)
    
    }
    
}



class TimeLineView: BaseAnalyticsCell {
    
    override func prepareForData() {
        let controller = TimeLineChartController()
        controller.title = MyStrings.lastMonth
        controllers.append(controller)
        let controller2 = TimeLineChartController()
        controller2.title = MyStrings.last3Month
        controller2.type = .Last3Month
        controllers.append(controller2)
        let controller3 = TimeLineChartController()
        controller3.title = MyStrings.lastYear
        controller3.type = .LastYear
        controllers.append(controller3)
    }
    
    
}


enum TimeLineChartControllerType : Int{
    case LastMonth = 0, Last3Month, LastYear
}


struct MyBarChartData {
    var dataPoints = [String]()
    var values = [Int]()
}

class TimeLineChartController :UIViewController {
    
    var chartView : BarChartView!
    var type  = TimeLineChartControllerType.LastMonth
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let timelineView = NSBundle.mainBundle().loadNibNamed("TimelineView", owner: self, options: nil)[0] as! UIView
        
        
        
        chartView = timelineView.viewWithTag(1) as! BarChartView
        
        //  chartView.setScaleEnabled(false)
        chartView.doubleTapToZoomEnabled = false

        chartView.drawGridBackgroundEnabled = false
        
        chartView.xAxis.labelPosition = ChartXAxis.XAxisLabelPosition.Bottom
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.leftAxis.drawGridLinesEnabled = false
        
        chartView.rightAxis.enabled = false
        
        chartView.leftAxis.customAxisMax = 100
        chartView.leftAxis.customAxisMin = -100
        chartView.leftAxis.minWidth = 20
        chartView.leftAxis.labelCount = 11
        chartView.leftAxis.valueFormatter = NSNumberFormatter()
        let line = ChartLimitLine(limit: 0)
        line.lineWidth = 1
        line.lineColor = UIColor.darkGrayColor()
        chartView.leftAxis.addLimitLine(line)
        //chartView.leftAxis.

        // chartView.leftAxis.startAtZeroEnabled = true
        
        // chartView.rightAxis.customAxisMax = -100
        
        timelineView.frame = view.frame
        view.addSubview(timelineView)
        
        chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .EaseInCubic)
        
//        var data = MyBarChartData()
//        
//        data.dataPoints.appendContentsOf(["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov"])
//        
//        var entries = [BarChartDataEntry]()
//        
//        for i in 0...10 {
//            let n = Int(arc4random_uniform(200) - 100)
//            data.values.append(n)
//            entries.append(BarChartDataEntry(values: [Double(n)], xIndex: i))
//        }
        
        
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let dataPoints = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        var dataEntries: [BarChartDataEntry] = []
        var colors = [UIColor]()
        for i in 0..<dataPoints.count {
            let n = random() % 200 - 100
            //            data.values.append(n)
            let dataEntry = BarChartDataEntry(value: Double(n), xIndex: i)
            dataEntries.append(dataEntry)
            colors.append(Constants.getChartColor(Double(n)))
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Sentiments")
        chartDataSet.barSpace = 0.5
        chartDataSet.colors = colors
        let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
        chartView.data = chartData
        
        
        
        //  chartView.data = BarChartData(xVals: data.dataPoints, dataSets: BarChartDataSet(yVals: entries, label: "Sentiment"))
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        chartView.frame = view.frame
    }

    
    
    
}


