//
//  UILabel+Extensions.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 22.02.2024.
//

import UIKit

extension UILabel {
    convenience init(_ font: UIFont,
                     color: UIColor = .white,
                     linesNumber: Int = 0,
                     alignment: NSTextAlignment = .center)
    {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontForContentSizeCategory = true
        numberOfLines = linesNumber
        textAlignment = alignment
        textColor = color
        self.font = font
    }
}
