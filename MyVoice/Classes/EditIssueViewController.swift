//
//  EditIssueViewController.swift
//  MyVoice
//
//  Created by PB014 on 21/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

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
        var info = PopInfo()
        info.items = [[String]]()
        info.items?.append([String]())
        info.heading = MyStrings.categories
        // removing all option
        var enty = CurrentSession.i.appDataManager.appData.categories
        if enty.count > 0 {
            enty.removeFirst()
        }
        info.items![0].appendContentsOf(enty)
        
        addTextFieldForPickerPopOver(category, info: info)
        
        //
        var info2 = PopInfo()
        info2.items = [[String]]()
        info2.items?.append([String]())
        info2.items![0].appendContentsOf(BaseFilter.getFilterValues(CurrentSession.i.appDataManager.appData.markTo))
        info2.heading = MyStrings.mark_to

        addTextFieldForPickerPopOver(markTo, info: info2)
        
        collection = collectionView
        
        addItemUrl = ServerUrls.addIssueUrl
        updateItemUrl = ServerUrls.updateIssueUrl
        // Do any additional setup after loading the view.
        
        fieldHideByKeyboard.append(tags)
        
        tags.delegate = self
        
        descriptionField.textView.delegate = self
        
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
            markTo.text =  ""
            if d.markTo > -1 {
                //TODO: fetch name from server
            }
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
            d.markTo = BaseFilter.getFilterOfString(markTo.text ?? "", filters: CurrentSession.i.appDataManager.appData.markTo)?.index ?? 0
            d.isCritical = criticalSwitch.on
        }
    }
    
    func onIssueTypeSet(){
        
        switch (issueType) {
        case .Community:
            mainTitle =  MyStrings.post
            break;
        case .HOA:
            mainTitle =  MyStrings.post
            break
        default:
            break;
        }

    }
    
    func fetchTagsFromServer(){
        
        if descriptionField.text.characters.count > 20 {
            progressHUD.text = MyStrings.fetchingTag
            progressHUD.show()
            
            WatsonApiHelper.i.fetchTagsFromServer(descriptionField.text, completion: {[weak self] (result) -> Void in
                self?.progressHUD.hide()
                
                switch (result) {
                case .Success(let data):
                    if let d = data as? String {
                self?.tags.text = (self?.tags.text!)! + d
                    }
                    break
                default:
                    break;
                }
            })
        }
    }
    
    override func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField == tags && !isTagsFetched{
            fetchTagsFromServer()
        }
        else if (textField == markTo ){
            
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
