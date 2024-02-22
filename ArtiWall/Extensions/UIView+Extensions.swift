//
//  UIView+Extensions.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 22.02.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}
