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

    var searchBar: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var cityField: FloatLabelTextField!
    @IBOutlet weak var cityLine: UIView!
    @IBOutlet weak var categoryField: UIButton!
    @IBOutlet weak var searchCrossButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var delegate : TopBarViewDelegate?
    weak var controller :UIViewController?
    
    var categoryPopPicker:PopTable!
    
    var isCatergoryActive = false
    
    private var isSearchBarVisible = false
    private var isSearchAnimating = false
    
    private var searchBarLine : UIView!

    // private var testFiled : UITextField!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBAction func onCategoryButtonClick(sender: UIButton) {
        categoryPopPicker.updateData(0, newData: CurrentSession.i.appDataManager.appData.categories)
        categoryPopPicker.pick(controller!, initData: [categoryField.titleLabel?.text ?? ""]) { (newSelection, forTextField) -> () in
            if newSelection.count > 0 {
                let val = newSelection[0]
                UIView.performWithoutAnimation({ () -> Void in
                    (forTextField as? UIButton)?.setTitle(val, forState: UIControlState.Normal)
                    forTextField.layoutIfNeeded()

                })
                self.delegate?.onCategoryChanged(newSelection[0], item: self.categoryPopPicker.popVC.info?.items?[0].indexOf(val) ?? 0)
            }
        }

    }

    @IBAction func onHelpButtonClick(sender: UIButton) {
        delegate?.onHelpButtonClick()
    }
    @IBAction func onBackButtonClick(sender: UIButton) {
        delegate?.onBackButtonClick()
    }
   
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryField.hidden = true
        categoryField.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)

        cityField.titleFont = UIFont.systemFontOfSize(13.0)
        changeVisibiltOfBackButton(true)
       
        var searchField: UITextField?
//        for  subview in self.searchBar.subviews {
//            if (subview.isKindOfClass(UITextField.self)) {
//                searchField = subview as? UITextField
//                break;
//            }
//        }
        
        var info = PopInfo(items: [[String]](),heading: MyStrings.categories)
        info.items?.append(CurrentSession.i.issueController.issueCategorises)
        
        categoryPopPicker = PopTable(forTextField: categoryField, data: info)
        
        // The icon is accessible through the 'leftView' property of the UITextField.
        // We set it to the 'rightView' instead.
        if (searchField != nil)
        {
            let searchIcon = searchField!.leftView;
            searchField!.rightView = searchIcon;
            searchField!.leftViewMode = UITextFieldViewMode.Never;
            searchField!.rightViewMode = UITextFieldViewMode.Always;
        }
        
    
        searchBar = UITextField(frame: CGRect(x: 0, y: 6, width: 200, height: 30))
        searchBar.returnKeyType = UIReturnKeyType.Search
        //searchBar.translatesAutoresizingMaskIntoConstraints = false

        searchBar.textColor = Constants.grayColor_101
        searchBar.font = UIFont.systemFontOfSize(15)
        searchBar.sizeToFit()
        searchBar.placeholder = "Search"
        
        searchBarLine = UIView(frame: CGRect(x: 0, y: 31, width: 200, height: 1))
        searchBarLine.backgroundColor = Constants.grayColor_239
        
        addSubview(searchBarLine)
        
        addSubview(searchBar)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        searchBar.frame = CGRect(x: searchCrossButton.frame.origin.x - 4, y: (frame.height - searchBar.frame.height)/2, width: 0, height: searchBar.frame.height)

    }
    
//    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
//        print(bounds)
//        print(frame)
//        return super.hitTest(point, withEvent: event)
//        
//    }
    
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
    
    @IBAction func onSEarchCrossButtonClick(sender: UIButton) {
        if !isSearchAnimating {
            isSearchAnimating = true
            isSearchBarVisible = !isSearchBarVisible
            
            if isSearchBarVisible {
                searchBar.becomeFirstResponder()
                searchBar.text = ""
                
                sender.setBackgroundImage(UIImage(named: "cross_blue"), forState: UIControlState.Normal)
                
                var frame = searchBar.frame
                frame.size.width = 200
                frame.origin.x = self.searchCrossButton.frame.origin.x - 4 - 200
                
                var frame2 = searchBarLine.frame
                frame2.size.width = 200
                frame2.origin.x = self.searchCrossButton.frame.origin.x - 4 - 200

                
                self.searchBar.hidden = false
                searchBarLine.hidden = true

                //searchBar.transform = CGAffineTransformMakeScale(0.1,1);

                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.searchBar.frame = frame
                    self.searchBarLine.frame = frame2
                    // self.searchBar.transform = CGAffineTransformMakeScale(1,1)

                    // self.testFiled.frame.size.width = 300
                    //  self.layoutIfNeeded()
                    },completion: { (complete) -> Void in
                        self.isSearchAnimating = false
                        self.searchBarLine.hidden = false
                })
                

                UIView.animateWithDuration(0.7, animations: { () -> Void in
                    self.searchBar.alpha = 1

                    })
                
            }
            else {
                endEditing(true)
                sender.setBackgroundImage(UIImage(named: "search"), forState: UIControlState.Normal)
                
                var frame = searchBar.frame
                //frame.size.width = 1
                frame.origin.x = self.searchCrossButton.frame.origin.x - 4
//                
//                var frame2 = searchBarLine.frame
//                //frame.size.width = 1
//                frame2.origin.x = self.searchCrossButton.frame.origin.x - 4

                
                searchBarLine.hidden = true
                //self.searchBar.transform = CGAffineTransformMakeScale(1,1)
                
                UIView.animateWithDuration(1, animations: { () -> Void in
                    // self.layoutIfNeeded()
                    self.searchBar.frame = frame
                    self.searchBar.alpha = 0
                    //self.searchBar.transform = CGAffineTransformMakeScale(0.1,1);

                    },completion: { (complete) -> Void in
                        self.searchBar.hidden = true
                        self.isSearchAnimating = false
                        
                })
                
                
            }
            
        }
    }
    
    
}


// MARK: - UITextfieldDelegate

extension TopBarView :UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        controller?.view.endEditing(true)
              return false
    }
    
}
