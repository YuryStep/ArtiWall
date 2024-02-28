//
//  PopupErrorModuleAssembly.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 28.02.2024.
//

import UIKit

enum PopupErrorModuleAssembly {
    static func makeModule() -> UIViewController {
        let popupErrorViewController = PopupErrorViewController()
        let popupErrorPresenter = PopupErrorPresenter(view: popupErrorViewController)
        popupErrorViewController.presenter = popupErrorPresenter
        return popupErrorViewController
    }
}
