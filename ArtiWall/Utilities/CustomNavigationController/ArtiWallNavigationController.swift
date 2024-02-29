//
//  ArtiWallNavigationController.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 28.02.2024.
//

import UIKit

class ArtiWallNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
}

extension ArtiWallNavigationController: UINavigationControllerDelegate {
    func navigationController(_: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from _: UIViewController,
                              to _: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        switch operation {
        case .push: return CustomPresentationTransition()
        case .pop: return CustomDismissalTransition()
        default: return nil
        }
    }
}
