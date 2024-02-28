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
        static let titleLabelTextSize: CGFloat = 35
        static let descriptionLabelTextSize: CGFloat = 27
    }

    var presenter: PopupErrorOutput!

    private lazy var alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel(UIFont.appFont(.misterBrush, size: Constants.titleLabelTextSize))
        label.textColor = .black
        label.text = "oooops!"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel(UIFont.appFont(.misterBrush, size: Constants.descriptionLabelTextSize))
        label.textColor = .black
        label.text = "something went wrong 🤯 we are terrible sorry 🥺 if you see that message at first time please try again. if you see few times in a row please try later or change your prompt 🙏🏻"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var tryAgainButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Try Again", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tryAgainButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()

    private let customTransition = PopupPresentationTransition()
    private let customDismissalTransition = PopupDismissalTransition()

    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overCurrentContext
        transitioningDelegate = self
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("This class does not support NSCoder")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.addSubview(alertView)
        alertView.addSubviews([titleLabel, descriptionLabel, tryAgainButton, cancelButton])

        let verticalAlertOffset = view.frame.size.height / 4
        alertView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview().offset(verticalAlertOffset)
            $0.bottom.equalToSuperview().inset(verticalAlertOffset)
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview().offset(10)
        }

        descriptionLabel.snp.contentCompressionResistanceVerticalPriority = 10
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
        }

        tryAgainButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(cancelButton.snp.top).offset(10)
        }

        cancelButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(10)
        }
    }

    private func addBlurEffect() { // TODO: MOVE FROM HERE
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = view.bounds
        view.addSubview(blurView)
    }

    @objc func tryAgainButtonTapped() {
        presenter.tryAgainButtonTapped()
    }

    @objc func cancelButtonTapped() {
        presenter.cancelButtonTapped()
    }
}

extension PopupErrorViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented _: UIViewController, presenting _: UIViewController, source _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customTransition
    }

    func animationController(forDismissed _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customDismissalTransition
    }
}

extension PopupErrorViewController: PopupErrorInput {
    func goBackToHomeView() {
        dismiss(animated: true)
    }

    func retryLoading() {
        print("retryLoading")
    }
}
