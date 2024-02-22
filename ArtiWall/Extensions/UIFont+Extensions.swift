//
//  UIFont+Extensions.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 22.02.2024.
//

import UIKit

enum AppFont: String {
    case misterBrush = "MisterBrush"
}

extension UIFont {
    static func appFont(_ font: AppFont, size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: font.rawValue, size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return customFont
    }
}
