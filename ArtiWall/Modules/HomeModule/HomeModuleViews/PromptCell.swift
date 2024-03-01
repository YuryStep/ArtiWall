//
//  PromptCell.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 01.03.2024.
//

import UIKit

final class PromptCell: UICollectionViewCell {
    private enum Constants {
        static let padding = 10
        static let cornerRadius: CGFloat = 15
    }

    private let promptLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellStyle()
        setupSubviews()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("This class does not support NSCoder")
    }

    func configure(with prompt: String) {
        promptLabel.text = prompt
    }

    private func setupCellStyle() {
        layer.cornerRadius = Constants.cornerRadius
        clipsToBounds = true
        setBidirectionalGradientBackground()
        contentView.layer.masksToBounds = true
    }

    private func setBidirectionalGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds

        let topColor = UIColor.appPink.cgColor
        let bottomColor = UIColor.black.cgColor
        gradientLayer.colors = [topColor, bottomColor, topColor]

        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.locations = [0, 0.15, 1]

        layer.insertSublayer(gradientLayer, at: 0)
    }

    private func setupSubviews() {
        addSubview(promptLabel)
        promptLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.padding)
        }
    }
}
