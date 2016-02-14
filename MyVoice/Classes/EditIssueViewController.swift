//
//  EditIssueViewController.swift
//  MyVoice
//
//  Created by PB014 on 21/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit
import SwiftyJSON




class EditIssueViewController: BaseImageEditViewController {
    
    @IBOutlet weak var titleField: FloatLabelTextField!
    @IBOutlet weak var category: FloatLabelTextField!
    @IBOutlet weak var tags: FloatLabelTextField!
    @IBOutlet weak var markTo: FloatLabelTextField!
    @IBOutlet weak var criticalSwitch: UISwitch!
    @IBOutlet weak var descriptionField: DescriptionView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var isTagsFetched = false
    
    var issueType = IssueType.Community {
        didSet{
            onIssueTypeSet()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // category
        var info = PickerInfo()
        info.items = [[String]]()
        info.items?.append([String]())
        
        addTextFieldForPickerPopOver(category, info: info)
        
        //
        var info2 = PickerInfo()
        info2.items = [[String]]()
        info2.items?.append([String]())
        
        addTextFieldForPickerPopOver(markTo, info: info2)
        
        
        collection = collectionView
        
        addItemUrl = ServerUrls.addIssueUrl
        updateItemUrl = ServerUrls.updateIssueUrl
        // Do any additional setup after loading the view.
        
        fieldHideByKeyboard.append(tags)
        
        tags.delegate = self
        
        // hide cancel button
        
        if let v = view.viewWithTag(2) {
            v.hidden = true
        }
     }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func initialiseViews() {
        super.initialiseViews()
        if let d = data as? IssueData {
            titleField.text = d.title
            descriptionField.text = d.description
            category.text = d.category
            tags.text = d.tags
            //   d.location = location.text
            markTo.text = d.markTo
            criticalSwitch.setOn(d.isCritical, animated: false)
        }
        
    }
    
    override func getDataForNewItem() -> BaseData {
        return IssueData()
    }
    
    
    override func fetchDataFromUIElements() {
        if let d = data as? IssueData {
            
            log.info(titleField.text)
            
            d.title = titleField.text ?? ""
            d.description = descriptionField.text
            d.category = category.text ?? ""
            d.tags = tags.text ?? ""
            //   d.location = location.text
            d.markTo = markTo.text ?? ""
            d.isCritical = criticalSwitch.on
        }
        
    }
    
    func onIssueTypeSet(){
        
        switch (issueType) {
        case .Community:
            mainTitle =  MyStrings.community_issue
            break;
        case .HOA:
            mainTitle =  MyStrings.HOA_issue
            break
        default:
            break;
        }

    }
    
    func fetchTagsFromServer(){
        
        if descriptionField.text.characters.count > 10 {
            progressHUD.text = MyStrings.fetchingTag
            progressHUD.show()
            var parameter:[String:String] = [String:String]()
            
            parameter["apikey"] = ServerUrls.watsonApiKey
            parameter["text"] = descriptionField.text
            parameter["maxRetrieve"] = "10"
            parameter["keywordExtractMode"] = "normal"
            parameter["outputMode"] = "json"
            
            ServerRequestInitiater.i.postMessageToServer(ServerUrls.getKeywordsUrl, postData: parameter) { [weak self] (result) -> Void in
                //  print(result)
                if self == nil {
                    return
                }
                
                self?.progressHUD.hide()
                switch (result) {
                case .Success(let data):
                    if let d = data {
                        let jsonData = JSON(d)
                        if (jsonData["status"] == "OK"){
                            
                            log.info("\(jsonData["keywords"])")
                            
                            let jsonKeywords = jsonData["keywords"].array
                            
                            
                            var words = 0
                            var tagString = ""
                            
                            for i in jsonKeywords!{
                                
                                log.info(" text is \( i["text"]) and relevance is \(i["relevance"])")
                                
                                if words < 6 {
                                    tagString += "\(i["text"].string!), "
                                    words++
                                }
                                else{
                                    break;
                                }
                                
                            }
                            self?.tags.text = (self?.tags.text!)! + tagString
                        }
                        
                    }
                    break;
                    
                default:
                    break;
                }
                
            }
        }
    }
    
    override func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField == tags && !isTagsFetched{
            fetchTagsFromServer()
        }
        
        return super.textFieldShouldBeginEditing(textField)
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