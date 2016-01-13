//
//  StringLocalisationExtension.swift
//  MyVoice
//
//  Created by PB014 on 06/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import Foundation


extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}