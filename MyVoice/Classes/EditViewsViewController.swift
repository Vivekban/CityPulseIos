//
//  EditViewsViewController.swift
//  MyVoice
//
//  Created by PB014 on 30/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit

class EditViewsViewController: BaseEditViewController {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var descriptionField: DescriptionView!
    @IBOutlet weak var gradientView: GradientView!
      
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTitle = "View".localized
        super.viewDidLoad()
        popDatePickerTextFields.append(PopDatePickerParam(field: dateField, mode: .Date))
        addItemUrl = ServerUrls.addViewUrl
        updateItemUrl = ServerUrls.updateViewUrl
        dateField.hidden = true
        // shadowObject.append(descriptionField)
        // Do any additional setup after loading the view.
        gradientView.layerGradient()
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
            dateField.text = d.disPlayDate.isEmpty ? TimeDateUtils.getShortDateInString(NSDate()): d.disPlayDate
        }
        
    }
    
    override func fetchDataFromUIElements() {
        if let d = data as? MyViewData {
            d.title = titleField.text ?? ""
            d.description = descriptionField.text ?? ""
            d.disPlayDate = dateField.text ?? ""
        }
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
                progressHUD.text = MyStrings.fetchingTag
                progressHUD.show()
                
                WatsonApiHelper.i.doToneAnalysisOf(descriptionField.text, completion: {[weak self] (result) -> Void in
                    self?.progressHUD.hide()
                    
                    switch (result) {
                    case .Success(let data):
                        if let d = data as? String {
                            // self?.tags.text = (self?.tags.text!)! + d
                        }
                        break
                    default:
                        break;
                    }
                })
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
    
}
