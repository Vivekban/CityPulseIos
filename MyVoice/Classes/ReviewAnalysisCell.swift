//
//  ReviewAnalysisView.swift
//  MyVoice
//
//  Created by PB014 on 04/03/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit



class ReviewAnalysisCell: BaseAnalyticsCell {
    var filterTextView : UITextField!
    var filterPopOver : PopTable!
    var filterItems : [String]!
    var currentFilter :Int = 0
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
        
        filterTextView = UITextField(frame: CGRect(x: (view.frame.width) - 200 - 20, y: 14, width: 200, height:30))
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
        
        // filterTextView.sizeToFit()
        
        
        view.addSubview(filterTextView)
        
        
        
        var info = [[String]]()
        info.append(filterItems)
        
        filterPopOver = PopTable(forTextField: filterTextView, data: PopInfo(items: info,heading: MyStrings.filters))
        
    }
    
    func onFilterSelected(index: Int){
        currentFilter = index
        ((tabsView.controllerArray[tabsView.currentPageIndex]) as! ReviewAnalysisController).onSomeActionTaken(index)
    }
    
    override func willMoveToPage(controller: UIViewController, index: Int) {
        ((controller) as! ReviewAnalysisController).onSomeActionTaken(currentFilter)
    }

}

extension ReviewAnalysisCell : UITextFieldDelegate {
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if let c = UIApplication.topViewController() {
            
            filterPopOver.pick(c, initData: [textField.text ?? ""]) {[weak self] (newSelection, forTextField) -> () in
                if newSelection.count > 0 {
                    (forTextField as! UITextField).text = newSelection[0]
                    // self?.filterTextView.sizeToFit()
                    self?.onFilterSelected(self?.filterItems.indexOf(newSelection[0]) ?? 0)
                }
            }
            
            return false
        }
        return true
    }
}

