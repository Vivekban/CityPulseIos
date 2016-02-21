//
//  EditReviewController.swift
//  MyVoice
//
//  Created by PB014 on 08/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class EditReviewController:BaseEditViewController{
    
    @IBOutlet weak var name: FloatLabelTextField!
    @IBOutlet weak var titleField: FloatLabelTextField!
    @IBOutlet weak var descptionField: DescriptionView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func fetchDataFromUIElements() {
        if let d = data as? ReviewData {
            d.reviewerName = name.text ?? ""
            d.title = titleField.text ?? ""
            d.description = descptionField.text ?? ""
        }
    }
    
    override func initialiseViews() {
        if let d = data as? ReviewData {
             name.text = d.reviewerName
             titleField.text = d.title
             descptionField.text = d.description
        }
    }

}
