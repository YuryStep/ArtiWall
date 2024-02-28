//
//  UIViewController+Extensions.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 28.02.2024.
//

import UIKit

extension UIViewController {
    func wrappedInNavigationController() -> UINavigationController {
        self.navigationItem.hidesBackButton = true
        let wrappedController = UINavigationController(rootViewController: self)
        wrappedController.setNavigationBarHidden(true, animated: false)
        return wrappedController
    }
}
