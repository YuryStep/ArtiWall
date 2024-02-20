//
//  ViewController.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 19.02.2024.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
    }

    private func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds

        let topColor = UIColor.appPink.cgColor
        let bottomColor = UIColor.black.cgColor
        gradientLayer.colors = [topColor, bottomColor]

        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.locations = [0, 0.2]

        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
