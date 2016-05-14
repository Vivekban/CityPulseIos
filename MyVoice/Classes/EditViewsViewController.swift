//
//  EditViewsViewController.swift
//  MyVoice
//
//  Created by PB014 on 30/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit
import Charts
import SwiftyJSON

class EditViewsViewController: BaseEditViewController {
    
    @IBOutlet weak var titleField: UITextField!
    // @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var descriptionField: DescriptionView!
    
    
    
    @IBOutlet weak var emotionBarChart: HorizontalBarChartView!
    @IBOutlet weak var laungauageBarChart: BarChartView!
    @IBOutlet weak var socailHorBarChart: HorizontalBarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTitle = "View".localized
        super.viewDidLoad()
        //     popDatePickerTextFields.append(PopDatePickerParam(field: dateField, mode: .Date))
        addItemUrl = ServerUrls.addViewUrl
        updateItemUrl = ServerUrls.updateViewUrl
        // dateField.hidden = true
        // shadowObject.append(descriptionField)
        // Do any additional setup after loading the view.
        doBasicSettingOnCharts(emotionBarChart)
        doBasicSettingOnCharts(socailHorBarChart)
        doBasicSettingOnCharts(laungauageBarChart)
        configureEmotionChart()
        configureSocialChart()
        configureLanguageChart()
        resetDataInTables()
    }
    
    func doBasicSettingOnCharts(chartView:BarChartView){
        chartView.descriptionText = ""
        chartView.legend.enabled = false
        chartView.doubleTapToZoomEnabled = false
        chartView.dragEnabled = false
        chartView.pinchZoomEnabled = false
        
        // chartView.drawGridBackgroundEnabled = false
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.xAxis.labelFont = UIFont.systemFontOfSize(14)
        chartView.xAxis.labelTextColor = Constants.grayColor_101
        chartView.xAxis.spaceBetweenLabels = 0
        chartView.xAxis.labelPosition = ChartXAxis.XAxisLabelPosition.Bottom
        chartView.xAxis.drawGridLinesEnabled = false
        
        chartView.leftAxis.drawAxisLineEnabled = false
        chartView.leftAxis.labelFont = UIFont.systemFontOfSize(13)
        chartView.leftAxis.labelTextColor = Constants.grayColor_101
        chartView.leftAxis.drawGridLinesEnabled = false
        chartView.leftAxis.valueFormatter = NSNumberFormatter()
        chartView.leftAxis.valueFormatter?.maximumFractionDigits = 0
        
        chartView.rightAxis.enabled = false
        chartView.rightAxis.valueFormatter = NSNumberFormatter()
        chartView.rightAxis.valueFormatter?.maximumFractionDigits = 0
        
        chartView.leftAxis.customAxisMax = 1
        chartView.leftAxis.customAxisMin = 0
        chartView.leftAxis.forceLabelsEnabled = true
        // chartView.leftAxis.startAtZeroEnabled = false
        chartView.leftAxis.labelCount = 3
        
        chartView.drawBarShadowEnabled = true
        chartView.drawValueAboveBarEnabled = false
        
        
    }
    
    func configureEmotionChart(){
        
        let axis = emotionBarChart.rightAxis
        axis.enabled = true
        axis.drawAxisLineEnabled = false
        axis.labelFont = UIFont.systemFontOfSize(14)
        axis.labelTextColor = Constants.grayColor_101
        axis.drawGridLinesEnabled = false
        
        emotionBarChart.leftAxis.enabled = false
        //chartView.leftAxis.valueFormatter = NSNumberFormatter()
        
        emotionBarChart.rightAxis.needsOffset
        
        axis.customAxisMax = 1
        axis.customAxisMin = 0
        axis.forceLabelsEnabled = true
        // chartView.leftAxis.startAtZeroEnabled = false
        axis.labelCount = 2
        
        
        axis.valueFormatter = EmotionChartNumberFormatter()
        axis.valueFormatter?.maximumFractionDigits = 4
        
        
      
        
        
        let line = ChartLimitLine(limit: 0.45)
        //line.label = "Medium"
        // line.labelPosition = ChartLimitLine.ChartLimitLabelPosition.LeftBottom
        line.lineWidth = 1
        line.lineColor = Constants.grayColor_217
        emotionBarChart.rightAxis.addLimitLine(line)
        
        let line2 = ChartLimitLine(limit: 0.8)
        //line2.label = "\n\nHigh"
        //line2.labelPosition = ChartLimitLine.ChartLimitLabelPosition.LeftBottom
        line2.lineWidth = 1
        line2.lineColor = Constants.grayColor_217
        emotionBarChart.rightAxis.addLimitLine(line2)
        
        
        
       
    }
    
    func configureLanguageChart(){
        let axis = laungauageBarChart.leftAxis
        axis.enabled = false
        // axis.drawAxisLineEnabled = false
        // axis.drawGridLinesEnabled = false
        //chartView.leftAxis.valueFormatter = NSNumberFormatter()
        axis.labelTextColor = UIColor.whiteColor()
        
        
        axis.customAxisMax = 1
        axis.customAxisMin = 0
        axis.forceLabelsEnabled = true
        // chartView.leftAxis.startAtZeroEnabled = false
        axis.labelCount = 2
        
    
    }
    
    func configureSocialChart(){
        
        let axis = socailHorBarChart.rightAxis
        axis.enabled = true
        axis.drawAxisLineEnabled = false
        axis.labelFont = UIFont.systemFontOfSize(14)
        axis.labelTextColor = UIColor.whiteColor()
        axis.drawGridLinesEnabled = false
        
        socailHorBarChart.leftAxis.enabled = false
        //chartView.leftAxis.valueFormatter = NSNumberFormatter()
        
        
        axis.customAxisMax = 1
        axis.customAxisMin = 0
        axis.forceLabelsEnabled = true
        // chartView.leftAxis.startAtZeroEnabled = false
        axis.labelCount = 2
        
        
        
        
        
        
        
    }
    
    
    
    private func resetDataInTables(){
        var months = ["Saddness","Joy","Fear","Disgust","Anger"]
        var dataEntries: [Double] = []
        for _ in 0..<months.count {
            dataEntries.append(0)
        }
        setChartDataForEmotional(months, scores: dataEntries)
        
        months = ["Analytical","Confident","Tentative"]
        dataEntries.removeAll()
        for _ in 0..<months.count {
            dataEntries.append(0)
        }
        setChartDataForLanguage(months, scores: dataEntries)
        
        
        
        months = ["Emotional","Agreeableness","Extraversion","Conscientiousness","Openness"]
        dataEntries.removeAll()

        for _ in 0..<months.count {
            dataEntries.append(0)
        }
        
        setChartDataForSocial(months, scores: dataEntries)

        
    }
    
    
    override func getDataForNewItem() -> BaseData {
        return MyViewData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func initialiseViews() {
        super.initialiseViews()
        if let d = data as? MyViewData {
            titleField.text = d.title
            descriptionField.text = d.description
            //  dateField.text = d.disPlayDate.isEmpty ? TimeDateUtils.getShortDateInString(NSDate()): d.disPlayDate
        }
        
    }
    
    override func fetchDataFromUIElements() {
        if let d = data as? MyViewData {
            d.title = titleField.text ?? ""
            d.description = descriptionField.text ?? ""
            // d.disPlayDate = dateField.text ?? ""
        }
    }
    
    
    func setChartDataForEmotional(labels:[String],scores:[Double]){
        var dataEntries: [BarChartDataEntry] = []
        let colors = [UIColor(red: CGFloat(232.0/255), green: CGFloat(5.0/255), blue:CGFloat(33.0/255), alpha: 1),
            UIColor(red: CGFloat(89.0/255), green: CGFloat(38.0/255), blue: CGFloat(132.0/255), alpha: 1),
            UIColor(red: CGFloat(50.0/255), green: CGFloat(99.0/255), blue: CGFloat(43.0/255), alpha: 1),
            UIColor(red: CGFloat(255.0/255), green: CGFloat(214.0/255), blue: CGFloat(41.0/255), alpha: 1),
            UIColor(red: CGFloat(8.0/255), green: CGFloat(109.0/255), blue: CGFloat(178.0/255), alpha: 1)]
        
        for i in 0..<scores.count {
            let dataEntry = BarChartDataEntry(value: scores[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Sentiments")
        chartDataSet.barSpace = 0.1
        chartDataSet.colors = colors.reverse()
        chartDataSet.barShadowColor = Constants.grayColor_239
        chartDataSet.valueFormatter = NSNumberFormatter()
        chartDataSet.valueFormatter?.maximumFractionDigits = 0
        
        chartDataSet.drawValuesEnabled = false
        
        let chartData = BarChartData(xVals: labels, dataSet: chartDataSet)
        emotionBarChart.data = chartData
        emotionBarChart.animate(yAxisDuration: 2, easingOption: ChartEasingOption.Linear)

        
    }
    
    func setChartDataForLanguage(labels:[String],scores:[Double]){
        var dataEntries: [BarChartDataEntry] = []
        let colors = [UIColor(red: CGFloat(241.0/255), green: CGFloat(83.0/255), blue:CGFloat(2.0/255), alpha: 1)]
        
        for i in 0..<scores.count {
            let dataEntry = BarChartDataEntry(value: scores[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Sentiments")
        chartDataSet.barSpace = 0.65
        chartDataSet.colors = colors
        
        chartDataSet.valueFormatter = NSNumberFormatter()
        chartDataSet.valueFormatter?.maximumFractionDigits = 0
        chartDataSet.drawValuesEnabled = false
        chartDataSet.barShadowColor = Constants.grayColor_239

        let chartData = BarChartData(xVals: labels, dataSet: chartDataSet)
        laungauageBarChart.data = chartData
        laungauageBarChart.animate(yAxisDuration: 2.0, easingOption:.Linear)
    }
    
    func setChartDataForSocial(labels:[String],scores:[Double]){
        var dataEntries: [BarChartDataEntry] = []
        let colors = [UIColor(red: CGFloat(241.0/255), green: CGFloat(83.0/255), blue:CGFloat(2.0/255), alpha: 1)]
        
        for i in 0..<scores.count {
            let dataEntry = BarChartDataEntry(value: scores[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Sentiments")
        chartDataSet.barSpace = 0.1
        chartDataSet.colors = colors
        
        chartDataSet.valueFormatter = NSNumberFormatter()
        chartDataSet.valueFormatter?.maximumFractionDigits = 0
        chartDataSet.drawValuesEnabled = false
        chartDataSet.barShadowColor = Constants.grayColor_239
        

        let chartData = BarChartData(xVals: labels, dataSet: chartDataSet)
        socailHorBarChart.data = chartData
        socailHorBarChart.animate(yAxisDuration: 2, easingOption: ChartEasingOption.Linear)
    }
    
    //MARK: Actions
    
    //    @IBAction func dateFieldEditingBegin(sender: UITextField) {
    //        let datePicker = MyUtils.getDatePicker(self, selector: Selector("datePickerValueChanged:"))
    //        datePicker.setDate(NSDate(), animated: false)
    //        sender.inputView = datePicker
    //
    //    }
    //
    //    func datePickerValueChanged(sender:UIDatePicker) {
    //
    //        let dateFormatter = NSDateFormatter()
    //        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
    //
    //        dateField.text = dateFormatter.stringFromDate(sender.date)
    //
    //    }
    
    
    @IBAction func onAnalyzeToneClick(sender: UIButton) {
        
        if descriptionField.text.characters.count > 20 {
            progressHUD.text = MyStrings.analysingTone
            progressHUD.show()
            
            WatsonApiHelper.i.doToneAnalysisOf(descriptionField.text, completion: {[weak self] (result) -> Void in
                self?.progressHUD.hide()
                
                switch (result) {
                case .Success(let data):
                    if let d = data{
                        print(d)
                        
                        let jsonData = JSON(d)
                        
                        if  let jsonKeywords = jsonData["tone_categories"].array {
                            
                            
                            
                            
                            for i in jsonKeywords{
                                var labels = [String]()
                                var scores = [Double]()
                                
                                if let tones = i["tones"].array {
                                    
                                    for t in tones {
                                        log.info(" text is \(t["score"].double) and relevance is \(t["score"].doubleValue)")
                                        labels.append(t["tone_name"].string ?? "")
                                        scores.append(t["score"].doubleValue)
                                    }
                                    
                                    self?.updateItems(i["category_id"].stringValue, labels: labels, scores: scores)
                                }
                                
                            }
                        }
                        // self?.tags.text = (self?.tags.text!)! + d
                    }
                    break
                default:
                    break;
                }
                })
        }
        
    }
    
    func updateItems(category :String,  labels:[String],scores:[Double]){
        switch (category) {
        case "emotion_tone":
            setChartDataForEmotional(labels.reverse(), scores: scores.reverse())
            break;
        case "writing_tone":
            setChartDataForLanguage(labels, scores: scores)
            break;
        case "social_tone":
            setChartDataForSocial(labels.reverse(), scores: scores.reverse())
            break
        default:
            break;
        }
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func onRewriteClick(sender: AnyObject) {
    
        UIAlertUtils.createOkWithCancelAlertFor(self, with: MyStrings.clearDescrption) {[weak self] (action) -> Void in
            self?.descriptionField.text = ""
            self?.resetDataInTables()
        }
    }
    
    
}


class EmotionChartNumberFormatter : NSNumberFormatter {
    
    override func stringFromNumber(number: NSNumber) -> String? {
        print("number is \(number).......float is \(number.doubleValue)")
        let n = number.doubleValue * 100
        switch (n) {
        case 75...200:
            return "High                      \n "
        case 25...74:
            return "Medium        "
        default:
            return "Low"
        }
    }
}
