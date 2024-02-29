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
        static let minimumHitAreaSize: CGFloat = 44
    }

    enum Icon: String {
        case arrowDownCircleFill = "arrow.down.circle.fill"
        case arrowUpCircleFill = "arrow.up.circle.fill"
        case chevronLeftCircleFill = "chevron.left.circle.fill"
        case eyeCircleFill = "eye.circle.fill"
        case eyeSlashCircleFill = "eye.slash.circle.fill"
    }

    private let buttonIcon: Icon
    private let iconBackgroundColor: UIColor
    private let iconTintColor: UIColor
    private let iconSize: CGFloat

    init(withIcon icon: Icon,
         iconBackgroundColor: UIColor = .systemGray5,
         iconTintColor: UIColor = .black,
         iconSize: CGFloat = Constants.defaultIconSize)
    {
        buttonIcon = icon
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

    override func layoutSubviews() {
        super.layoutSubviews()
        if let iconFrame = imageView?.frame {
            let squareSize = max(iconFrame.width, iconFrame.height)
            widthAnchor.constraint(equalToConstant: squareSize).isActive = true
            heightAnchor.constraint(equalToConstant: squareSize).isActive = true
        }
        layer.cornerRadius = min(frame.width, frame.height) / 2
    }

    override func point(inside point: CGPoint, with _: UIEvent?) -> Bool {
        let horizontalInset = -max(0, Constants.minimumHitAreaSize - bounds.width)
        let verticalInset = -max(0, Constants.minimumHitAreaSize - bounds.height)
        let increasedBounds = bounds.insetBy(dx: horizontalInset, dy: verticalInset)
        return increasedBounds.contains(point)
    }

    func setIcon(_ icon: Icon) {
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: iconSize, weight: .regular, scale: .medium)
        let image = UIImage(systemName: icon.rawValue, withConfiguration: imageConfiguration)
        setImage(image, for: .normal)
    }

    private func initialSetup() {
        setIcon(buttonIcon)
        backgroundColor = iconBackgroundColor
        tintColor = iconTintColor
        clipsToBounds = true
    }
}
