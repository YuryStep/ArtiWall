//
//  ResultViewController.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 22.02.2024.
//

import SnapKit
import UIKit

protocol ResultViewOutput {
    func getImage() -> UIImage
    func backButtonTapped()
    func saveButtonTapped()
    func showTimeButtonTapped()
}

protocol ResultViewInput: AnyObject {
    func comebackToHomeView()
    func updateTimeLabelVisibility()
}

final class ResultViewController: UIViewController {
    private enum Constants {
        static let defaultOffset = 20
        static let defaultBottomInset = 30
    }

    var presenter: ResultViewOutput!

    private var isTimeVisible = false

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = presenter.getImage()
        return imageView
    }()

    private lazy var timeLabelView: TimeLabelView = {
        let view = TimeLabelView()
        view.isHidden = true
        return view
    }()

    private lazy var backButton: RoundIconButton = {
        let button = RoundIconButton(withIcon: .chevronLeftCircleFill)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var saveButton: RoundIconButton = {
        let button = RoundIconButton(withIcon: .arrowDownCircleFill)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var showTimeButton: RoundIconButton = {
        let button = RoundIconButton(withIcon: .eyeCircleFill)
        button.addTarget(self, action: #selector(showTimeButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }

    private func setupSubviews() {
        view.addSubviews([imageView, backButton, saveButton, showTimeButton, timeLabelView])

        let guide = view.safeAreaLayoutGuide

        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        timeLabelView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(guide.snp.top)
        }

        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Constants.defaultOffset)
            $0.top.equalTo(guide).offset(Constants.defaultOffset)
        }

        saveButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(Constants.defaultOffset)
            $0.bottom.equalToSuperview().inset(Constants.defaultBottomInset)
        }

        showTimeButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Constants.defaultOffset)
            $0.bottom.equalToSuperview().inset(Constants.defaultBottomInset)
        }
    }

    @objc private func backButtonTapped() {
        presenter.backButtonTapped()
    }

    @objc private func saveButtonTapped() {
        presenter.saveButtonTapped()
    }

    @objc private func showTimeButtonTapped() {
        presenter.showTimeButtonTapped()
    }
}

extension ResultViewController: ResultViewInput {
    func comebackToHomeView() {
        navigationController?.popToRootViewController(animated: true)
    }

    func updateTimeLabelVisibility() {
        isTimeVisible.toggle()
        updateShowTimeButtonIcon()
        timeLabelView.isHidden = !isTimeVisible

        if isTimeVisible {
            timeLabelView.updateDateTime()
        }
    }

    private func updateShowTimeButtonIcon() {
        let newIcon: RoundIconButton.Icon = isTimeVisible ? .eyeSlashCircleFill : .eyeCircleFill
        showTimeButton.setIcon(newIcon)
    }
}
