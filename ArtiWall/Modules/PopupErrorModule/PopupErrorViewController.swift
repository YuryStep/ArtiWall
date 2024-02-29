//
//  PopupErrorViewController.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 27.02.2024.
//

import SnapKit
import UIKit

protocol PopupErrorOutput {
    func tryAgainButtonTapped()
    func cancelButtonTapped()
}

protocol PopupErrorInput: AnyObject {
    func goBackToHomeView()
    func retryLoading()
}

final class PopupErrorViewController: UIViewController {
    private enum Constants {
        static let alertViewCornerRadius: CGFloat = 15
        static let horizontalOffset = 20
        static let verticalOffset = 10
        static let titleLabelTextSize: CGFloat = 35
        static let descriptionLabelTextSize: CGFloat = 27
        static let titleLabelText = "oooops!"
        static let descriptionLabelText = "something went wrong 🤯 we are terrible sorry 🥺 if you see that message at first time please try again. if you see few times in a row please try later or change your prompt 🙏🏻"
        static let tryAgainButtonText = "Try Again"
        static let cancelButtonText = "Cancel"
    }

    var presenter: PopupErrorOutput!

    private lazy var alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.alertViewCornerRadius
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let misterBrushFont = UIFont.appFont(.misterBrush, size: Constants.titleLabelTextSize)
        let label = UILabel(misterBrushFont, color: .black)
        label.text = Constants.titleLabelText
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let misterBrushFont = UIFont.appFont(.misterBrush, size: Constants.descriptionLabelTextSize)
        let label = UILabel(misterBrushFont, color: .black)
        label.text = Constants.descriptionLabelText
        return label
    }()

    private lazy var tryAgainButton: UIButton = {
        let tryAgainButton = PopupActionButton(title: Constants.tryAgainButtonText)
        tryAgainButton.addTarget(self, action: #selector(tryAgainButtonTapped), for: .touchUpInside)
        return tryAgainButton
    }()

    private lazy var cancelButton: UIButton = {
        let cancelButton = PopupActionButton(title: Constants.cancelButtonText, backgroundColor: .clear)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return cancelButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.addSubview(alertView)
        alertView.addSubviews([titleLabel, descriptionLabel, tryAgainButton, cancelButton])

        let verticalAlertOffset = view.frame.size.height / 4
        alertView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Constants.horizontalOffset)
            $0.trailing.equalToSuperview().inset(Constants.horizontalOffset)
            $0.top.equalToSuperview().offset(verticalAlertOffset)
            $0.bottom.equalToSuperview().inset(verticalAlertOffset)
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Constants.horizontalOffset)
            $0.trailing.equalToSuperview().inset(Constants.horizontalOffset)
            $0.top.equalToSuperview().offset(Constants.verticalOffset)
        }

        descriptionLabel.snp.contentCompressionResistanceVerticalPriority = 1
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Constants.horizontalOffset)
            $0.trailing.equalToSuperview().inset(Constants.horizontalOffset)
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.verticalOffset)
        }

        tryAgainButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Constants.horizontalOffset)
            $0.trailing.equalToSuperview().inset(Constants.horizontalOffset)
            $0.bottom.equalTo(cancelButton.snp.top).offset(Constants.verticalOffset * -1)
        }

        cancelButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Constants.horizontalOffset)
            $0.trailing.equalToSuperview().inset(Constants.horizontalOffset)
            $0.bottom.equalToSuperview().inset(Constants.verticalOffset)
        }
    }

    @objc func tryAgainButtonTapped() {
        presenter.tryAgainButtonTapped()
    }

    @objc func cancelButtonTapped() {
        presenter.cancelButtonTapped()
    }
}

extension PopupErrorViewController: PopupErrorInput {
    func goBackToHomeView() {
        navigationController?.popToRootViewController(animated: true)
    }

    func retryLoading() {
        navigationController?.popViewController(animated: true)
    }
}
