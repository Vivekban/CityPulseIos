//
//  HomeTabViewController.swift
//  MyVoice
//
//  Created by PB014 on 29/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit
import CoreLocation

class HomeTabViewController: BaseTabsViewController {
    
    let locationManager = CLLocationManager()
    
    
    var filterPopOver:PopTable!
    var filterItems = [String]()
    var filterTextView : UIButton!
    var currentTab : Int {
        
        get{
            return tabsMenu?.currentPageIndex ?? 0
        }
    }
    
    var categoryField: UIButton!
    var categoryPopPicker:PopTable!
    
    
    var testingLocationView:LocationView?
    
    
    
    override func viewDidLoad() {
        isBriefBar = false
        super.viewDidLoad()
        filterTextView = UIButton(type: UIButtonType.System)
        filterTextView.setTitleColor(Constants.accentColor, forState: UIControlState.Normal)
        
        filterTextView.titleLabel?.font = UIFont.systemFontOfSize(16)
        filterTextView.frame = CGRect(x: (actionButton.frame.origin.x) - 300 - 20, y: 10, width: 120, height:30)
        
        filterTextView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        filterTextView.titleLabel?.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        filterTextView.imageView?.transform = CGAffineTransformMakeScale(-1, 1);
        // filterTextView.delegate = self
        filterTextView.setTitle(MyStrings.filters, forState: UIControlState.Normal)
        
        //filterTextView.textAlignment = NSTextAlignment.Right
        //filterTextView.textColor = Constants.accentColor
        
        filterTextView.addTarget(self, action: #selector(HomeTabViewController.onFilterButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
        filterTextView.setImage(UIImage(named: "downarrow"), forState: UIControlState.Normal)
        filterTextView.sizeToFit()
        
        
        tabsMenu?.view.addSubview(filterTextView)
        
        var info = [[String]]()
        info.append(filterItems)
        filterPopOver = PopTable(forTextField: filterTextView, data: PopInfo(items: info,heading: MyStrings.filters))
        
        
        testingLocationView = NSBundle.mainBundle().loadNibNamed("MapLocations", owner: LocationView.self, options: nil)[0] as? LocationView
        testingLocationView?.frame = CGRectMake(20, 60, view.frame.width - 40, view.frame.height - 80)
        // view.addSubview(testingLocationView!)
        
        
        //UINib(nibName: "TopBar", bundle: nil).instantiateWithOwner(TopBarView.self, options: nil)[0] as? TopBarView
        
        
        
        // Do any additional setup after loading the view.
        categoryField = UIButton(type: UIButtonType.System)
        categoryField.setTitleColor(Constants.accentColor, forState: UIControlState.Normal)
        
        categoryField.titleLabel?.font = UIFont.systemFontOfSize(16)
        categoryField.frame = CGRect(x: (actionButton.frame.origin.x) - 150 - 20, y: 10, width: 120, height:30)
        
        categoryField.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        categoryField.titleLabel?.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        categoryField.imageView?.transform = CGAffineTransformMakeScale(-1, 1);
        // filterTextView.delegate = self
        categoryField.setTitle(MyStrings.categories, forState: UIControlState.Normal)
        
        //categoryField.titleLabel?.textAlignment = NSTextAlignment.Right
        //filterTextView.textColor = Constants.accentColor
        
        categoryField.addTarget(self, action: #selector(HomeTabViewController.onCategoryButtonClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        //filterTextView.rightViewMode = UITextFieldViewMode.Always
        let image2 = UIImageView(image: UIImage(named: "downarrow"))
        // image.contentMode = UIViewContentMode.Right
        image2.image = image2.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        image2.frame = CGRect(x: 8, y: 0, width: 10, height: 10)
        image2.tintColor = Constants.accentColor
        categoryField.setImage(image2.image, forState: UIControlState.Normal)
        categoryField.sizeToFit()
        
        categoryField.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        tabsMenu?.view.addSubview(categoryField)
        
        updatePostionOfFilters()
        
        var data = PopInfo(items: [[String]](),heading: MyStrings.categories)
        data.items?.append(CurrentSession.i.issueController.issueCategorises)
        
        
        categoryPopPicker = PopTable(forTextField: categoryField, data: data)
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updatePostionOfFilters() {
        
        var frame = categoryField.frame;
        frame.origin.x = (actionButton.frame.origin.x) - 20 - frame.size.width
        categoryField.frame = frame
        
        var frame2 = filterTextView.frame
        frame2.origin.x = frame.origin.x - 20 - frame2.size.width
        
        filterTextView.frame = frame2
        
        categoryField.layoutIfNeeded()
        filterTextView.layoutIfNeeded()
        
        
    }
    
    
    
    override func getTabsController() -> [UIViewController] {
        
        menuItemWithAccordingToText = true
        actionButton.setTitle("New".localized, forState: .Normal)
        
        storyBoardName = "Home"
        
        
        var controllers = [UIViewController]()
        // Do any additional setup after loading the view.
        let firstStoryboard:UIStoryboard = UIStoryboard(name: storyBoardName, bundle: nil)
        
        let controller : UIViewController = firstStoryboard.instantiateViewControllerWithIdentifier("IssueViewController")
        controller.title = MyStrings.posts
        controllers.append(controller)
        
        let controller2 : UIViewController = firstStoryboard.instantiateViewControllerWithIdentifier("PollsViewController")
        controller2.title = MyStrings.polls
        controllers.append(controller2)
        
        
        let controller3 : UIViewController = UIStoryboard(name: "Me", bundle: nil).instantiateViewControllerWithIdentifier("EventViewController")
        controller3.title = MyStrings.events
        controllers.append(controller3)
        
        
        //                let controller4 : UIViewController = firstStoryboard.instantiateViewControllerWithIdentifier("EventViewController")
        let controller4 : UIViewController = UIStoryboard(name: "Me", bundle: nil).instantiateViewControllerWithIdentifier("EventViewController")
        
        controller4.title = MyStrings.ugrentAlerts
        controllers.append(controller4)
        
        
        
        //actionButton.frame
        for (i,controller) in (controllers.enumerate()) {
            if let con = controller as? HomeBaseNestedTabController {
                con.currentFilter = CurrentSession.i.personUI?.homeFilters[i][0]
            }
        }
        
        
        
        return controllers
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        topBar?.isCatergoryActive = true
        topBar?.changeVisibiltOfCity(false)
        // (tabsMenu?.controllerArray[1] as? BaseNestedTabViewController)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        EventUtils.addObserver(self, selector: #selector(HomeTabViewController.onCategoryUpdated), key: EventUtils.categoryUpdateKey)
        setupForLocation()
        
    }
    
    
    func onCategoryButtonClick(sender: UIButton) {
        sender.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        
        categoryPopPicker.updateData(0, newData: CurrentSession.i.appDataManager.appData.categories)
        categoryPopPicker.pick(self, initData: [categoryField.titleLabel?.text ?? ""]) { (newSelection, forTextField) -> () in
            sender.setTitleColor(Constants.accentColor, forState: UIControlState.Normal)

            if let selection = newSelection {
                
                if selection.count > 0 {
                    
                    let val = selection[0]
                    UIView.performWithoutAnimation({ () -> Void in
                        (forTextField as? UIButton)?.setTitle(val, forState: UIControlState.Normal)
                        forTextField.layoutIfNeeded()
                        
                    })
                    self.onCategoryChanged(selection[0], item: self.categoryPopPicker.popVC.info?.items?[0].indexOf(val) ?? 0)
                    
                }
            }
        }
        
    }
    
    
    func updateCategories(){
        categoryPopPicker.updateData(0, newData:CurrentSession.i.issueController.issueCategorises)
    }
    
    func onCategoryChanged(text:String, item index:Int) {
        (tabsMenu?.controllerArray[(tabsMenu?.currentPageIndex) ?? 0] as? HomeBaseNestedTabController)?.onCatergoryChange(text,item: index)
        categoryField.sizeToFit()
        updatePostionOfFilters()
        
    }
    
    func onCategoryUpdated(){
        updateCategories()
    }
    
    
    override func onActionButtonClick(sender: UIButton) {
        // sender.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        
        (tabsMenu?.controllerArray[(tabsMenu?.currentPageIndex) ?? 0] as? BaseNestedTabViewController)?.onActionButtonClick(sender)
        
    }
    
    override func didMoveToPage(controller: UIViewController, index: Int) {
        
        
        
        
        super.didMoveToPage(controller, index: index)
        
        // currentTab = index
        
        
        
        switch index {
            
        case 0:
            changeVisibilityOfActionButton(true)
            setTitleOfActionButton(MyStrings.newPost)
            filterTextView.hidden = false
            categoryField.hidden = false
            
            break
            
        case 1:
            changeVisibilityOfActionButton(true)
            setTitleOfActionButton(MyStrings.newPoll)
            filterTextView.hidden = true
            categoryField.hidden = false
            
            break
        case 2:
            changeVisibilityOfActionButton(true)
                        setTitleOfActionButton(MyStrings.newEvent)
            filterTextView.hidden = true
            categoryField.hidden = true
            break
        case 3:
            changeVisibilityOfActionButton(false)
            filterTextView.hidden = true
            categoryField.hidden = true
        default:
            assertionFailure("pata ni")
        }
        
        
        self.filterTextView.setTitleWithoutAnimation(((tabsMenu?.controllerArray[index] as? HomeBaseNestedTabController)?.currentFilter?.value) ?? "",forState: UIControlState.Normal)
        
        filterTextView.sizeToFit()
        categoryField.sizeToFit()
        updatePostionOfFilters()
        
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func onFilterButtonClick(){
        let filters = CurrentSession.i.personUI?.homeFilters[currentTab]
        filterTextView.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        
        if let controller = (tabsMenu?.controllerArray[(tabsMenu?.currentPageIndex)!] as? HomeBaseNestedTabController) {
            filterPopOver.updateHeading(controller.title!)
            filterPopOver.updateData(0, newData: BaseFilter.getFilterValues(filters!))
            
            
            
            filterPopOver.pick(self, initData: [controller.currentFilter!.value], dataChanged: { [weak self] (newSelection, forTextField) -> () in
                if self == nil {
                    return
                }
                self?.filterTextView.setTitleColor(Constants.accentColor, forState: UIControlState.Normal)
                
                if let selection = newSelection {
                    
                    if selection.count > 0 {
                        let value = selection[0]
                        self?.filterTextView.setTitleWithoutAnimation(value, forState: UIControlState.Normal)
                        self?.filterTextView.sizeToFit()
                        self?.updatePostionOfFilters()
                        controller.currentFilter = BaseFilter.getFilterOfString(value, filters:filters!) as? HomeFilter
                        
                    }
                }
                
                })
        }
    }
    
}




// MARK: - UITextFieldDelegate

extension HomeTabViewController : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        
        return true
    }
    
    
    
    func setupForLocation(){
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        //  Crashlytics.sharedInstance().crash()
        
    }
    
}


extension HomeTabViewController : CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        
        CurrentSession.i.userLocation = locations[0]
        
        //gm fetchNeighBourLocation(locations[0])
        
        
        //        let geocoder = CLGeocoder()
        //        geocoder.reverseGeocodeLocation(locations[0]) { [weak self](placemarks, error) -> Void in
        //            if (error != nil || placemarks == nil||placemarks?.count == 0) {
        //                // log.error("reverse geodcode fail: \(error!.localizedDescription)")
        //                return
        //            }
        //
        //            let place = MyPlacemark()
        //            place.initWithPlacemark(placemarks![0])
        //            self?.testingLocationView?.updateMainLocation(place)
        //
        //            for place in placemarks! {
        //                if let p = place as? CLPlacemark {
        //                    print(" \(placemarks?.count)  \(p.locality!) --- \(p.subLocality)--- \( p.administrativeArea!) -------- \(p.subAdministrativeArea)...\(p.thoroughfare)")
        //
        //                }
        //            }
        //            CurrentSession.i.userPlacemark = placemarks?[0]
        //            EventUtils.postNotification(EventUtils.locationUpdateKey)
        //            // self?.locationManager.stopUpdatingLocation()
        //            //self?.locationManager.startMonitoringSignificantLocationChanges()
        //        }
        
        
        
        
        dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            // Add code here to do background processing
            //
            //
            
            let url = NSURL(string: "\(ServerUrls.googleMapUrl)latlng=\(locations[0].coordinate.latitude),\(locations[0].coordinate.longitude)&key=\(ServerUrls.apikey)")
            let data = NSData(contentsOfURL: url!)
            let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            
            
            
            
            let place = MyPlacemark()
            
            if let result = json["results"] as? NSArray {
                
                if result.count < 1 {
                    return
                }
                
                if let address = result[0]["address_components"] as? NSArray {
                    
                    place.subThoroughfare = address[0]["short_name"] as? String
                    place.thoroughfare = address[1]["short_name"] as? String
                    place.subLocality = address[2]["short_name"] as? String
                    place.locality = address[3]["short_name"] as? String
                    place.subAdministrativeArea = address[4]["short_name"] as? String
                    
                    if (address.count > 5){
                        place.administrativeArea = address[5]["short_name"] as? String
                    }
                    if (address.count > 7){
                        place.pincode = address[7]["short_name"] as? String
                    }
                    //print("\n\(number) \(street), \(city), \(state) \(zip)")
                    
                    
                }
                
                if let address = result[0]["formatted_address"] as? String {
                    place.address = address
                    
                }
                
            }
            
            dispatch_async( dispatch_get_main_queue(), {
                // Add code here to update the UI/send notifications based on the
                // results of the background processing
                self.testingLocationView?.updateMainLocation(place)
                
            });
        });
        
        
        
    }
    
    
    
    
    
    
    // let long = locations[0].coordinate.longitude;
    // let lat = locations[0].coordinate.latitude;
    
    //Do What ever you want with it
    
    
    
    func fetchNeighBourLocation(location : CLLocation) {
        
        for i in 0...7 {
            
            self.fectAddressUsingGoogleApi(i>3 ? i+1 : i, location: location)
            
        }
    }
    
    
    func fetchLocaitonInfo(i : Int, location : CLLocation) {
        
        let offset = testingLocationView?.offset ?? 0.0
        
        let array = [-1,0,1]
        
        let changeX = array[i/3]
        let changeY = array[i%3]
        
        let l = CLLocation(latitude: location.coordinate.latitude + (Double)(offset * (Float)(changeX)), longitude: location.coordinate.longitude + (Double)(offset*(Float)(changeY)) )
        
        print("\(l.coordinate) .........\(location.coordinate)............\(offset)")
        
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(l) { [weak self](placemarks, error) -> Void in
            if (error != nil || placemarks == nil||placemarks?.count == 0) {
                // log.error("reverse geodcode fail: \(error!.localizedDescription)")
                return
            }
            let place = MyPlacemark()
            place.initWithPlacemark(placemarks![0])
            self?.testingLocationView?.updateLocations(place, index: i > 4 ? i-1 : i)
            
            //            for place in placemarks! {
            //                if let p = place as? CLPlacemark {
            //                    print(" \(placemarks?.count)  \(p.locality!) --- \(p.subLocality)--- \( p.administrativeArea!) -------- \(p.subAdministrativeArea)...\(p.thoroughfare)")
            //
            //                }
            //            }
            
        }
        
    }
    
    
    
    func fectAddressUsingGoogleApi(i: Int, location :CLLocation) {
        
        let offset = testingLocationView?.offset ?? 0.0
        
        let array = [-1,0,1]
        
        let changeX = array[i/3]
        let changeY = array[i%3]
        
        let l = CLLocation(latitude: location.coordinate.latitude + (Double)(offset * (Float)(changeX)), longitude: location.coordinate.longitude + (Double)(offset*(Float)(changeY)) )
        
        print("\(l.coordinate) .........\(location.coordinate)............\(offset)")
        
        
        
        
        
        
        dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            // Add code here to do background processing
            //
            //
            
            let url = NSURL(string: "\(ServerUrls.googleMapUrl)latlng=\(l.coordinate.latitude),\(l.coordinate.longitude)&key=\(ServerUrls.apikey)")
            let data = NSData(contentsOfURL: url!)
            let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            
            let place = MyPlacemark()
            
            if let result = json["results"] as? NSArray {
                
                if let address = result[0]["address_components"] as? NSArray {
                    
                    place.subThoroughfare = address[0]["short_name"] as? String
                    place.thoroughfare = address[1]["short_name"] as? String
                    place.subLocality = address[2]["short_name"] as? String
                    place.locality = address[3]["short_name"] as? String
                    place.subAdministrativeArea = address[4]["short_name"] as? String
                    
                    if (address.count > 5){
                        place.administrativeArea = address[5]["short_name"] as? String
                    }
                    if (address.count > 7){
                        place.pincode = address[7]["short_name"] as? String
                    }
                    //print("\n\(number) \(street), \(city), \(state) \(zip)")
                    
                    
                }
                
                if let address = result[0]["formatted_address"] as? String {
                    place.address = address
                    
                }
                
            }
            
            dispatch_async( dispatch_get_main_queue(), {
                // Add code here to update the UI/send notifications based on the
                // results of the background processing
                self.testingLocationView?.updateLocations(place, index: i > 4 ? i-1 : i)
                
            });
        });
        
        
        
    }
    
    
}


