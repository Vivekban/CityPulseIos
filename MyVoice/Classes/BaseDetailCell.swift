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

}

class BaseCommentDetailCell: BaseDetailCell {
    
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
        // collectionView.delegate = self
    }
    
    override func updateViewsWith(data: BaseData?) {
        super.updateViewsWith(data)
        //setInitialLargeImage
        onItemClick(0)
    }
    
}


extension BaseImageDetailCell : UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
            if index < d.imagesUrls.count {
                ServerImageFetcher.i.loadImageWithDefaultsIn(largeImageView, url: d.imagesUrls[index])
                
            }
            else{
                //TODO: impelement default image
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

        
    }
    
    @IBAction func onVoteUpIssueClick(sender: UIButton) {
        if let d = data as? IssueData {
            d.votes++
        votesLabel.text = "\(d.votes)"
        }
    }
    @IBAction func onVoteDownClick(sender: UIButton) {
        if let d = data as? IssueData {
            d.votes--
            votesLabel.text = "\(d.votes)"
        }
    }
    
    override func updateViewsWith(data: BaseData?) {
        super.updateViewsWith(data)
        if let d = data as? IssueData {
            votesLabel.text = "\(d.votes)"
            ownerAreaLabel.text = d.ownerArea
            ownerNameLabel.text = d.ownerName
            ownerCreditsLabel.text = d.ownerCredits
            ServerImageFetcher.i.loadProfileImageWithDefaultsIn(profilePic, url: d.ownerPic)
        }
    }
}
