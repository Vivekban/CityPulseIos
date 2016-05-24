//
//  BriefProfileBar.swift
//  MyVoice
//
//  Created by PB014 on 29/12/15.
//  Copyright © 2015 Vivek. All rights reserved.
//

import UIKit


enum BriefProfilePersonType:Int {
    case Resident = 1, Leadear
}
enum BriefProfileType:Int {
    case TopBar = 1,TableRow, TopBarSecondPerson
}


let residentInfo = BriefBarInfo(items: [Constants.BriefItemUI_Issue_Raised,Constants.BriefItemUI_Amount_donated,Constants.BriefItemUI_Badges], rect:CGRectMake(750, 10, 240, 80))
let leaderInfo = BriefBarInfo(items: [Constants.BriefItemUI_Follower,Constants.BriefItemUI_Issue_Resolved,Constants.BriefItemUI_Badges,Constants.BriefItemUI_Total_donations,Constants.BriefItemUI_Credits,Constants.BriefItemUI_Reviews], rect: CGRectMake(430, 10, 584, 80))


struct BriefBarInfo {
    var infoItemsRect:CGRect!
    var items: [BriefItemUI]!
    
    init(items:[BriefItemUI], rect:CGRect){
        infoItemsRect = rect
        self.items = items
    }
    
}

@objc
protocol BriefProfileBarDelegate: class{
    func onReviewClick()
    optional func onDonationClick()
    optional func onFollowClick()
    optional func onMessageClick()
}


class BriefProfileBar: UIView {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var issueResolvedLabel: UILabel!
    @IBOutlet weak var partyImage: UIImageView!
    
    @IBOutlet weak var residentCreditLine: UIView!
    @IBOutlet weak var residentCreditInfo: UILabel!
    
    weak var delegate:BriefProfileBarDelegate?
    
    // types
    var ptype:BriefProfilePersonType = .Leadear
    var type:BriefProfileType = .TopBar
    
    var info:BriefBarInfo = leaderInfo
    var data:ProfileData?
    // collection views
    //basic info like credits, isues donation etc
    var itemsCollectionView : UICollectionView?
    // contain button like detail etc
    var optionsCollectionView: UICollectionView?
    
    
    
    
    static func newInstance(owner:UIViewController,type:BriefProfilePersonType, barType:BriefProfileType , data : ProfileData) -> BriefProfileBar{
        let briefProfileView : BriefProfileBar!
        switch (barType) {
        case .TopBar,.TableRow:
            briefProfileView = UINib(nibName: "BriefProfileBar", bundle: nil).instantiateWithOwner(owner, options: nil)[0] as! BriefProfileBar
            break;
        case .TopBarSecondPerson:
            briefProfileView = UINib(nibName: "LeaderVisiterBriefBarView", bundle: nil).instantiateWithOwner(owner, options: nil)[0] as! BriefProfileBar
            break
        default:
            break;
        }
        
        briefProfileView.initialCollectionViews(type, dataType: barType, data: data)
        
        return briefProfileView
    }
    
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        //            if self.subviews.count == 0 {
        //            initializeSubviews()
        //            }
        //            if collectionView == nil {
        //                addCollectionViewBasedOnProfile()
        //            }
    }
    
    //        override init(frame: CGRect) {
    //            super.init(frame: frame)
    //            if self.subviews.count == 0 {
    //            initializeSubviews()
    //            }
    //            if collectionView == nil {
    //                addCollectionViewBasedOnProfile()
    //            }
    //        }
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func initialCollectionViews(type:BriefProfilePersonType, dataType:BriefProfileType , data : ProfileData){
        self.ptype = type
        
        setInfo()
        self.type = dataType
        self.data = data
        setupViews()
    }
    
    func setInfo(){
        switch (ptype) {
        case .Resident:
            info = residentInfo
            break;
        case .Leadear:
            info = leaderInfo
        }
    }
    
    func setupViews(){
        
        switch (ptype) {
        case .Resident:
            partyImage.hidden = true
            issueResolvedLabel.hidden = true
            areaLabel.textColor = UIColor.grayColor()
            areaLabel.font = UIFont.systemFontOfSize(15)
            break;
            
        case .Leadear:
            areaLabel.textColor = UIColor(red: 251.0/255.0, green: 140.0/255.0, blue: 0, alpha: 1)
            areaLabel.font = UIFont.boldSystemFontOfSize(14)
            residentCreditLine.hidden = true
            break;
        }
        
        
        
        initViewWithData()
        addCollectionViewBasedOnProfile()
        addOptionsCollectionView()
        
    }
    
    
    func initViewWithData(){
        if let d = data {
            
            
            ServerImageFetcher.i.loadProfileImageWithDefaultsIn(profileImage, url: d.profileImageUrl)
            nameLabel.text = d.name
            
            switch (ptype) {
            case .Resident:
                areaLabel.text = d.area
                residentCreditInfo.text = "\(d.credits)"
                break;
            case .Leadear:
                areaLabel.text = d.position
                ServerImageFetcher.i.loadImageWithDefaultsIn(partyImage, url: d.politicalPartyImage)
                issueResolvedLabel.text = d.politicalPary
                issueResolvedLabel.sizeToFit()
                break;
            }
            
        }
    }
    
    func addCollectionViewBasedOnProfile(){
        if (itemsCollectionView == nil) {
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = CGFloat(5)
            layout.itemSize = CGSize(width: 240, height: 23)
            itemsCollectionView = UICollectionView(frame: info.infoItemsRect, collectionViewLayout: layout)
            itemsCollectionView!.dataSource = self
            itemsCollectionView!.delegate = self
            itemsCollectionView!.registerClass(BriefCell.self, forCellWithReuseIdentifier: "Cell")
            itemsCollectionView!.backgroundColor = UIColor.whiteColor()
            addSubview(itemsCollectionView!)
        }
        itemsCollectionView?.frame = info.infoItemsRect
    }
    
    func addOptionsCollectionView(){
        
    }
    
    func onReviewClick(sender:UIGestureRecognizer){
        delegate?.onReviewClick()
    }
    
    func updateData(data : ProfileData? = nil){
        // fetch data
        if (data != nil){
            self.data = data
            initViewWithData()
        }
        itemsCollectionView?.reloadData()
    }
    
}

extension BriefProfileBar : UICollectionViewDataSource{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch (collectionView) {
        case itemsCollectionView!:
            return info.items.count
        default:
            break;
        }
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let gesture = UITapGestureRecognizer(target: self, action: "patani");
        
        switch (collectionView) {
            
        case itemsCollectionView!:
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! BriefCell
            
            let item = info.items[indexPath.row]
            
            // cell.backgroundColor = UIColor.orangeColor()
            cell.headingLabel?.text = item.heading
            cell.detailLabel?.text = "\(getValueForCell(indexPath.row))"
            cell.icon?.image = UIImage(named: (item.iconName))
            
            
            if ((item.isClickable) == true){
                cell.detailLabel?.textColor = Constants.accentColor
                cell.headingLabel?.textColor = Constants.accentColor
                
                cell.addGestureRecognizer(gesture)
            }
            else{
                cell.detailLabel?.textColor = MyColor.grey_131
                cell.headingLabel?.textColor = MyColor.grey_131
                
            }
            
            if info.items.count > 3 {
                
                if (indexPath.row % 2 == 0) {
                    cell.decreaseWidth()
                }
                else{
                    cell.normalWidth()
                    
                }
            }
            return cell
            
            
        default:
            break;
        }
        
        // indexPath.section
        // indexPath.row
        // Configure the cell
        return collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
    }
    
    
    
    func getValueForCell(row : Int) ->Int {
        if let data = self.data {
            switch (ptype) {
            case .Resident:
                
                switch (row) {
                case 0:
                    return data.issueRaised
                case 1:
                    return data.donated
                case 2:
                    return data.badges
                default:
                    break;
                }
                
                break;
            case .Leadear:
                switch (row) {
                case 0:
                    return data.followers
                case 1:
                    return data.issueResolved
                case 2:
                    return data.badges
                case 3:
                    return data.donations
                case 4:
                    return data.credits
                case 5:
                    return data.reviews
                default:
                    break;
                }
            }
        }
        return 0
    }
    
    func patani(){
        delegate?.onReviewClick()
    }
    
}


extension BriefProfileBar : UICollectionViewDelegate{
    
}


class BriefProfileBarTableCell: UITableViewCell {
    
    var briefView:BriefProfileBar!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initializeBriefView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeBriefView() {
        // below doesn't work as returned class name is normally in project module scope
        /*let viewName = NSStringFromClass(self.classForCoder)*/
        let viewName = "BriefProfileBar"
        briefView = NSBundle.mainBundle().loadNibNamed(viewName,
            owner: self, options: nil)[0] as! BriefProfileBar
        self.addSubview(briefView)
        briefView.frame = self.bounds
    }
}


class BriefCell: UICollectionViewCell {
    var icon:UIImageView?
    var headingLabel:UILabel?
    var detailLabel:UILabel?
    
    var width :NSLayoutConstraint?
    
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
        width = headingLabel?.constraints[0]
        
    }
    
    func decreaseWidth() {
        print(headingLabel?.text)
        if width != nil {
            width?.constant = 75
            layoutSubviews()
        }
    }
    func normalWidth() {
        print(headingLabel?.text)
        
        if width != nil {
            width?.constant = 120
            layoutSubviews()
        }
    }
}
