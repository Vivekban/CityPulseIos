//
//  CommunityHubItem.swift
//  MyVoice
//
//  Created by PB014 on 26/05/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit


class CommunityHubItemView: UIView {
    
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var creditsDetail: UILabel!
    
    @IBOutlet weak var issueResoledDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateView(data : CommunityItemData){
        ServerImageFetcher.i.loadProfileImageWithDefaultsIn(pic, url: data.picUrl)
        
        detail.text = data.description
        title.text = data.title
        creditsDetail.text = data.credits.toString()
        issueResoledDetail.text = data.issueRaised.toString()
    }
    
}


class CommunityHubItemCell: UITableViewCell {
    
    var itemView:CommunityHubItemView!
    var data :CommunityItemData!

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        prepareView()
        
    }
    
    func prepareView(){
        if itemView == nil {
            itemView = NSBundle.mainBundle().loadNibNamed("CommunityHubItem", owner: self, options: nil)[0] as! CommunityHubItemView
            itemView.frame = self.bounds
            self.addSubview(itemView)
        }
    }
    
    func initViewWithData(data:CommunityItemData){
        self.data = data
        itemView.updateView(data)
    }

    
}