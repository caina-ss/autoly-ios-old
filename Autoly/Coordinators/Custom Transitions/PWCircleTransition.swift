//
//  PWCircleTransition.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-07-17.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import UIKit

open class PWCircleTransition: NSObject {
    public var transformValue: CGFloat = 0.06
    public var circle = UIView()
    public var transitionMode: TransitionMode = .present
    public var circleColor = UIColor.white
    public var duration = 0.30
    public var startingPoint = CGPoint.zero {
        didSet {
            circle.center = startingPoint
        }
    }
    
    public enum TransitionMode: Int {
        case present, dismiss
    }
    
}

extension PWCircleTransition: UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        if transitionMode == .present {
            guard let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
            
            let viewCenter = presentedView.center
            let viewSize = presentedView.frame.size
            
            circle = UIView()
            
            circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
            
            circle.layer.cornerRadius = circle.frame.size.height / 2
            circle.center = startingPoint
            circle.backgroundColor = circleColor
            circle.transform = CGAffineTransform(scaleX: transformValue, y: transformValue)
            
            containerView.addSubview(circle)
            
            presentedView.center = startingPoint
            presentedView.transform = CGAffineTransform(scaleX: transformValue, y: transformValue)
            presentedView.alpha = 0
            containerView.addSubview(presentedView)
            
            UIView.animate(withDuration: duration, animations: {
                self.circle.transform = CGAffineTransform.identity
                presentedView.transform = CGAffineTransform.identity
                
                presentedView.center = viewCenter
                
            }, completion: { success in
                UIView.animate(withDuration: 0.05, animations: {
                    presentedView.alpha = 1
                })
                transitionContext.completeTransition(success)
            })
        } else {
            //dismiss
            guard let returningView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
            
            let viewCenter = returningView.center
            let viewSize = returningView.frame.size
            
            circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
            circle.layer.cornerRadius = circle.frame.size.height / 2
            circle.center = startingPoint
            
            UIView.animate(withDuration: 0.05, animations: {
                returningView.alpha = 0
            })
            
            UIView.animate(withDuration: duration, animations: {
                self.circle.transform = CGAffineTransform(scaleX: self.transformValue, y: self.transformValue)
                returningView.transform = CGAffineTransform(scaleX: self.transformValue, y: self.transformValue)
                returningView.center = self.startingPoint
            }, completion: { success in
                returningView.center = viewCenter
                returningView.removeFromSuperview()
                
                self.circle.removeFromSuperview()
                
                transitionContext.completeTransition(success)
            })
        }
    }
    
    func frameForCircle (withViewCenter viewCenter:CGPoint, size viewSize:CGSize, startPoint:CGPoint) -> CGRect {
        let xLength = fmax(startPoint.x, viewSize.width - startPoint.x)
        let yLength = fmax(startPoint.y, viewSize.height - startPoint.y)
        
        let offsetVector = sqrt(xLength * xLength + yLength * yLength) * 2
        let size = CGSize(width: offsetVector, height: offsetVector)
        
        return CGRect(origin: CGPoint.zero, size: size)
    }
}

