//
//  BaseEditViewController.swift
//  MyVoice
//
//  Created by PB014 on 11/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit


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
    var popPickers = [PopPicker]()
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
    
    var activeTextField:UITextField?
    
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
        
        addTargetsTo(view.viewWithTag(3), and:view.viewWithTag(2))
        self.view.addSubview(progressHUD)
        progressHUD.hide()
        
        
        for v in view.subviews {
            if v .isKindOfClass(UIScrollView.self) {
                scrollView = v as? UIScrollView
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
                
                if activeTextField != nil  && scrollView != nil{
                    if fieldHideByKeyboard.contains(activeTextField!){
                       
                        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbHeight, 0.0);
                        scrollView!.contentInset = contentInsets;
                        scrollView!.scrollIndicatorInsets = contentInsets;
                        
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
    
    
    func animateTextField(up: Bool) {
        var movement = (up ? -kbHeight : kbHeight)
        
        UIView.animateWithDuration(0.3, animations: {
            self.view.frame = CGRectOffset(self.view.frame, 0, movement)
        })
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
    
    func addTextFieldForPickerPopOver(field :UITextField, info: PickerInfo){
        if !popPickerTextFields.contains(field){
            popPickerTextFields.append(field)
            let popPicker = PopPicker(forTextField: field, data: info)
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
                progressHUD.text = MyStrings.saving + mainTitle
                progressHUD.show()
                info = "{\"data\":\(info)}"
                
                print("data sending for savingh \(info)")
//                ServerRequestInitiater.i.postMessageToServer(url, postData: ["json" : info], completionHandler: { (result) -> Void in
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
        //TODO: remove this line and uncomment line below
        delegate?.afterSaveDetail(type, modifiedData: dataArray, index: dataIndex)
        

        switch result {
        case .Success(let value):
            if let uv = value {
                print(uv)
               // delegate?.afterSaveDetail(self.dataIndex)
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
                forTextField.text = newSelection[0]
            })
            return false
        }
        return true
    }
    
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if !TextFieldWithCharacterLimit.isFieldInArray(textField, list: fieldWithCharaterLimit) {
            return true
        }
        
        guard let text = textField.text else
        {
            return true
        }
        
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 10 // Bool

        
    }
}



class BaseImageEditViewController: BaseEditViewController {
    var resuseIdentifierImageCell = "imageCell"
    var resuseIdentifierAddCell = "addCell"
    var images = [Int:UIImage]()
    weak var collection: UICollectionView!
    
    
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
        let imagePicker : UIImagePickerController = OneOrientaionImagePickerController()
        imagePicker.modalPresentationStyle = .CurrentContext
        imagePicker.delegate = self
        imagePicker.sourceType = .PhotoLibrary
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func onItemClick(sender: UIGestureRecognizer){
        if let _ = sender.view as? UIButton{
            openImagePicker()
        }
        else{
            openImageView(sender.view?.tag ?? 0)
        }
    }
    
    func openImageView(tag:Int){
        if let d =  (data as? ImageUrlData) {
            let imageViewController = ImagePageViewController.newInstance(d.imagesUrls, images: images, initialPosition: tag)
            imageViewController.delegate = self
            self.presentViewController(imageViewController, animated: true, completion: nil)
        }
    }
    
    
    func addNewImage(image: UIImage){
        images[images.count] = image
        if let d = data as? ImageUrlData {
            d.imagesUrls.append("")
        }
        collection.reloadData()
    }
    
}

extension BaseImageEditViewController : ImagePageViewControllerDelegate{
    func finalChanges(urls: [String], images: [Int : UIImage]) {
        self.images = images
        if let d = data as? ImageUrlData {
            d.imagesUrls = urls
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
            if let iv = view as? UIImageView {
                loadImageInImageView(iv, index: indexPath.row)
            }
        }
        else{
            MyUtils.createShadowOnView(cell)
            
        }
        view?.gestureRecognizers?.removeAll()
        view?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "onItemClick:"))
        
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
        // it is image open image
        openImageView(indexPath.row)
        
    }
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
}
