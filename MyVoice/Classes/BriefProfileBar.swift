//
//  BriefProfileBar.swift
//  MyVoice
//
//  Created by PB014 on 29/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit
import TZStackView

class BriefProfileBar: UIView {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var issueResolvedLabel: UILabel!
    
    var collectionView : UICollectionView?
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        if self.subviews.count == 0 {
        initializeSubviews()
        }
        if collectionView == nil {
            addCollectionViewBasedOnProfile()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if self.subviews.count == 0 {
        initializeSubviews()
        }
        if collectionView == nil {
            addCollectionViewBasedOnProfile()
        }
    }
    
    func initializeSubviews() {
        // below doesn't work as returned class name is normally in project module scope
        /*let viewName = NSStringFromClass(self.classForCoder)*/
        let viewName = "BriefProfileBar"
        let view: UIView = NSBundle.mainBundle().loadNibNamed(viewName,
            owner: self, options: nil)[0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
    }

    func addCollectionViewBasedOnProfile(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = CGFloat(5)
        layout.itemSize = CGSize(width: 230, height: 23)
        collectionView = UICollectionView(frame: (CurrentSession.i.personUI?.breifViewCollectionRect)!, collectionViewLayout: layout)
        collectionView!.dataSource = self
        collectionView!.delegate = self
        collectionView!.registerClass(BriefCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView!.backgroundColor = UIColor.whiteColor()
        addSubview(collectionView!)
        
    }
   
}

extension BriefProfileBar : UICollectionViewDataSource{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (CurrentSession.i.personUI?.briefViewItems.count)!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! BriefCell
        
        let item = CurrentSession.i.personUI?.briefViewItems[indexPath.row]
        
        cell.backgroundColor = UIColor.orangeColor()
        cell.headingLabel?.text = item?.heading
        cell.detailLabel?.text = "300"
        
        if ((item?.isClickable) == true){
            cell.detailLabel?.textColor = Constants.accentColor
        }
        else{
            cell.detailLabel?.textColor = MyColor.grey_131
        }
        // indexPath.section
        // indexPath.row
        // Configure the cell
        
        return cell
    }
    
}


extension BriefProfileBar : UICollectionViewDelegate{
    
}


class BriefCell: UICollectionViewCell {
    var icon:UIImageView?
    var headingLabel:UILabel?
    var detailLabel:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initCell()
    }
    
    func initCell(){
        
        let view:UIView = NSBundle.mainBundle().loadNibNamed("BriefCollectionCell", owner: self, options: nil)[0] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
        
        icon = view.viewWithTag(1) as? UIImageView
        headingLabel = view.viewWithTag(2) as? UILabel
        detailLabel = view.viewWithTag(3) as? UILabel

    }
}
