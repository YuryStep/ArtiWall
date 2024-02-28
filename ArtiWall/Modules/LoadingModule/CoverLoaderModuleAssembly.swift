//
//  CoverLoaderModuleAssembly.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 28.02.2024.
//

import UIKit

enum CoverLoaderModuleAssembly {
    static func makeModule(with imageDescription: String) -> UIViewController {
        let apiBuilder = APIBuilder()
        let networkService = NetworkService(apiBuilder: apiBuilder)
        let coverLoaderViewController = CoverLoaderViewController()
        let coverLoaderPresenter = CoverLoaderPresenter(view: coverLoaderViewController,
                                                        networkService: networkService,
                                                        imageDescription: imageDescription)
        coverLoaderViewController.presenter = coverLoaderPresenter
        return coverLoaderViewController
    }
}
