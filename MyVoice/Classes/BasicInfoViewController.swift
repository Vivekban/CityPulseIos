//
//  BasicInfoViewController.swift
//  MyVoice
//
//  Created by PB014 on 26/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit


class BasicInfoViewController: BaseHeaderCollectionView {
   
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        expandedRows.insert(0)
        columns = 2
        reuseIdentifier = "BasicInfoCell"
        editControlllerIdentifier = "EditInfoViewController"
        
        for _ in 0...3{
            entries.append(CurrentSession.i.personController.person.basicInfo)
        }
        
        collecView = collectionView
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func showEditViewController(type: EditControllerType,index:Int) -> UIViewController?{
//        if let con = MyUtils.presentViewController(self, identifier: editControlllerIdentifier) as? EditBasicInfoViewController {
//            var data = CurrentSession.i.personController.person.basicInfo
//            var en = [BaseData]()
//            en.append(data)
//            con.setDataSourceWith(.EDIT, data: &en, index: 0)
//        }
        
        var controller : UIViewController?
        if index == 1 {
            controller = MyUtils.presentViewController(self, identifier: "EditOccupationInfoController")
        }
        else {
            controller = super.showEditViewController(type, index: index)
        }
        
        if let con = controller as? EditBasicInfoViewController {
            con.setDataSourceWith(type, data: &entries, index: index)
            con.delegate = self
            con.infoType = PersonBasicInfoType(rawValue: index)!
        }
        
        return controller
    }

    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return entries.count
    }
    
    override func reloadData(index:Int) {
        collectionView.reloadData()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if super.collectionView(collectionView, numberOfItemsInSection: section) > 0{
            return CurrentSession.i.personUI!.getInfoItemBy(PersonBasicInfoType(rawValue: section)!).count
        }
        return 0
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! BasicInfoCell
        
        // Configure the cell
        if let infoType = PersonBasicInfoType(rawValue: indexPath.section) {
            let title = CurrentSession.i.personUI!.getInfoItemBy(infoType)[indexPath.row]
            cell.title.text = title
            cell.content.text = CurrentSession.i.personController.person.basicInfo.getValueBy(infoType, row: indexPath.row) ?? ""
            cell.bottomLine.hidden = isBottomLineHidde(indexPath.row, section: indexPath.section)
        }
        
      
        return cell
    }
    
    func isBottomLineHidde(index : Int , section : Int) -> Bool {
        
        let max = CurrentSession.i.personUI?.getInfoItemBy(PersonBasicInfoType(rawValue: section)!).count ?? 0
        
        if (max == index + 1){
            return true
        }
        else if (max == index + 2 &&  max % 2 == 0){
            return true
        }
        
        
        
        return false
        
    }
    
    override func getTitleForHeader(index: Int) -> String {
        return Constants.personInfoHeader[index]
    }
    
    
    
    override func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSize(width: Int(collectionView.frame.size.width)/columns - 25, height: 45)
    }
    
    
}

