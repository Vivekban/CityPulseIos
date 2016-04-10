//
//  LeftToRightPresentAnimationController.swift
//  MyVoice
//
//  Created by PB014 on 10/04/16.
//  Copyright © 2016 Vivek. All rights reserved.
//

import UIKit


class LeftToRightPresentAnimationController : NSObject, UIViewControllerAnimatedTransitioning {
    
    @objc func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 2.0
    }
    
    @objc func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
            let containerView = transitionContext.containerView(),
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else {
                return
        }
        
        // 2
        //let initialFrame = originFrame
        let finalFrame = transitionContext.finalFrameForViewController(toVC)
        
        // 3
        let snapshot = toVC.view.snapshotViewAfterScreenUpdates(true)
        //snapshot.frame = initialFrame
        snapshot.layer.masksToBounds = true
    }
}