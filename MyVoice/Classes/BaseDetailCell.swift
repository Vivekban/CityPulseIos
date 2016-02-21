//
//  BaseDetailCell.swift
//  MyVoice
//
//  Created by PB014 on 08/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit
import MapKit

protocol BaseDetailCellDelegate: class {
    func onEditButtonClick()
}

class BaseDetailCell: UITableViewCell {

    //MARK: UI parameters
    var titleLabel: UILabel!
    var editButton: UIButton!
    var dateLabel: UILabel!
    var descriptionLabel: UILabel!

    weak var delegate:BaseDetailCellDelegate?
    var data:BaseData!
    
    weak var actionDelgate : ActionsDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel =  viewWithTag(1) as! UILabel
        editButton =  viewWithTag(2) as! UIButton
        editButton.addTarget(self, action: "onEditButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        
        dateLabel =  viewWithTag(3) as! UILabel
        descriptionLabel =  viewWithTag(4) as! UILabel

        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViewsWith(data :BaseData?){
        self.data = data
        if let d = data as? TitleDesDateData {
            titleLabel.text = d.title
            descriptionLabel.text = d.description
            dateLabel.text = d.disPlayDate
        }
        descriptionLabel.sizeToFit()
    }

    func onEditButtonClick(){
        delegate?.onEditButtonClick()
    }
    
    func onActionButtonClick(sender: UIButton){
        guard let a = Actions(rawValue: sender.tag)  else{
        log.error("Unknow action")
            return
        }
        
        actionDelgate?.onActionButtonClick(a)

    }

}


class BaseCommentDetailCell: BaseDetailCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        for i in 48...52 {
            if let button = self.viewWithTag(i) as? UIButton {
            button.addTarget(self, action: "onActionButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
            }
            // actionButtons.append(button)
        }

    }
    
}

class BaseImageDetailCell: BaseCommentDetailCell {
    var largeImageView:UIImageView!
    var largeMapView:MKMapView!

    var collectionView:UICollectionView!
    let cellResueIndentifier = "ImageCell"
    let cellResueIndentifierMap = "MapCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        
        largeImageView = viewWithTag(5) as! UIImageView
        collectionView = viewWithTag(6) as! UICollectionView
        largeMapView = viewWithTag(7) as! MKMapView

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection = true
        // collectionView.delegate = self
    }
    
    override func updateViewsWith(data: BaseData?) {
        super.updateViewsWith(data)
        //setInitialLargeImage
        if let d = data as? ImageUrlData {
            if ( d.imagesUrls.count > 0) {
                // collectionView.selectItemAtIndexPath(NSIndexPath(forRow: 1, inSection: 0), animated: false, scrollPosition: UICollectionViewScrollPosition.None)
                  onItemClick(1)
            }
            else{
                //collectionView.selectItemAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: false, scrollPosition: UICollectionViewScrollPosition.None)

                onItemClick(0)
            }
        }
    }
    
}


extension BaseImageDetailCell : UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // print(data)
        
        if let d = data as? ImageUrlData {
            return d.imagesUrls.count + 1
        }
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(indexPath.row == 0 ? cellResueIndentifierMap : cellResueIndentifier, forIndexPath: indexPath)
        
        let view = cell.viewWithTag(1)
        if let iv = view as? UIImageView {
            loadImageInImageView(iv, index: indexPath.row - 1)
        }
        else if let iv = view as? MKMapView{
            MapUtils.centerMapOnLocation(iv, location: CLLocation(latitude: 1, longitude: 1), regionRadius: 8000)
        }
        
        //        view?.gestureRecognizers?.removeAll()
        //        view?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "onItemClick:"))
        
        return cell
    }
    
    func  loadImageInImageView(view:UIImageView, index:Int) {
        if let d = data as? ImageUrlData {
            ServerImageFetcher.i.loadImageWithDefaultsIn(view, url: d.imagesUrls[index])
        }
    }
    
    func onItemClick(index:Int){
        if let d = self.data as? ImageUrlData {
            if index == 0 {
                largeMapView.hidden = false
                largeImageView.hidden = true

            }
            else if index - 1 < d.imagesUrls.count {
                ServerImageFetcher.i.loadImageWithDefaultsIn(largeImageView, url: d.imagesUrls[index - 1])
                largeMapView.hidden = true
                largeImageView.hidden = false
            }
        }
    }
}

extension BaseImageDetailCell: UICollectionViewDelegate{
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        onItemClick(indexPath.row)
        
    }
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
}




class IssueDetailCell: BaseImageDetailCell {
    
    //MARK: UI parameters
    var votesLabel: UILabel!
    var profilePic: UIImageView!
    var ownerNameLabel: UILabel!
    var ownerAreaLabel: UILabel!
    var ownerCreditsLabel: UILabel!

    var category:UILabel!
    var title2:UILabel!
    
    var isVoting = false

    override func awakeFromNib() {
        super.awakeFromNib()
        editButton.hidden = true
        // Initialization code
        votesLabel =  viewWithTag(22) as! UILabel
        
        MyUtils.createGreyBorder(viewWithTag(20))
        MyUtils.createGreyBorder(viewWithTag(21))
        
        viewWithTag(21)?.layer.borderWidth = 1

        //MyUtils.createShadowOnView(viewWithTag(22))
        
        profilePic =  viewWithTag(30) as! UIImageView
        ownerNameLabel =  viewWithTag(31) as! UILabel
        ownerAreaLabel =  viewWithTag(32) as! UILabel
        ownerCreditsLabel =  viewWithTag(33) as! UILabel
        
        category =  viewWithTag(8) as! UILabel
        title2 =  viewWithTag(9) as! UILabel


        
    }
    
    @IBAction func onVoteUpIssueClick(sender: UIButton) {
        if isVoting {
            return
        }
        
        if let d = data as? IssueData  {
            if d.isVoted < 1 {
               onVoteRequest(1)
            }
        
        }
    }
    @IBAction func onVoteDownClick(sender: UIButton) {
        if let d = data as? IssueData where !isVoting{
            if d.isVoted > -1 {
                onVoteRequest(-1)
            }

        }
    }
    
    
    func onVoteRequest (change : Int){
        isVoting = true
        
        guard let d = data as? IssueData else {
            return
        }
        
      let param = MyUtils.appendKayToJSONString("{\"vote\":\(change),\"issueid\":\(d.id),\"userid\":\(CurrentSession.i.userId)} ")

        print(param)
        ServerRequestInitiater.i.postMessageToServerForStringResponse(ServerUrls.voteIssueUrl, postData: ["json": param]) { [weak self] (r) -> Void in
            
            self?.isVoting = false
            switch r {
            case .Success(let data):
                 self?.changeVote(change)
                if let d = data {
                    print(d)
                    
                }
                break
            case .Failure(let error):
                print(error)
                ToastUtils.displayToastWith(change > 0 ? MyStrings.unableToVoteUp : MyStrings.unableToVoteDown)
                break
            default :
                break
            }
            
        }
        
    }
    
    
    func changeVote(change : Int){
        guard let d = data as? IssueData else {
            return
        }
        

        let fi = d.isVoted + change
        
        if fi > -2 && fi < 2 {
            d.isVoted = fi
            d.votes += change
            votesLabel.text = "\(d.votes)"
        }

    }
    
    
    override func updateViewsWith(data: BaseData?) {
        super.updateViewsWith(data)
        if let d = data as? IssueData {
            title2.text = d.title
            log.info(d.title)
            category.text = d.category
            votesLabel.text = "\(d.votes)"
            ownerAreaLabel.text = d.ownerArea
            ownerNameLabel.text = d.ownerName
            ownerCreditsLabel.text = d.ownerCredits
            ServerImageFetcher.i.loadProfileImageWithDefaultsIn(profilePic, url: d.ownerPic)
        }
    }
}
