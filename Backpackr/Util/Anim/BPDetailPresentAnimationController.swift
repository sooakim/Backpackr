//
//  BPDetailPresentAnimationController.swift
//  Backpackr
//
//  Created by Sooa Kim on 09/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import Foundation
import UIKit

protocol SharedElementTransition{
    func sharedElement() -> UIView?
}

final class BPDetailPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromViewController = transitionContext.viewController(forKey: .from) as? UINavigationController,
            let sourceViewController = fromViewController.children.first,
            let toViewController = transitionContext.viewController(forKey: .to),
            let sourceView = (sourceViewController as? SharedElementTransition)?.sharedElement() as? UIImageView,
            let toView = (toViewController as? SharedElementTransition)?.sharedElement() else{
            return
        }
        let containerView = transitionContext.containerView
        
        //prepare to transite
        //make fake view to transite from sourceViewController to toViewController
        let transitionView = UIImageView()
        transitionView.frame = containerView.convert(sourceView.frame, from: sourceView.superview!.superview!)
        transitionView.layer.cornerRadius = sourceView.layer.cornerRadius
        transitionView.backgroundColor = sourceView.backgroundColor
        transitionView.contentMode = sourceView.contentMode
        transitionView.clipsToBounds = true
        transitionView.image = sourceView.image
        
        //set sourceViewController background color to toViewController's background color
        let sourceBackgroundColor = sourceViewController.view.backgroundColor
        sourceViewController.view.backgroundColor = toViewController.view.backgroundColor
        //show source & from ViewController
        sourceViewController.view.alpha = 1
        fromViewController.view.alpha = 1
        //hide toViewController
        toViewController.view.isHidden = true
        //hide original sourceView
        sourceView.isHidden = true

        containerView.addSubview(toViewController.view)
        containerView.addSubview(transitionView)
        
        //calculate final frame of transitionView
        var finalFrame = fromViewController.view.safeAreaFrame
        finalFrame.size.height = finalFrame.size.width
        
        UIView.animateKeyframes(
            withDuration: transitionDuration(using: transitionContext),
            delay: 0,
            options: .calculationModeLinear,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/3) {
                    transitionView.frame.center = finalFrame.center
                    
                    fromViewController.view.alpha = 0
                    sourceViewController.view.alpha = 0
                    
                    transitionView.layer.cornerRadius = toView.layer.cornerRadius
                    transitionView.layer.maskedCorners = toView.layer.maskedCorners
                    transitionView.layer.masksToBounds = toView.layer.masksToBounds
                }
                UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1) {
                    transitionView.frame = finalFrame
                }
            },
            completion: { _ in
                //recover source & from ViewController, original sourceView
                sourceViewController.view.backgroundColor = sourceBackgroundColor
                sourceViewController.view.alpha = 1
                fromViewController.view.alpha = 1
                sourceView.isHidden = false
                
                //remove take view
                transitionView.removeFromSuperview()
                
                //show toViewController and finish transition
                toViewController.view.isHidden = false
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
    }
}
