//
//  PopupDismissalTransition.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 27.02.2024.
//

import UIKit

final class PopupDismissalTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using _: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.5 // Продолжительность анимации (в секундах)
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from),
              let toViewController = transitionContext.viewController(forKey: .to)
        else {
            return
        }

        let containerView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)

        // Устанавливаем начальные свойства для анимации исчезновения
        // Размер
        fromViewController.view.transform = CGAffineTransform.identity
        // Прозрачность
        fromViewController.view.alpha = 1.0
        // Сдвигаем контроллер вниз
        fromViewController.view.frame.origin.y = 0

        containerView.addSubview(toViewController.view)

        UIView.animate(withDuration: duration, animations: {
            // Уменьшаем размер до 0.1
            fromViewController.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            // Затухание
            fromViewController.view.alpha = 0.0
            // Плавно исчезаем вниз
            fromViewController.view.frame.origin.y = containerView.frame.size.height
        }) { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
