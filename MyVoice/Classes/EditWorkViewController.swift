//
//  EditWorkViewController.swift
//  MyVoice
//
//  Created by PB014 on 07/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class EditWorkViewController: BaseEditViewController {
    let resuseIdentifierImageCell = "imageCell"
    let resuseIdentifierAddCell = "addCell"
    var myWorkUI : MyWorkUI = MyWorkUI()
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var dateField: FramedTextField!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var imagesCollection: UICollectionView!
    
    override func viewDidLoad() {
        mainTitle = "Work".localized
        super.viewDidLoad()
        popDatePickerTextFields.append(dateField)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func getCellForRow(row : Int) -> String{
        if row < myWorkUI.imagesUrl.count {
            return resuseIdentifierImageCell
        }
        else{
            return resuseIdentifierAddCell
            
        }
    }
    
    
    override func setDataSourceWith(type: Type, and data: AnyObject?) {
        super.setDataSourceWith(type, and: data)
        if let w = data as? MyWork {
            myWorkUI = MyWorkUI(work: w)
        }
    }
    
    
    override func saveDetails() {
        var msg : String
        if titleField.text == "" || descriptionField.text == "" {
            msg = "Tile or Descrption empty!"
            UIAlertUtils.createOkAlertFor(self, with: msg)
            return
        }
        
        super.saveDetails()
       
    }
    
    
    func openImagePicker(){
        let imagePicker : UIImagePickerController = OneOrientaionImagePickerController()
        imagePicker.modalPresentationStyle = .CurrentContext
        imagePicker.delegate = self
        imagePicker.sourceType = .PhotoLibrary
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func addNewImage(image: UIImage){
        myWorkUI.images.append(image)
        myWorkUI.imagesUrl.append("")
        imagesCollection.reloadData()
    }
    
    func onItemClick(sender: UIGestureRecognizer){
        if let _ = sender.view as? UIButton{
            openImagePicker()
        }
        else{
            openImageView()
        }
    }
    
    func openImageView(){
        
    }
}

extension EditWorkViewController : UIImagePickerControllerDelegate{
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        addNewImage(image)
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}

extension EditWorkViewController : UINavigationControllerDelegate{
    
    
    
    func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.row < myWorkUI.imagesUrl.count{
            return true
        }
        return false
    }
    
}


extension EditWorkViewController : UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        let items:Int = min(5 , 1 + myWorkUI.images.count)
        return items
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = getCellForRow(indexPath.row)
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath)
        
        let view = cell.viewWithTag(1)
        if identifier == resuseIdentifierImageCell {
            //TODO: update image
            print("checking  image..\(identifier)...\(indexPath.row)")
            if let iv = view as? UIImageView {
                print("updating imagemmm......")
                iv.image = myWorkUI.images[indexPath.row]
            }
        }
        else{
            MyUtils.createShadowOnView(cell)
            
        }
        view?.gestureRecognizers?.removeAll()
        view?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "onItemClick:"))
        
        return cell
    }
    
    
    
}

extension EditWorkViewController : UICollectionViewDelegate{
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // it is image open image
        
    }
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
}

