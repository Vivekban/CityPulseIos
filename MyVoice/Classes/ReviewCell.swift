//
//  ReviewCell.swift
//  MyVoice
//
//  Created by PB014 on 26/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {
    
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var nameDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onRepotButtonClick(sender: UIButton) {
        
    }
}
