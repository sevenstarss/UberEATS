//
//  SZAnimatedTransition.swift
//  UberEATS
//
//  Created by WorldMobile on 7/31/18.
//  Copyright © 2018 WorldMobile. All rights reserved.
//

import UIKit

class SZAnimatedTransition: NSObject, UIViewControllerAnimatedTransitioning {

    public let AnimatorTag = 99
    
    var duration: TimeInterval
    var isPresenting:  Bool
    var originFrame: CGRect
    var image: UIImage
    
    init(duration: TimeInterval, isPresenting: Bool, originFrame: CGRect, image: UIImage) {
        self.duration = duration
        self.isPresenting = isPresenting
        self.originFrame = originFrame
        self.image = image
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else { return }
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        
        print("fromViewFrame: \(fromView.frame)")
        print("toViewFrame:\(toView.frame)")
        
        
        print("fromNavBarFrame \(fromVC.navigationController!.navigationBar.frame)")
        
        
        
        if (isPresenting) {
        
            
            container.addSubview(toView)
            
            let navBarFrame = fromVC.navigationController!.navigationBar.frame
            fromVC.navigationController!.navigationBar.frame = CGRect(x: 0, y: -(navBarFrame.height), width: navBarFrame.width, height: navBarFrame.height)
            
            let tabBarFrame = fromVC.tabBarController!.tabBar.frame
            fromVC.tabBarController!.tabBar.frame = CGRect(x: 0, y: (tabBarFrame.origin.y + tabBarFrame.height), width: tabBarFrame.width, height: tabBarFrame.height)

            UIView.animate(withDuration: duration, animations: {
                
                let toViewFrame = toView.frame
                toView.frame = CGRect(x: toViewFrame.origin.x, y: toViewFrame.origin.y - 44,
                                      width: toViewFrame.width, height: (toViewFrame.height +  tabBarFrame.height))
                
            }) { (finished) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        } else {
            

            container.addSubview(toView)
            
            let navBarFrame = fromVC.navigationController!.navigationBar.frame
            fromVC.navigationController!.navigationBar.frame = CGRect(x: 0, y: (navBarFrame.height), width: navBarFrame.width, height: navBarFrame.height)
            
            let tabBarFrame = fromVC.tabBarController!.tabBar.frame
            fromVC.tabBarController!.tabBar.frame = CGRect(x: 0, y: (tabBarFrame.origin.y - tabBarFrame.height), width: tabBarFrame.width, height: tabBarFrame.height)
            
            UIView.animate(withDuration: duration, animations: {
                
                
            }) { (finished) in

                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)


            }
        }

        
    }
}















