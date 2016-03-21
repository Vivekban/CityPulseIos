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
        
        
        let parameters: [CAPSPageMenuOption] = [
            .SelectionIndicatorColor(Constants.accentColor),
            .MenuHeight(50),
            //.MenuItemSeparatorWidth(15),
            .SelectionIndicatorHeight(7),
            .MenuItemWidth(menuItemWidth)
        ]
        
        
        tabsView = CAPSPageMenu(viewControllers: controllers, frame: CGRect(x: 0, y: 0, width: Int(frame.width), height: Int(frame.height)), pageMenuOptions: parameters)
        
        addExtraViewOnTabBar(tabsView.view)
        tabsView?.delegate = self
        addSubview((tabsView?.view)!)
        
    }
    
    func addExtraViewOnTabBar(view : UIView){
        
    }
    
}

extension BaseAnalyticsCell : CAPSPageMenuDelegate {
    func willMoveToPage(controller: UIViewController, index: Int) {
        
    }
}


enum TimeLineChartControllerType : Int{
    case Last3Month = 0, Last6Month, LastYear
}




struct MyBarChartData {
    var dataPoints = [String]()
    var values = [Int]()
}

class BaseBarChartController : UIViewController {
    var mainView : UIView!
    var chartView : BarChartView!
    var type  = TimeLineChartControllerType.Last3Month
    
    var xibName = "TimelineView"
    
    var entries:[BaseData]?
    
    // data fetching
    var serverListRequestType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchListFromStart()
        
        mainView = NSBundle.mainBundle().loadNibNamed(xibName, owner: self, options: nil)[0] as! UIView
        chartView = mainView.viewWithTag(1) as! BarChartView
        
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
        //chartView.xAxis.valueFormatter = ChartXAxisValueFormatter()
        
        doSomeMoreSettingofChart()
        
        mainView.frame = view.frame
        view.addSubview(mainView)
        
    }
    
    
    func getParameterForListFetching(t: Int) -> [String :AnyObject]{
        var count = 3
        if type == TimeLineChartControllerType.Last6Month {
            count*=2
        }
        else if (type == .LastYear) {
            count*=4
        }
        
        
        var dic = [String: AnyObject]()
        if t == 0 {
            dic["start"] = 0
            dic["range"] = 20
            dic["month"] = count
            dic["index"] = type.rawValue
            dic["tab"] = type.rawValue
        }
        else {
            dic["start"] = 0
            dic["range"] = 15
            dic["month"] = count
            dic["index"] = type.rawValue
            dic["tab"] = type.rawValue

        }
        return dic
        
    }
    
    func fetchListFromStart(){
        let params = getParameterForListFetching(0)
        fetchListFromServer(params)
    }
    
    func fetchMoreItemsInList(){
        let params = getParameterForListFetching(1)
        fetchListFromServer(params)
    }
    
    func fetchListFromServer(parameter:[String:AnyObject]){
        
        LoaderUtils.i.showLoader(self.view)
        
        CurrentSession.i.personController.fetchData(serverListRequestType,parameter: parameter,completionHandler: { [weak self](result) -> Void in
            switch (result)  {
            case ServerResult.EveryThingUpdated :
                // self?.isMoreEntriesAvailable = false
                return
            default:
                break
            }
            self?.updateListEntries(parameter)
            
            LoaderUtils.i.hideLoader()
            
            })
        
    }
    
    
    func updateEntries(){
        // tablView?.reloadData()
        //collecView?.reloadData()
        loadDataInCharts()
    }
    
    func loadDataInCharts(){
        
    }
    
    func updateListEntries(parameter:[String:AnyObject]){
        updateEntries()
    }
    
    
    
    func doSomeMoreSettingofChart(){
        
    }
    
    func onSomeActionTaken(index: Int){
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if chartView != nil {
            chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .EaseInCubic)
        }
    }
    
}

class TimeLineChartController :BaseBarChartController {
    var currentSelection = -1
    
    
    
    override func viewDidLoad() {
        entries = CurrentSession.i.personController.person.sentimentTimeLineListManager[type.rawValue].entries
        serverListRequestType = PersonInfoRequestType.SentimentTimeLine.rawValue
        super.viewDidLoad()
        onSomeActionTaken(0)
        
    }
    
    override func doSomeMoreSettingofChart() {
        
        chartView.leftAxis.customAxisMax = 100
        chartView.leftAxis.customAxisMin = -110
        chartView.leftAxis.forceLabelsEnabled = true
        chartView.leftAxis.startAtZeroEnabled = false
        chartView.leftAxis.labelCount = 11
        
        chartView.userInteractionEnabled = false
        
        let line = ChartLimitLine(limit: 0)
        line.lineWidth = 1
        line.lineColor = UIColor(red: CGFloat(190.0/255), green: CGFloat(190.0/255), blue: CGFloat(190.0/255), alpha: 1)
        chartView.leftAxis.addLimitLine(line)
    }
    
    override func onSomeActionTaken(index: Int) {
        //if currentSelection != index {
        currentSelection = index
        
        // }
    }
    
    override func loadDataInCharts() {
        if let data = entries {
            
            var months = [String]()
            var dataEntries: [BarChartDataEntry] = []
            var colors = [UIColor]()
            
            
            for i in 0..<data.count {
                //let n = random() % 200 - 100
                //            data.values.append(n)
                if let val = data[i] as? SentimentTimelineData {
                    // val.value = random() % 200 - 100
                    let dataEntry = BarChartDataEntry(value: Double(val.value), xIndex: i)
                    dataEntries.append(dataEntry)
                    colors.append(Constants.getChartColor(Double(val.value)))
                    months.append(val.label)
                }
            }
            
            for _ in data.count..<(12) {
                months.append("")
            }
            
            let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Sentiments")
            chartDataSet.barSpace = 0.5
            chartDataSet.colors = colors
            chartDataSet.valueFont = UIFont.systemFontOfSize(11.0)
            chartDataSet.valueFormatter = NSNumberFormatter()
            chartDataSet.valueColors = [Constants.grayColor_101]
            let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
            chartView.data = chartData
            chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .Linear)
        }
        
    }
    
    override func updateListEntries(parameter: [String : AnyObject]) {
        
        entries = CurrentSession.i.personController.person.sentimentTimeLineListManager[type.rawValue].entries
        
        super.updateListEntries(parameter)
    }
    
}


class ReviewAnalysisController : BaseBarChartController {
    var currentFilter: BaseFilter = Constants.reviewFilters[0]
    var reviewConroller: ReviewsViewController!
    var selectedMonth = -1
    
    var showingFilter = -1
    
    override func viewDidLoad() {
        xibName = "ReviewAnalysisView"
        serverListRequestType = PersonInfoRequestType.ReviewAnalysis.rawValue
        
        super.viewDidLoad()
        
        
        let view = mainView.viewWithTag(5)
        if let sc = mainView as? UIScrollView {
            sc.contentSize = self.view.frame.size
            
        }
        
        reviewConroller = MyUtils.getViewControllerFromStoryBoard("AdditionalUI", controllerName: "ReviewViewController") as? ReviewsViewController
        
        if reviewConroller != nil {
            reviewConroller.isAnalyticsView = true
            addChildViewController(reviewConroller)
            reviewConroller.view.frame = (view?.frame)!
            reviewConroller.view.frame.size.height = 0
            self.view.addSubview(reviewConroller.view)
            reviewConroller.didMoveToParentViewController(self)
            reviewConroller.tableView.scrollEnabled = false
            reviewConroller.tableView.alwaysBounceVertical = false
        }
        
        
        onSomeActionTaken(currentFilter.index)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func doSomeMoreSettingofChart() {
        chartView.delegate = self
        chartView.leftAxis.forceLabelsEnabled = true
    }
    
    
    override func onSomeActionTaken(index: Int) {
        let newFilter =  Constants.reviewFilters[index]
        currentFilter = newFilter
        if chartView != nil {
            if newFilter.index != showingFilter {
                showingFilter = newFilter.index
                if let d = chartView.data {
                    d.clearValues()
                }
                fetchListFromStart()
            }
        }
        updateReview()
    }
    
    
    override func loadDataInCharts() {
        if let data = entries {
            
            var months = [String]()
            var dataEntries: [BarChartDataEntry] = []
            var colors = [UIColor]()
            
            var diffValue = [0]
            var maxValue = 0
            
            
            
            for i in 0..<data.count {
                if let val = data[i] as? SentimentTimelineData {
                    let value = val.value
                    if !diffValue.contains(value){
                        diffValue.append(value)
                        maxValue = max(maxValue,value)
                    }
                    let dataEntry = BarChartDataEntry(value: Double(value), xIndex: i)
                    dataEntries.append(dataEntry)
                    months.append(val.label)
                }
            }
            
            
            chartView.leftAxis.labelCount = min(5, min (diffValue.count,maxValue - 1))
            
            
            for _ in data.count..<(12) {
                months.append("")
            }
            
            colors.append(Constants.getChartColor(Double( 100 - currentFilter.index * 50 )))
            
            let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Sentiments")
            chartDataSet.barSpace = 0.5
            chartDataSet.colors = colors
            chartDataSet.valueFont = UIFont.systemFontOfSize(11.0)
            chartDataSet.valueFormatter = NSNumberFormatter()
            let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
            chartDataSet.valueColors = [Constants.grayColor_101]
            chartView.data = chartData
            chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .Linear)
            chartView.highlightValue(highlight: ChartHighlight(xIndex: max(selectedMonth,0), dataSetIndex: 0),callDelegate: true)
        }
    }
    
    func updateReview(){
        
        if entries?.count > selectedMonth {
            if let val = entries![selectedMonth] as? ReviewAnalyticsData {
                reviewConroller.updateEntries(val.reviews)
            }
        }
        else{
            return
        }
        
        if let view = mainView.viewWithTag(5) {
            reviewConroller.view.frame = (view.frame)
            reviewConroller.view.layoutIfNeeded()
            //reviewConroller.view.layoutIfNeeded()
        }
        
        reviewConroller.view.frame.size.height = reviewConroller.tableView.contentSize.height + 100
        if let sc = mainView as? UIScrollView {
            sc.contentSize.height = reviewConroller.view.frame.height + 470
            print(sc.contentSize)
        }
        
    }
    
    
    override func updateListEntries(parameter: [String : AnyObject]) {
        
        entries = CurrentSession.i.personController.person.reviewAnalysisListManager[type.rawValue][currentFilter.index].entries
        super.updateListEntries(parameter)
        
    }
    
    
    override func getParameterForListFetching(t: Int) -> [String :AnyObject]{
        
        var dic = super.getParameterForListFetching(t)
        
        let min = 60 - 40 * currentFilter.index
        dic["min"] = min
        dic["max"] = min + 40
        dic["filter"] = currentFilter.index
        return dic
        
    }
}

extension ReviewAnalysisController : ChartViewDelegate {
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight){
        //if selectedMonth != highlight.xIndex {
        selectedMonth = highlight.xIndex
        updateReview()
        //}
        
    }
    
}

