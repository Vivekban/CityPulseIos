//
//  LoaderUtils.swift
//  MyVoice
//
//  Created by PB014 on 26/02/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit

class LoaderUtils {
    static var i = LoaderUtils()
    // let indicator: UIActivityIndicatorView!
    let indicator: LoaderView
    
    
    private init(){
        
        // indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        // indicator.frame = CGRectMake(0.0, 0.0, 80.0, 80.0);
        
        indicator = LoaderView(frame: CGRectMake(0.0, 0.0, 50.0, 50.0))

        indicator.hide()
        UIApplication.sharedApplication().keyWindow?.addSubview(indicator)

    }
    
    func showLoader(view : UIView){
        
        hideLoader()
        
        indicator.center.x = view.center.x
        indicator.center.y = view.center.y
        
        //view.addSubview(indicator)
        indicator.bringSubviewToFront(view)
        indicator.show()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true

    }
    
    func hideLoader(){
        indicator.hide()
        
        if (indicator.superview != nil){
            // indicator.removeFromSuperview()
        }
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false

    }
    
}




class LoaderView: UIVisualEffectView {
    
    let activityIndictor: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
    let blurEffect = UIBlurEffect(style: .Light)
    let vibrancyView: UIVisualEffectView
    
    
    init(frame : CGRect) {
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: blurEffect))
        super.init(effect: blurEffect)
        self.frame = frame
        self.setup()
    }
    
    
    required init(coder aDecoder: NSCoder) {
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: blurEffect))
        super.init(coder: aDecoder)!
        self.setup()
        
    }
    
    func setup() {
        contentView.addSubview(vibrancyView)
        vibrancyView.frame = self.bounds
        activityIndictor.center = vibrancyView.center
        vibrancyView.contentView.addSubview(activityIndictor)
        layer.cornerRadius = 8.0
        layer.masksToBounds = true
        // activityIndictor.startAnimating()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
    }
    
    func show() {
        self.hidden = false
        activityIndictor.startAnimating()
    }
    
    func hide() {
        self.hidden = true
        activityIndictor.stopAnimating()
    }
}


