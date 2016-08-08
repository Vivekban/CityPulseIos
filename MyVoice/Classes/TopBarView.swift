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
    func onNotifiactionClick(index: Int)
    func onProfileButtonClick()
}

class TopBarView: UIView {
    
    var searchBar: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var cityField: FloatLabelTextField!
    @IBOutlet weak var cityLine: UIView!
    @IBOutlet weak var searchCrossButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var notification: UIButton!
    
    weak var delegate : TopBarViewDelegate?
    weak var controller :UIViewController?
    
    
    var isCatergoryActive = false
    
    private var isSearchBarVisible = false
    private var isSearchAnimating = false
    
    private var searchBarLine : UIView!
    
    var notificationPopPicker:PopTable!
    
    
    // private var testFiled : UITextField!
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
    
    
    @IBAction func onNotificationButtonClick(sender: UIButton) {
        
        
        
        notificationPopPicker.updateData(0, newData: CurrentSession.i.appDataManager.appData.categories)
        notificationPopPicker.pick(controller!, initData: [""]) { (newSelection, forTextField) -> () in
            
            if  newSelection != nil &&  newSelection!.count > 0 {
                let val = newSelection![0]
            self.delegate?.onNotifiactionClick(self.notificationPopPicker.popVC.info?.items?[0].indexOf(val) ?? 0)
                
            }
        }
        
        
        
    }
    @IBAction func onBackButtonClick(sender: UIButton) {
        delegate?.onBackButtonClick()
    }
    
    
    @IBAction func onProfileButtonClick(sender: AnyObject) {
        
        delegate?.onProfileButtonClick()
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        cityField.titleFont = UIFont.systemFontOfSize(14.0)
        cityField.title.textColor = UIColor.whiteColor()
        changeVisibiltOfBackButton(true)
        
//        let searchField: UITextField?
//        if (searchField != nil)
//        {
//            let searchIcon = searchField!.leftView;
//            searchField!.rightView = searchIcon;
//            searchField!.leftViewMode = UITextFieldViewMode.Never;
//            searchField!.rightViewMode = UITextFieldViewMode.Always;
//        }
        searchCrossButton.adjustsImageWhenHighlighted = false
        
        searchBar = UITextField(frame: CGRect(x: 0, y: 6, width: 200, height: 30))
        searchBar.returnKeyType = UIReturnKeyType.Search
        //searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.textColor = UIColor.whiteColor()
        searchBar.font = UIFont.systemFontOfSize(15)
        searchBar.sizeToFit()
        searchBar.placeholder = "Search"
        //searchBar.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSForegroundColorAttributeName : NSForegroundColorAttributeName])
        searchBar.attributedPlaceholder = NSAttributedString(string:"Search", attributes: [NSForegroundColorAttributeName: Constants.grayColor_242])

        searchBarLine = UIView(frame: CGRect(x: 0, y: 34, width: 200, height: 1))
        searchBarLine.backgroundColor = Constants.grayColor_242
        searchBarLine.hidden = true
        addSubview(searchBarLine)
        
        addSubview(searchBar)
        
        
        var data = PopInfo(items: [[String]](),heading: MyStrings.categories)
        data.items?.append(CurrentSession.i.issueController.issueCategorises)
        
        
        notificationPopPicker = PopTable(forTextField: notification, data: data)
        
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
            
        }
        profileButton.hidden = !visible
        
    }
    
    
    func changeVisibilityOfTitle(visible : Bool) {
        
        titleLabel.hidden = !visible
        cityLine.hidden = visible
        cityField.hidden = visible
        
    }
    
    func setTitle(title : String)  {
        titleLabel.text = title
        changeVisibilityOfTitle(true)
    }
    
    
    func changeVisibiltOfCity(visible:Bool){
        changeVisibiltOfBackButton(!visible)
    }
    
    func setHiddenStatusOfCity(isHidden :Bool){
        cityLine.hidden = isHidden
        cityField.hidden = isHidden
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
