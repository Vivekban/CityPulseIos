//
//  TopBarView.swift
//  MyVoice
//
//  Created by PB014 on 02/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

protocol TopBarViewDelegate : class{
    func onBackButtonClick()
    func onHelpButtonClick()
    func onCategoryChanged(text:String, item index:Int)
}

class TopBarView: UIView {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var cityField: FloatLabelTextField!
    @IBOutlet weak var cityLine: UIView!
    @IBOutlet weak var categoryField: UITextField!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var delegate : TopBarViewDelegate?
    weak var controller :UIViewController?
    
    var categoryPopPicker:PopTable!
    
    var isCatergoryActive = false

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    

    @IBAction func onHelpButtonClick(sender: UIButton) {
        delegate?.onHelpButtonClick()
    }
    @IBAction func onBackButtonClick(sender: UIButton) {
        delegate?.onBackButtonClick()
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryField.hidden = true
        cityField.titleFont = UIFont.systemFontOfSize(13.0)
        changeVisibiltOfBackButton(true)
       
        var searchField: UITextField?
        for  subview in self.searchBar.subviews {
            if (subview.isKindOfClass(UITextField.self)) {
                searchField = subview as? UITextField
                break;
            }
        }
        
        var info = PopInfo(items: [[String]](),heading: MyStrings.categories)
        info.items?.append(CurrentSession.i.issueController.issueCategorises)
        
        categoryPopPicker = PopTable(forTextField: categoryField, data: info)
        categoryField.delegate = self
        
        // The icon is accessible through the 'leftView' property of the UITextField.
        // We set it to the 'rightView' instead.
        if (searchField != nil)
        {
            let searchIcon = searchField!.leftView;
            searchField!.rightView = searchIcon;
            searchField!.leftViewMode = UITextFieldViewMode.Never;
            searchField!.rightViewMode = UITextFieldViewMode.Always;
        }
    }
    
    func changeVisibiltOfBackButton(visible:Bool){

        backButton.hidden = visible
        titleLabel.hidden = visible

        cityLine.hidden = !visible
        cityField.hidden = !visible
        
        if isCatergoryActive {
        categoryField.hidden = !visible

        }
        }
    
    func changeVisibiltOfCity(visible:Bool){
        changeVisibiltOfBackButton(!visible)
    }
    
    func updateCategories(){
        categoryPopPicker.updateData(0, newData:CurrentSession.i.issueController.issueCategorises)
    }
}


// MARK: - UITextfieldDelegate

extension TopBarView :UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        controller?.view.endEditing(true)
        categoryPopPicker.updateData(0, newData: CurrentSession.i.appDataController.appData.categories)
        categoryPopPicker.pick(controller!, initData: [categoryField.text ?? ""]) { (newSelection, forTextField) -> () in
            if newSelection.count > 0 {
                let val = newSelection[0]
                forTextField.text = val
                self.delegate?.onCategoryChanged(newSelection[0], item: self.categoryPopPicker.popVC.info?.items?[0].indexOf(val) ?? 0)
            }
        }
        return false
    }
    
}
