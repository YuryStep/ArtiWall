//
//  PopupActionButton.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 29.02.2024.
//

import UIKit

final class PopupActionButton: UIButton {
    init(title: String,
         backgroundColor: UIColor = .popUpReteyButton,
         titleColor: UIColor = .systemGray2,
         cornerRadius: CGFloat = 10,
         titleLabelFontSize: CGFloat = 30)
    {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        setTitleColor(titleColor, for: .normal)
        layer.cornerRadius = cornerRadius
        titleLabel?.font = UIFont.appFont(.misterBrush, size: titleLabelFontSize)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
}
