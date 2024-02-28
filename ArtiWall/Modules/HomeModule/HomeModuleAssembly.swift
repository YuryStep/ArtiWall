//
//  HomeModuleAssembly.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 28.02.2024.
//

import UIKit

enum HomeModuleAssembly {
    static func makeModule() -> UIViewController {
        let homeViewController = HomeViewController()
        let homePresenter = HomePresenter(view: homeViewController)
        homeViewController.presenter = homePresenter
        return homeViewController.wrappedInNavigationController()
    }
}
