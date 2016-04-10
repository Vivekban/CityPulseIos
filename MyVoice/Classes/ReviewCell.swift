//
//  ReviewCell.swift
//  MyVoice
//
//  Created by PB014 on 26/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

protocol ReviewCellDelegate: class {
    func onReportButtonClick(cell :ReviewCell)
}

class ReviewCell: UITableViewCell {
    
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var nameDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    weak var delegate :ReviewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViewsWithData(data :ReviewData){
        heading.text = data.title
        nameDateLabel.text = MyStrings.by + " " + MyUtils.makeStringTrimmed(data.reviewerName) + " - " + data.disPlayDate
        
        print(".....info ,,,..\(nameDateLabel.text)...\(data.disPlayDate)")
        descriptionLabel.text = data.description
    }

    @IBAction func onRepotButtonClick(sender: UIButton) {
        delegate?.onReportButtonClick(self)
    }
}
