//
//  PopupPresentationTransition.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 27.02.2024.
//

import UIKit

final class PopupPresentationTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using _: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.5 // Продолжительность анимации (в секундах)
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from),
              let toViewController = transitionContext.viewController(forKey: .to)
        else {
            return
        }

        let containerView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)

        // Установите начальные свойства для анимации
        // размер
        toViewController.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        // прозрачность
        toViewController.view.alpha = 0.0
        // плавное появление снизу
        toViewController.view.frame.origin.y = containerView.frame.size.height

        containerView.addSubview(toViewController.view)

        UIView.animate(withDuration: duration, animations: {
            // Возвращаем оригинальные размеры
            toViewController.view.transform = CGAffineTransform.identity
            toViewController.view.alpha = 1.0
            // Сдвигаем контроллер вверх
            toViewController.view.frame.origin.y = 0
        }) { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

