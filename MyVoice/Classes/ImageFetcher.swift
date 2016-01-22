//
//  ImageFetcher.swift
//  MyVoice
//
//  Created by PB014 on 14/01/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit
import AlamofireImage


class ServerImageFetcher {
    
    static let i = ServerImageFetcher()
    
    private init(){
        
    }
    
    func loadImageIn(iv :UIImageView, url :String){
        if let nSUrl = NSURL(string: url){
            iv.af_setImageWithURL(nSUrl)
        }
    }
    
    func loadImageIn(iv :UIImageView, url :String, placeHolder :String){
        if let nSUrl = NSURL(string: url){
            if let placeholderImage = UIImage(named: placeHolder) {
                iv.af_setImageWithURL(nSUrl, placeholderImage: placeholderImage)
            }
            else{
                loadImageIn(iv, url: url)
            }

        }
    }
    
    func loadImageWithDefaultsIn(iv :UIImageView, url :String){
        if let nSUrl = NSURL(string: url){
                iv.af_setImageWithURL(nSUrl, placeholderImage: UIImage(named: "Issue"),filter:AspectScaledToFillSizeFilter(size: iv.frame.size),imageTransition: .CrossDissolve(0.2))
        }
    }
    
    
}