//
//  RoundIconButton.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 26.02.2024.
//

import UIKit

class RoundIconButton: UIButton {
    private enum Constants {
        static let defaultIconSize: CGFloat = 35
    }

    enum Icon: String {
        case arrowDownCircleFill = "arrow.down.circle.fill"
        case arrowUpCircleFill = "arrow.up.circle.fill"
        case chevronLeftCircleFill = "chevron.left.circle.fill"
        case eyeCircleFill = "eye.circle.fill"
        case eyeSlashCircleFill = "eye.slash.circle.fill"
    }

    private let iconName: String
    private let iconBackgroundColor: UIColor
    private let iconTintColor: UIColor
    private let iconSize: CGFloat

    init(
        withIcon icon: Icon,
        iconBackgroundColor: UIColor = .systemGray5,
        iconTintColor: UIColor = .black,
        iconSize: CGFloat = Constants.defaultIconSize
    ) {
        iconName = icon.rawValue
        self.iconBackgroundColor = iconBackgroundColor
        self.iconTintColor = iconTintColor
        self.iconSize = iconSize
        super.init(frame: .zero)
        initialSetup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("This class does not support NSCoder")
    }

    func setIcon(_ icon: Icon) {
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: iconSize, weight: .regular, scale: .medium)
        let image = UIImage(systemName: icon.rawValue, withConfiguration: imageConfiguration)
        setImage(image, for: .normal)
    }

    private func initialSetup() {
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: iconSize, weight: .regular, scale: .medium)
        let image = UIImage(systemName: iconName, withConfiguration: imageConfiguration)
        setImage(image, for: .normal)

        backgroundColor = iconBackgroundColor
        tintColor = iconTintColor
        clipsToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if let iconFrame = imageView?.frame {
            let squareSize = max(iconFrame.width, iconFrame.height)
            widthAnchor.constraint(equalToConstant: squareSize).isActive = true
            heightAnchor.constraint(equalToConstant: squareSize).isActive = true
        }
        layer.cornerRadius = min(frame.width, frame.height) / 2
    }
}
