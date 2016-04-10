//
//  BaseEditViewController.swift
//  MyVoice
//
//  Created by PB014 on 11/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit
import Alamofire

protocol BaseEditViewControllerDelegate : class{
    
    func afterSaveDetail(type:EditControllerType, modifiedData :[BaseData], index:Int)
    
}
enum EditControllerType : Int {
    case NEW = 1,EDIT
}

class BaseEditViewController: UIViewController {
    
    var kbHeight: CGFloat!
    
    //MARK: data source fields
    var data:BaseData?
    var dataArray:[BaseData]!
    var dataIndex = 0
    var type:EditControllerType = .EDIT
    
    //MARK: Bar Title fields
    var mainTitle:String = "" {
        didSet{
            setMainTitle()
        }
    }
    var myNavigationItem: UINavigationItem?
    
    // pickers for date
    var popDatePickers = [PopDatePicker]()
    var popDatePickerTextFields = [PopDatePickerParam]()
    
    // string pickers
    var popPickers = [PopTable]()
    var popPickerTextFields = [UITextField]()
    
    // shadowElements
    var shadowObject = [UIView]()
    
    // progress Hud
    var progressHUD = ProgressHUD(text: "Saving")
    
    var addItemUrl = ""
    var updateItemUrl = ""
    
    // delegate
    weak var delegate:BaseEditViewControllerDelegate?
    
    var scrollView:UIScrollView?
    
    var activeTextField:UIView?
    
    var fieldHideByKeyboard = [UITextField]()
    
    
    var fieldWithCharaterLimit = [TextFieldWithCharacterLimit]()
    
    
    
    deinit{
        print(" Edit controller is deallocated.............................")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myNavigationItem = (self.view.viewWithTag(1) as? UINavigationBar)?.items![0]
        
        let item = myNavigationItem?.leftBarButtonItems![0]
        item?.action = "onBackButtonClick"
        item?.target = self
        
        if let items = myNavigationItem?.rightBarButtonItems {
            let save = items[0]
            save.action = "onSaveButtonClick"
            save.target = self
        }
        
        view.viewWithTag(3)?.hidden = true
        
        addTargetsTo(view.viewWithTag(3), and:view.viewWithTag(2))
        self.view.addSubview(progressHUD)
        progressHUD.hide()
        
        
        for v in view.subviews {
            if v .isKindOfClass(UIScrollView.self) {
                scrollView = v as? UIScrollView
                
                scrollView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "dismissKeyboard"))
            }
        }
        
        
        //        let btnName = UIButton()
        //        btnName.setImage(UIImage(named: "imagename"), forState: .Normal)
        //        btnName.frame = CGRectMake(0, 0, 30, 30)
        //        btnName.addTarget(self, action: Selector("action"), forControlEvents: .TouchUpInside)
        //
        //        //.... Set Right/Left Bar Button item
        //        let rightBarButton = UIBarButtonItem()
        //        rightBarButton.customView = btnName
        //        self.navigationItem.rightBarButtonItem = rightBarButton
        //        For System UIBarButtonItem
        //
        //        let camera = UIBarButtonItem(barButtonSystemItem: .Camera, target: self, action: Selector("btnOpenCamera"))
        //        self.navigationItem.rightBarButtonItem = camera
        
        
    }
    
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Landscape
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // scrollView?.contentSize.height = max ((scrollView?.frame.height)!, (scrollView?.contentSize.height)!)
        
    }
    
    func onBackButtonClick(){
        onCancelButtonClick()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        initialiseViews()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        for vw in shadowObject {
            MyUtils.createShadowOnView(vw)
        }
        EventUtils.addObserForKeyBoardEvents(self)
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidAppear(animated)
        EventUtils.removeObserver(self)
        
    }
    
    
    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize =  (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                kbHeight = keyboardSize.height
                //self.animateTextField(true)
                
                if  scrollView != nil{
                    
                    let contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbHeight, 0.0);
                    scrollView!.contentInset = contentInsets;
                    scrollView!.scrollIndicatorInsets = contentInsets;
                    
                    
                    if activeTextField != nil {
                        // If active text field is hidden by keyboard, scroll it so it's visible
                        // Your app might not need or want this behavior.
                        var aRect = self.view.frame;
                        aRect.size.height -= kbHeight;
                        if (!CGRectContainsPoint(aRect, (activeTextField?.superview!.frame.origin)!) ) {
                            var frame = activeTextField?.superview?.frame;
                            frame?.origin.y = (frame?.origin.y)! + 10
                            scrollView?.scrollRectToVisible((frame)!, animated: true)
                        }
                    }
                }
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        // self.animateTextField(false)
        activeTextField = nil
        let contentInsets = UIEdgeInsetsZero;
        if scrollView != nil {
            scrollView!.contentInset = contentInsets;
            scrollView!.scrollIndicatorInsets = contentInsets;
        }
    }
    
    
    
    
    func initialiseViews(){
        setMainTitle()
        for param in popDatePickerTextFields {
            popDatePickerTextFields.append(param)
            let popDatePicker = PopDatePicker(forTextField: param.textField, mode: param.mode)
            popDatePickers.append(popDatePicker)
            param.textField.delegate = self
        }
        
        for f in fieldHideByKeyboard {
            f.delegate = self
        }
        
    }
    
    
    func setMainTitle(){
        if  let item = myNavigationItem {
            
            switch (type){
            case .NEW:
                item.title = "Add " + mainTitle
                break
            case .EDIT:
                item.title = "Edit " + mainTitle
                break
            }
        }
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func addTextFieldForDatePopOver(param :PopDatePickerParam){
        if popDatePickerTextFields.contains(param) == false{
            
            popDatePickerTextFields.append(param)
            let popDatePicker = PopDatePicker(forTextField: param.textField, mode: param.mode)
            popDatePickers.append(popDatePicker)
            param.textField.delegate = self
        }
    }
    
    func addTextFieldForPickerPopOver(field :UITextField, info: PopInfo){
        if !popPickerTextFields.contains(field){
            popPickerTextFields.append(field)
            let popPicker = PopTable(forTextField: field, data: info)
            popPickers.append(popPicker)
            field.delegate = self
        }
    }
    
    
    func setDataSourceWith(type:EditControllerType, inout data :[BaseData], index:Int){
        self.type = type
        
        switch (type) {
        case .NEW:
            self.data = getDataForNewItem()
            break;
        default:
            self.data = data[index]
            break;
        }
        self.dataArray = data
        self.dataIndex = index
    }
    
    func getDataForNewItem() -> BaseData {
        return BaseData()
    }
    
    
    func addTargetsTo(saveButton: AnyObject?, and cancelButton: AnyObject?){
        if let barSave = saveButton as?  UIButton {
            barSave.addTarget(self, action: Selector("onSaveButtonClick"), forControlEvents: UIControlEvents.TouchUpInside)
        }
        if let barCancel = cancelButton as?  UIButton {
            barCancel.addTarget(self, action: Selector("onCancelButtonClick"), forControlEvents: UIControlEvents.TouchUpInside)
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        self.view.endEditing(true)
    }
    
    
    // MARK: Actions
    
    func onCancelButtonClick() {
        // self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: Saving Data
    
    func onSaveButtonClick() {
        fetchDataFromUIElements()
        checkIsReadyToSave()
    }
    
    func fetchDataFromUIElements(){
        assertionFailure()
    }
    
    func isDataReadyToSave() -> String?{
        return data?.isReadyToSave()
    }
    
    
    func checkIsReadyToSave() {
        let message = isDataReadyToSave()
        if (message!.isEmpty) {
            saveDetails()
        }
        else
        {
            showUnableToSaveAlert(message!)
        }
    }
    
    func showUnableToSaveAlert(message: String){
        UIAlertUtils.createOkAlertFor(self, with: message)
        
    }
    
    
    func saveDetails(){
        
        let url = type == .EDIT ? updateItemUrl : addItemUrl
        
        if !url.isEmpty {
            
            if var info = data?.toJSONString() {
                progressHUD.text = MyStrings.saving + " " + mainTitle
                progressHUD.show()
                info = "{\"data\":\(info)}"
                
                print("data sending for savingh \(info)")
                //                ServerRequestInitiater.i.postMessageToServerForJsonResponse(url, postData: ["json" : info], completionHandler: { (result) -> Void in
                //                    self.serverRequestResult(result)
                //                })
                
                let uInfoRequest = ServerRequest(url: url, postData: ["json" : info]) { [weak self](result) -> Void in
                    self!.serverRequestResult(result)
                }
                uInfoRequest.responseType = .Normal
                ServerRequestInitiater.i.initiateServerRequest(uInfoRequest)
                
            }
        }
        
    }
    
    func serverRequestResult(result:ServerResult){
        
        
        if type == .NEW {
            dataArray.append(data!)
            // CurrentSession.i.recentrlyEditedData = dataArray
            
        }
        
        
        switch result {
        case .Success(let value):
            if let uv = value {
                print(uv)
                // delegate?.afterSaveDetail(self.dataIndex)
                delegate?.afterSaveDetail(type, modifiedData: dataArray, index: dataIndex)

                onCancelButtonClick()
            }
            break
        case .Failure(let error):
            print(error)
            UIAlertUtils.createTryAgainWithCancelAlertFor(self, with: MyStrings.errorWhileSaving, tryAgainHandler: { (action) -> Void in
                self.saveDetails()
            })
            break
        default :
            break
        }
        
        
        
        progressHUD.hide()
        
    }
    
    func resign(){
        dismissKeyboard()
        //        for textField in popDatePickerTextFields {
        //            textField.resignFirstResponder()
        //        }
        //        for textField in popPickerTextFields {
        //            textField.resignFirstResponder()
        //        }
        //        view.endEditing(true)
    }
    
}
// MARK: - UItextview delegate

extension BaseEditViewController : UITextViewDelegate {
    
    func textViewDidBeginEditing(textView: UITextView) {
        activeTextField = textView
    }
    
}

// MARK: - UItextfield delegate

extension BaseEditViewController : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        activeTextField = textField
        
        let param =  PopDatePickerParam(field: textField, mode: .Date)
        if let i = popDatePickerTextFields.indexOf(param) {
            resign()
            
            let formatter = NSDateFormatter()
            formatter.dateStyle = .MediumStyle
            formatter.timeStyle = .ShortStyle
            let initDate : NSDate? = formatter.dateFromString(textField.text!)
            
            let mode = self.popDatePickerTextFields[i].mode
            
            let dataChangedCallback : PopDatePicker.PopDatePickerCallback = { (newDate : NSDate, forTextField : UITextField) -> () in
                
                // here we don't use self (no retain cycle)
                forTextField.text = (TimeDateUtils.getStringFrom(newDate, mode: mode) ?? "?") as String
                
            }
            
            popDatePickers[popDatePickerTextFields.indexOf(param)!].pick(self, initDate: initDate, dataChanged: dataChangedCallback)
            return false
        }
        else if (popPickerTextFields.contains(textField)){
            resign()
            popPickers[popPickerTextFields.indexOf(textField)!].pick(self, initData: [textField.text ?? ""], dataChanged: { (newSelection, forTextField) -> () in
                ((forTextField as? UITextField)!.text) = newSelection[0]
            })
            return false
        }
        return true
    }
    
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        guard let tfLimit = TextFieldWithCharacterLimit.isFieldInArray(textField, list: fieldWithCharaterLimit) else{
            return true
        }
        
        
        guard let text = textField.text else
        {
            return true
        }
        
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= tfLimit.maxLimit // Bool
        
        
    }
}



class BaseImageEditViewController: BaseEditViewController {
    var resuseIdentifierImageCell = "imageCell"
    var resuseIdentifierAddCell = "addCell"
    var images = [UIImage]()
    weak var collection: UICollectionView!
    var uploadTimer: NSTimer?
    
    var fileUploader = FileUploader()
    var req:Request!
    
    
    func getCellForRow(row : Int) -> String{
        if let d = data as? ImageUrlData {
            if  row < d.imagesUrls.count{
                return resuseIdentifierImageCell
            }
        }
        return resuseIdentifierAddCell
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if collection != nil {
            collection.reloadData()
        }
    }
    
    
    
    func openImagePicker(){
        fetchDataFromUIElements()
        
        let imagePicker : UIImagePickerController = OneOrientaionImagePickerController()
        imagePicker.modalPresentationStyle = .CurrentContext
        imagePicker.delegate = self
        imagePicker.sourceType = .PhotoLibrary
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func onItemClick(sender: UIView){
        if let _ = sender as? UIButton{
            openImagePicker()
        }
        else{
            openImageView(sender.tag ?? 0)
        }
    }
    
    func onImageClick(sender: UIGestureRecognizer){
        openImageView(sender.view!.tag ?? 0)
    }
    
    func openImageView(tag:Int){
        
        if let d =  (data as? ImageUrlData) {
            let imageViewController = ImagePageViewController.newInstance(d.imagesUrls, images: images, initialPosition: tag)
            imageViewController.delegate = self
            self.presentViewController(imageViewController, animated: true, completion: nil)
        }
    }
    
    
    func addNewImage(image: UIImage){
        images.append(image)
        if let d = data as? ImageUrlData {
            d.imagesUrls.append("")
        }
        collection.reloadData()
    }
    
    override func saveDetails(){
        
        let url = type == .EDIT ? updateItemUrl : addItemUrl
        
        if !url.isEmpty {
            
            if var info = data?.toJSONString() {
                progressHUD.text = MyStrings.saving + " " + mainTitle
                progressHUD.show()
                info = "{\"data\":\(info)}"
                
                print("data sending for savingh \(info)")
                //                ServerRequestInitiater.i.postMessageToServerForJsonResponse(url, postData: ["json" : info], completionHandler: { (result) -> Void in
                //                    self.serverRequestResult(result)
                //                })
                
                fileUploader.setValue(info, forParameter: "json")
                
                for (image) in images {
                    fileUploader.addFileData(UIImageJPEGRepresentation(image, 0.05)!, withName: "image", withMimeType: "image/jpeg")
                }
                //
                //                let uInfoRequest = ServerRequest(url: url, postData: ["json" : info]) { [weak self](result) -> Void in
                //                    self!.serverRequestResult(result)
                //                }
                
                //                uInfoRequest.responseType = .Normal
                //                ServerRequestInitiater.i.initiateServerRequest(uInfoRequest)
                
                let request = NSMutableURLRequest( URL: NSURL(string: url )! )
                request.HTTPMethod = "POST"
                
                req = fileUploader.uploadFile(request: request)
                req.progress { bytesWritten, totalBytesWritten, totalBytesExpectedToWrite in
                    // print(totalBytesWritten)
                    
                    // This closure is NOT called on the main queue for performance
                    // reasons. To update your ui, dispatch to the main queue.
                    dispatch_async(dispatch_get_main_queue()) {
                        print("Total bytes written on main queue: \(totalBytesWritten)....\(totalBytesExpectedToWrite)")
                    }
                    }
                    .responseJSON { response in
                        debugPrint(response)
                        
                        if response.result.isSuccess {
                            
                            self.serverRequestResult(ServerResult.Success(response.data))
                        }
                        else{
                            self.serverRequestResult(ServerResult.Failure(response.result.error))
                            
                        }
                        
                }
                
                //uploadTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateProgress", userInfo: nil, repeats: true)
                
                
            }
        }
        
    }
    
    func updateProgress(){
        //  print(req.progress())
    }
    
    
}

extension BaseImageEditViewController : ImagePageViewControllerDelegate{
    func finalChanges(urls: [String], images: [UIImage]) {
        self.images.removeAll()
        self.images += images
        if let d = data as? ImageUrlData {
            d.imagesUrls.removeAll()
            d.imagesUrls.appendContentsOf(urls)
        }
    }
}

extension BaseImageEditViewController : UIImagePickerControllerDelegate{
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        addNewImage(image)
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}

extension BaseImageEditViewController : UINavigationControllerDelegate{
    
    func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        if let d = data as? ImageUrlData {
            if  indexPath.row < d.imagesUrls.count{
                return true
            }
        }
        return false
    }
    
}

extension BaseImageEditViewController : UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if let d = data as? ImageUrlData {
            let items:Int = min(5 , 1 + d.imagesUrls.count)
            return items
        }
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = getCellForRow(indexPath.row)
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath)
        
        let view = cell.viewWithTag(1)
        
       
        if identifier == resuseIdentifierImageCell {
            //TODO: update image
            print("tag of view are................\(view?.tag).......\(cell.tag)")
            for i in cell.subviews {
                for  j in i.subviews {
                    if let iv = j as? UIImageView {
                        print("loading.............\(view!.tag).......\(cell.tag)")
                        loadImageInImageView(iv, index: indexPath.row)
                    }
                }
            }
           

            cell.gestureRecognizers?.removeAll()
            cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "onImageClick:"))
            cell.tag = indexPath.row
            
        }
        else{
            MyUtils.createShadowOnView(cell)
            if let iv = view as? UIButton {
                iv.addTarget(self, action: "onItemClick:", forControlEvents: UIControlEvents.TouchUpInside)
            }
        }
        
        return cell
    }
    
    func  loadImageInImageView(view:UIImageView, index:Int) {
        if let d = data as? ImageUrlData {
            if d.imagesUrls[index] != "" && !d.imagesUrls[index].isEmpty {
                ServerImageFetcher.i.loadImageWithDefaultsIn(view, url: d.imagesUrls[0])
            }
            else{
                view.image = images[index]
            }
        }
    }
    
}

extension BaseImageEditViewController : UICollectionViewDelegate{
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
        
        //        if let _ = sender.view as? UIButton{
        //            openImagePicker()
        //        }
        //        else{
        //            openImageView(sender.view?.tag ?? 0)
        //        }
    }
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
}

