//
//  WallpaperResultViewController.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 22.02.2024.
//

import UIKit
import SnapKit

protocol ResultViewControllerDelegate: AnyObject {
    func backButtonTapped()
    func saveButtonTapped()
    func showTimeButtonTapped()
}

final class WallpaperResultViewController: UIViewController {
    private enum Constants {
        static let defaultOffset = 20
        static let defaultBottomInset = 30
    }

    weak var delegate: ResultViewControllerDelegate?

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
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

    init(image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = image
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }

    private func setupSubviews() {
        view.addSubviews([imageView, backButton, saveButton, showTimeButton])
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        let guide = view.safeAreaLayoutGuide

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
        delegate?.backButtonTapped()
    }

    @objc private func saveButtonTapped() {
        delegate?.saveButtonTapped()
    }

    @objc private func showTimeButtonTapped() {
        delegate?.showTimeButtonTapped()
    }
}
