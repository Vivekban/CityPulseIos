//
//  MessageCell.swift
//  MyVoice
//
//  Created by PB014 on 14/03/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class ChatPeopleCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var lastMessage: UILabel!
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var unreadLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


class ChatMessageCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var pic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
