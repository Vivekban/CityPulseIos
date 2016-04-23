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
    
    
    
//    public func af_setImageWithURL(URL: NSURL, placeholderImage: UIImage?, filter: ImageFilter?, imageTransition: UIImageView.ImageTransition, runImageTransitionIfCached: Bool = default, completion: (Alamofire.Response<UIImage, NSError> -> Void)?)
//
    
    
    
    func loadImageIn(iv :UIImageView, url :String){
        if let nSUrl = NSURL(string: validateUrl(url)){
            let indicator = getAndAddIndicator(iv)
            iv.af_setImageWithURL(nSUrl, placeholderImage: nil,filter:nil,imageTransition: .CrossDissolve(0.3),runImageTransitionIfCached: false,
                completion: { (response) -> Void in
                    indicator.removeFromSuperview()
            })
        }
    }
    
    func loadImageIn(iv :UIImageView, url :String, placeHolder :String){
        
        
        
        if let nSUrl = NSURL(string: validateUrl(url)){
            if let placeholderImage = UIImage(named: placeHolder) {
                let indicator = getAndAddIndicator(iv)
                iv.af_setImageWithURL(nSUrl, placeholderImage: placeholderImage,filter:nil,imageTransition: .CrossDissolve(0.3),runImageTransitionIfCached: false,
                    completion: { (response) -> Void in
                        indicator.removeFromSuperview()
                })
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
            let indicator = getAndAddIndicator(iv)
            iv.af_setImageWithURL(nSUrl, placeholderImage: nil,filter:AspectScaledToFillSizeFilter(size: getValidFrameSize(iv.frame.size)),imageTransition: .CrossDissolve(0.3),runImageTransitionIfCached: false,
                completion: { (response) -> Void in
                indicator.removeFromSuperview()
            })
        }
        else {
            log.error("unable to convert proper url  \(url)")
            iv.image = UIImage(named: "Issue")
        }
    }
    
    func loadProfileImageWithDefaultsIn(iv :UIImageView, url :String){
        
        if let nSUrl = NSURL(string: validateUrl(url)){
            let indicator = getAndAddIndicator(iv)

            iv.af_setImageWithURL(nSUrl, placeholderImage: UIImage(),filter:AspectScaledToFitSizeFilter(size: iv.frame.size),imageTransition: .CrossDissolve(0.3),runImageTransitionIfCached: false,
                completion: { (response) -> Void in
                    indicator.removeFromSuperview()
            })

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
    
    
    func getAndAddIndicator(imageView :UIImageView) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        indicator.center = imageView.center
        indicator.startAnimating()
        imageView.addSubview(indicator)
        return indicator
    }
    
    func getValidFrameSize(size: CGSize) -> CGSize{
        
        return CGSize( width: max(size.width, 1), height: max(size.height,1))
    }
    
}