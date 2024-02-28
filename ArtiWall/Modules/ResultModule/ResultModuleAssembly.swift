//
//  ResultModuleAssembly.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 28.02.2024.
//

import UIKit

enum ResultModuleAssembly {
    static func makeModule(with image: UIImage) -> UIViewController {
        let resultViewController = ResultViewController()
        let resultPresenter = ResultPresenter(view: resultViewController, generatedImage: image)
        resultViewController.presenter = resultPresenter
        return resultViewController
    }
}
