//
//  UICollectionViewCell+Extensions.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 01.03.2024.
//

import UIKit

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
