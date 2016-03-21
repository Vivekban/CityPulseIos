//
//  HomeBaseNestedTabController.swift
//  MyVoice
//
//  Created by PB014 on 11/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class HomeBaseNestedTabController: BaseNestedTabViewController {
    
    var currentCategory:String = "-1"
    var currentCategoryIndex:Int = 0
    var tab = 0

    var currentFilter : HomeFilter? {
        didSet{
            onFilterChange()
        }
    }
    
    override func viewDidLoad() {
        serverDataManager = CurrentSession.i.issueController
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }



    
    override func viewWillAppear(animated: Bool) {
        entries = getAllEntries()
        super.viewWillAppear(animated)
        
    }
    
    
    override func getParameterForListFetching(type: Int) -> [String : AnyObject] {
        var params = super.getParameterForListFetching(type)
        params["index"] = currentFilter?.index ?? 0
        params["tab"] = tab
        return params
    }
    
     func getAllEntries() -> [BaseData] {
        return CurrentSession.i.issueController.homeDataLists.getList(tab)[currentFilter?.index ?? 0].entries
    }
    

    
    
    func onCatergoryChange(text:String, item index:Int){
        if currentCategory != text {
            currentCategory = text
            currentCategoryIndex = index
            filterEntriesByCategory()
        }
    }
    
    func filterEntriesByCategory() {
        let allEntries = getAllEntries()
        entries.removeAll()
        
        if currentCategoryIndex != 0 {
            for i in allEntries {
                if let d = i as? IssueData {
                    if d.category == currentCategory {
                        entries.append(d)
                    }
                }
            }
            
        }
        else{
            entries.appendContentsOf(allEntries)
        }
        if collecView != nil {
            collecView!.reloadData()
        }
        
    }
    
    func onFilterChange() {
        if serverListRequestType != currentFilter?.dataRequestType ?? 0 {
            serverListRequestType = currentFilter?.dataRequestType ?? 0
            fetchListFromStart()
        }
    }
    
    override func updateListEntries(parameter: [String : AnyObject]) {
        let c = currentFilter?.index ?? 0
        
        if let index = parameter["index"] as?Int {
            if index == c {
                entries = getAllEntries()
                filterEntriesByCategory()
                updateEntries()
            }
        }
    }
    

}
