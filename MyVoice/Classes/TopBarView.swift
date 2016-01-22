//
//  TopBarView.swift
//  MyVoice
//
//  Created by PB014 on 02/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class TopBarView: UIView {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var cityField: FramedTextField!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    @IBAction func onHelpButtonClick(sender: UIButton) {
    }
    @IBAction func onBackButtonClick(sender: UIButton) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func changeVisibiltOfBackButton(visible:Bool){
        backButton.hidden = visible
        cityLabel.hidden = !visible
        cityField.hidden = !visible

    }
    
    func changeVisibiltOfCity(visible:Bool){
        changeVisibiltOfBackButton(!visible)
    }
}
