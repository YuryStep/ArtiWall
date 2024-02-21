//
//  UIButton+Extensions.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 21.02.2024.
//

import UIKit

extension UIButton {
    convenience init(systemImage: String, imageFontSize: CGFloat) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        let systemImageConfiguration = UIImage.SymbolConfiguration(pointSize: imageFontSize, weight: .regular)
        let image = UIImage(systemName: systemImage)?.withConfiguration(systemImageConfiguration)
        setImage(image, for: .normal)
    }
}
