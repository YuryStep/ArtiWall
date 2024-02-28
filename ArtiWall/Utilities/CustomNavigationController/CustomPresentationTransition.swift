//
//  CustomPresentationTransition.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 27.02.2024.
//

import UIKit

final class CustomPresentationTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using _: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.5
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from),
              let toViewController = transitionContext.viewController(forKey: .to)
        else {  return }

        let containerView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)

        // Set initial state
        toViewController.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        toViewController.view.alpha = 0.0
        toViewController.view.frame.origin.y = containerView.frame.size.height
        containerView.addSubview(toViewController.view)

        UIView.animate(withDuration: duration, animations: {
            toViewController.view.transform = CGAffineTransform.identity
            toViewController.view.alpha = 1.0
            toViewController.view.frame.origin.y = 0
        }) { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

