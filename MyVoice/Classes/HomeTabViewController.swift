//
//  HomeTabViewController.swift
//  MyVoice
//
//  Created by PB014 on 29/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit
import CoreLocation

class HomeTabViewController: BaseTabViewController {
    
    let locationManager = CLLocationManager()

    
    var filterPopOver:PopPicker!
    var filterItems = [String]()
    var filterTextView : UITextField!
    var currentTab : Int {
        
        get{
            return tabsMenu?.currentPageIndex ?? 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func setTabsParameter() {
        menuItemWithAccordingToText = true
        actionButton.setTitle("New".localized, forState: .Normal)
        
        storyBoardName = "Home"
        // let tabs = CurrentSession.i.personUI?.nHomeTabs
        addTab("IssueViewController", title: "\(MyStrings.community_issues)   ")
        addTab("IssueViewController", title: "  \(MyStrings.HOA_issues)     ")
        addTab("IssueViewController", title: "   \(MyStrings.polls)          ")
        
        //        if tabs>3 {
        //            addTab("IssueViewController", title: NSLocalizedString("Subscribed", comment: "Subscribed"))
        //            addTab("IssueViewController", title: NSLocalizedString("Resolved", comment: "Resolved"))
        //        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        topBar?.controller = self
        
        //actionButton.frame
        
        filterTextView = UITextField(frame: CGRect(x: (actionButton.frame.origin.x) - 120 - 20, y: 14, width: 120, height:30))
        filterTextView.delegate = self
        filterTextView.text = "\(MyStrings.filters)"
        filterTextView.textAlignment = NSTextAlignment.Right
        filterTextView.textColor = Constants.accentColor
        
        
        filterTextView.rightViewMode = UITextFieldViewMode.Always
        let image = UIImageView(image: UIImage(named: "downarrow"))
        // image.contentMode = UIViewContentMode.Right
        image.image = image.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        image.frame = CGRect(x: 8, y: 0, width: 20, height: 20)
        image.tintColor = Constants.accentColor
        filterTextView.rightView = image
        
        filterTextView.sizeToFit()

        
        tabsMenu?.view.addSubview(filterTextView)
        
        
        
        var info = [[String]]()
        info.append(filterItems)
        filterPopOver = PopPicker(forTextField: filterTextView, data: PickerInfo(items: info))
        
        (tabsMenu?.controllerArray[1] as? IssueViewController)?.issueType = IssueType.HOA
        
        for (i,controller) in (tabsMenu?.controllerArray.enumerate())! {
            if let con = controller as? HomeBaseNestedTabController {
                con.currentFilter = CurrentSession.i.personUI?.homeFilters[i][0]
            }
        }
        // (tabsMenu?.controllerArray[1] as? BaseNestedTabViewController)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        EventUtils.addObserver(self, selector: Selector("onCategoryUpdated"), key: EventUtils.categoryUpdateKey)
        setupForLocation()

    }
    
    override func onCategoryChanged(text: String) {
        
    }
    
    func onCategoryUpdated(){
        topBar?.updateCategories()
    }
    
    
    override func onActionButtonClick(sender: UIButton) {
        (tabsMenu?.controllerArray[(tabsMenu?.currentPageIndex)!] as? BaseNestedTabViewController)?.onActionButtonClick(sender)
        
    }
    
    override func didMoveToPage(controller: UIViewController, index: Int) {
       
        // self.filterTextView.text = (tabsMenu?.controllerArray[index] as? HomeBaseNestedTabController)?.currentFilter?.value
        //filterTextView.sizeToFit()
        // currentTab = index
        
        
        
        //        switch index {
        //
        //        case 0:
        //            changeVisibilityOfActionButton(true)
        //            setTitleOfActionButton()
        //            break
        //
        //        case 1:
        //            changeVisibilityOfActionButton(true)
        //            setTitleOfActionButton("Add_Work".localized)
        //            break
        //        case 2:
        //            changeVisibilityOfActionButton(true)
        //            setTitleOfActionButton("ADD_EVENT".localized)
        //            break
        //        default:
        //            assertionFailure("pata ni")
        //        }
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

// MARK: - UITextFieldDelegate

extension HomeTabViewController : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if (textField == filterTextView) {
             let filters = CurrentSession.i.personUI?.homeFilters[currentTab]
            
            
            
            filterPopOver.updateData(0, newData: BaseFilter.getFilterValues(filters!))
        
            if let controller = (tabsMenu?.controllerArray[(tabsMenu?.currentPageIndex)!] as? HomeBaseNestedTabController) {
            
                
                
            filterPopOver.pick(self, initData: [controller.currentFilter!.value], dataChanged: { [weak self] (newSelection, forTextField) -> () in
                if self == nil {
                    return
                }
                
                if newSelection.count > 0 {
                    let value = newSelection[0]
                    // self?.filterTextView.text = value
                    // self?.filterTextView.sizeToFit()

                    controller.currentFilter = BaseFilter.getFilterOfString(value, filters:filters!) as? HomeFilter
                    
                }
                
                })
            
            return false
            }
        }
        
        return true
    }
    
    
    
    func setupForLocation(){
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        //  Crashlytics.sharedInstance().crash()
        
    }
    

    
}


extension HomeTabViewController : CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        
        CurrentSession.i.userLocation = locations[0]
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(locations[0]) { [weak self](placemarks, error) -> Void in
            
            if (error != nil || placemarks == nil||placemarks?.count == 0) {
                // log.error("reverse geodcode fail: \(error!.localizedDescription)")
                return
            }
//            for place in placemarks! {
//                if let p = place as? CLPlacemark {
//                    log.info(" \(p.locality!)  \( p.administrativeArea!)")
//                    
//                }
//            }
            CurrentSession.i.userPlacemark = placemarks?[0]
            EventUtils.postNotification(EventUtils.locationUpdateKey)
            // self?.locationManager.stopUpdatingLocation()
            //self?.locationManager.startMonitoringSignificantLocationChanges()
        }
        // let long = locations[0].coordinate.longitude;
        // let lat = locations[0].coordinate.latitude;
        
        //Do What ever you want with it
    }
    
    
}