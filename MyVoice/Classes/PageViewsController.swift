//
//  PageViewsController.swift
//  MyVoice
//
//  Created by PB014 on 11/03/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit
import Charts

class PageViewsController: BaseProfileListViewController {

    @IBOutlet weak var chartView: LineChartView!
    @IBOutlet weak var viewCount: UILabel!
    override func viewDidLoad() {
        serverListRequestType = PersonInfoRequestType.PageView.rawValue

        super.viewDidLoad()

        chartView.noDataText = ""
        // basic settings
        chartView.descriptionText = ""
        chartView.legend.enabled = false
        chartView.doubleTapToZoomEnabled = false
        chartView.drawGridBackgroundEnabled = false
        chartView.dragEnabled = false
        chartView.pinchZoomEnabled = false
        
        chartView.leftAxis.labelFont = UIFont.systemFontOfSize(13)
        chartView.leftAxis.labelTextColor = Constants.grayColor_101
        chartView.xAxis.labelFont = UIFont.systemFontOfSize(13)
        chartView.xAxis.labelTextColor = Constants.grayColor_101
        chartView.xAxis.spaceBetweenLabels = 2
        //chartView.xAxis.
        chartView.xAxis.labelPosition = ChartXAxis.XAxisLabelPosition.Bottom
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.leftAxis.drawGridLinesEnabled = false
        chartView.rightAxis.enabled = false
        chartView.leftAxis.valueFormatter = NSNumberFormatter()

        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func getTabsController() -> [UIViewController] {
        var cons = super.getTabsController()
        
        let con1 = UIViewController()
        con1.title = MyStrings.last3Month
        
        let con2 = UIViewController()
        con2.title = MyStrings.last6Month
        
        let con3 = UIViewController()
        con3.title = MyStrings.lastYear
        
        cons.append(con1)
        cons.append(con2)
        cons.append(con3)
        
        return cons
    }
    
    override func updateEntries() {
        super.updateEntries()
        loadDataInCharts()
    }

    
    func loadDataInCharts() {
        
            var months = [String]()
            var dataEntries: [BarChartDataEntry] = []
            var colors = [UIColor]()
            colors.append(Constants.accentColor)

        
            for i in 0..<entries.count {
                //let n = random() % 200 - 100
                //            data.values.append(n)
                if let val = entries[i] as? SentimentTimelineData {
                    // val.value = random() % 200 - 100
                    let dataEntry = BarChartDataEntry(value: Double(val.value), xIndex: i)
                    dataEntries.append(dataEntry)
                    months.append(val.label)
                }
            }
            
            for _ in entries.count..<(12) {
                months.append("")
            }
            
            let chartDataSet = LineChartDataSet(yVals: dataEntries, label: "")
            chartDataSet.colors = colors
            chartDataSet.valueFont = UIFont.systemFontOfSize(11.0)
            chartDataSet.valueFormatter = NSNumberFormatter()
            chartDataSet.valueColors = [Constants.grayColor_101]
            let chartData = LineChartData(xVals: months, dataSet: chartDataSet)
            chartView.data = chartData
            chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .Linear)
        
    }

    
    override func didMoveToPage(controller: UIViewController, index: Int) {
        super.didMoveToPage(controller, index: index)
        fetchListFromStart()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
