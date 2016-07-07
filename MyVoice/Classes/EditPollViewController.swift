//
//  EditPollViewController.swift
//  MyVoice
//
//  Created by PB014 on 09/03/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class EditPollViewController: BaseImageEditViewController {
    
    @IBOutlet weak var pollQuestion: FloatLabelTextField!
    @IBOutlet weak var category: FloatLabelTextField!
    @IBOutlet weak var isCritical: UISwitch!
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        mainTitle = MyStrings.poll
        super.viewDidLoad()
        
        self.collection = collectionView
        
        addItemUrl = ServerUrls.addPollUrl
        updateItemUrl = ServerUrls.updatePollUrl
        

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

        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func getDataForNewItem() -> BaseData {
        return PollData()
    }
    
    override func initialiseViews() {
        super.initialiseViews()
        if let d = data as? PollData {
            pollQuestion.text = d.title
            isCritical.on = d.isCritical
            category.text = d.category
            
        }
    }
    
    override func fetchDataFromUIElements() {
        if let d = data as? PollData {
            d.title = pollQuestion.text ?? ""
            d.isCritical = isCritical.on
            d.category = category.text ?? ""
            
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
