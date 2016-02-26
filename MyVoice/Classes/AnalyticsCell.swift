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
        //tabsView?.delegate = self
        addSubview((tabsView?.view)!)
        
    }
    
    func addExtraViewOnTabBar(view : UIView){
        
    }
    
}



class TimeLineView: BaseAnalyticsCell {
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



class ReviewAnalysisView: BaseAnalyticsCell {
    var filterTextView : UITextField!
    var filterPopOver : PopTable!
    var filterItems : [String]!
    override func prepareForData() {
        let controller = ReviewAnalysisController()
        controller.title = MyStrings.last3Month
        controllers.append(controller)
        let controller2 = ReviewAnalysisController()
        controller2.title = MyStrings.last6Month
        controller2.type = .Last6Month
        controllers.append(controller2)
        let controller3 = ReviewAnalysisController()
        controller3.title = MyStrings.lastYear
        controller3.type = .LastYear
        controllers.append(controller3)
    }
    
    override func addExtraViewOnTabBar(view: UIView) {
        filterItems = BaseFilter.getFilterValues(Constants.reviewFilters)
        
        filterTextView = UITextField(frame: CGRect(x: (view.frame.width) - 180 - 20, y: 14, width: 200, height:30))
        filterTextView.delegate = self
        filterTextView.text = filterItems[0]
        filterTextView.textAlignment = NSTextAlignment.Right
        filterTextView.textColor = Constants.accentColor
        
        
        filterTextView.rightViewMode = UITextFieldViewMode.Always
        let image = UIImageView(image: UIImage(named: "downarrow"))
        // image.contentMode = UIViewContentMode.Right
        image.image = image.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        image.frame = CGRect(x: 8, y: 0, width: 20, height: 20)
        image.tintColor = Constants.accentColor
        filterTextView.rightView = image
        
        filterTextView.sizeToFit()
        
        
        view.addSubview(filterTextView)
        
        
        
        var info = [[String]]()
        info.append(filterItems)
        
        filterPopOver = PopTable(forTextField: filterTextView, data: PopInfo(items: info,heading: MyStrings.filters))
        
    }
    
    func onFilterSelected(index: Int){
        ((tabsView.controllerArray[tabsView.currentPageIndex]) as! ReviewAnalysisController).onSomeActionTaken(index)
    }
}

extension ReviewAnalysisView : UITextFieldDelegate {
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if let c = UIApplication.topViewController() {
            
            filterPopOver.pick(c, initData: [textField.text ?? ""]) {[weak self] (newSelection, forTextField) -> () in
                if newSelection.count > 0 {
                    forTextField.text = newSelection[0]
                    self?.filterTextView.sizeToFit()
                    self?.onFilterSelected(self?.filterItems.indexOf(newSelection[0]) ?? 0)
                }
            }
            
            return false
        }
        return true
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
        
        // basic settings
        chartView.descriptionText = ""
        chartView.legend.enabled = false
        chartView.doubleTapToZoomEnabled = false
        chartView.drawGridBackgroundEnabled = false
        
        chartView.leftAxis.labelFont = UIFont.systemFontOfSize(13)
        chartView.xAxis.labelFont = UIFont.systemFontOfSize(13)
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
        }
        else {
            dic["start"] = 0
            dic["range"] = 15
            dic["month"] = count
            dic["index"] = type.rawValue
            
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
        chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .EaseInCubic)
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
        line.lineColor = UIColor.darkGrayColor()
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
            
            for i in data.count..<(12) {
                months.append("")
            }
            
            let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Sentiments")
            chartDataSet.barSpace = 0.5
            chartDataSet.colors = colors
            chartDataSet.valueFont = UIFont.systemFontOfSize(11.0)
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
    
    override func viewDidLoad() {
        xibName = "ReviewAnalysis"
        serverListRequestType = PersonInfoRequestType.ReviewAnalysis.rawValue
        
        super.viewDidLoad()
        
        let view = mainView.viewWithTag(5)
        
        
        reviewConroller = MyUtils.getViewControllerFromStoryBoard("AdditionalUI", controllerName: "ReviewViewController") as? ReviewsViewController
        
        if reviewConroller != nil {
            reviewConroller.isAnalyticsView = true
            addChildViewController(reviewConroller)
            reviewConroller.view.frame = (view?.frame)!
            self.view.addSubview(reviewConroller.view)
            reviewConroller.didMoveToParentViewController(self)
            
        }
        

        onSomeActionTaken(0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let view = mainView.viewWithTag(5)
        print(view?.frame)
        reviewConroller.view.frame = (view?.frame)!
    }
    
    override func doSomeMoreSettingofChart() {
        chartView.delegate = self
        chartView.leftAxis.forceLabelsEnabled = true
    }
    
    
    override func onSomeActionTaken(index: Int) {
        let newFilter =  Constants.reviewFilters[index]
        
        if newFilter.index != currentFilter.index {
            
            currentFilter = newFilter
            fetchListFromStart()
            
        }
        
    }
    
    
    override func loadDataInCharts() {
        if let data = entries {
            
            var months = [String]()
            var dataEntries: [BarChartDataEntry] = []
            var colors = [UIColor]()
            
            chartView.leftAxis.labelCount = min(6, dataEntries.count)

            for i in 0..<data.count {
                if let val = data[i] as? SentimentTimelineData {
                    let dataEntry = BarChartDataEntry(value: Double(val.value), xIndex: i)
                    dataEntries.append(dataEntry)
                    months.append(val.label)
                }
            }
            
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
            assertionFailure()
        }
    }
    
    
    override func updateListEntries(parameter: [String : AnyObject]) {
        
        entries = CurrentSession.i.personController.person.reviewAnalysisListManager[type.rawValue][currentFilter.index].entries
        
        super.updateListEntries(parameter)
    }
    
    
    override func getParameterForListFetching(t: Int) -> [String :AnyObject]{
        
        var dic = super.getParameterForListFetching(t)
        
        var min = 60 - 40 * currentFilter.index
        //  min = 20
        dic["min"] = min
        dic["max"] = min + 40
        dic["filter"] = currentFilter.index
        return dic
        
    }
}

extension ReviewAnalysisController : ChartViewDelegate {
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight){
        if selectedMonth != highlight.xIndex {
            selectedMonth = dataSetIndex
            updateReview()
        }
        
    }
    
    
}

