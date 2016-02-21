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
        if let nSUrl = NSURL(string: validateUrl(url)){
            iv.af_setImageWithURL(nSUrl)
        }
    }
    
    func loadImageIn(iv :UIImageView, url :String, placeHolder :String){
        
        if let nSUrl = NSURL(string: validateUrl(url)){
            if let placeholderImage = UIImage(named: placeHolder) {
                iv.af_setImageWithURL(nSUrl, placeholderImage: placeholderImage)
            }
            else{
                loadImageIn(iv, url: url)
            }

        }
        else{
            log.error("unable to convert proper url  \(url)")
        }
    }
    
    func loadImageWithDefaultsIn(iv :UIImageView, url :String){
        if let nSUrl = NSURL(string: validateUrl(url)){
                iv.af_setImageWithURL(nSUrl, placeholderImage: UIImage(),filter:AspectScaledToFillSizeFilter(size: iv.frame.size),imageTransition: .CrossDissolve(0.2))
        }
        else {
            log.error("unable to convert proper url  \(url)")
            iv.image = UIImage(named: "Issue")
        }
    }
    
    func loadProfileImageWithDefaultsIn(iv :UIImageView, url :String){
        if let nSUrl = NSURL(string: validateUrl(url)){
            iv.af_setImageWithURL(nSUrl, placeholderImage: UIImage(),filter:AspectScaledToFillSizeFilter(size: iv.frame.size),imageTransition: .CrossDissolve(0.2))
        }
        else{
            log.error("unable to convert proper url  \(url)")
            iv.image = UIImage(named: "Issue")

        }
    }
    
    func validateUrl(url : String) ->String {
        if !url.containsString("http"){
            return "http://\(url)"
        }
        return url
    }
    
}