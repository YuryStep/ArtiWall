//
//  HomeViewController.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 19.02.2024.
//

import Lottie
import SnapKit
import UIKit

protocol HomeViewOutput {
    func searchButtonTapped()
}

protocol HomeViewInput: AnyObject {
    func hideKeyboard()
    func showCoverLoader()
}

final class HomeViewController: UIViewController {
    private enum Constants {
        static let offset = 10
        static let inset = 10
        static let searchBarHeight = 44
        static let searchButtonIconSize: CGFloat = 25
    }

    var presenter: HomeViewOutput!

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.layer.borderWidth = 3
        searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.keyboardAppearance = .dark
        searchBar.tintColor = .white
        searchBar.barTintColor = .clear
        searchBar.searchTextField.defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        searchBar.layer.cornerRadius = 15
        searchBar.searchTextField.leftView = nil
        searchBar.delegate = self
        return searchBar
    }()

    private lazy var searchButton: RoundIconButton = {
        let button = RoundIconButton(
            withIcon: .arrowUpCircleFill,
            iconTintColor: .appPink,
            iconSize: Constants.searchButtonIconSize
        )
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        setGradientBackground()
        setupSubviews()
        hideKeyboardOnTap(isOn: true)
    }

    private func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds

        let topColor = UIColor.appPink.cgColor
        let bottomColor = UIColor.black.cgColor
        gradientLayer.colors = [topColor, bottomColor]

        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.locations = [0, 0.2]

        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func setupSubviews() {
        view.addSubview(searchBar)
        searchBar.addSubview(searchButton)

        searchBar.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Constants.offset)
            $0.trailing.equalToSuperview().inset(Constants.inset)
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-Constants.offset)
            $0.height.equalTo(Constants.searchBarHeight)
        }

        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(Constants.inset)
        }
    }

    private func hideKeyboardOnTap(isOn: Bool) {
        guard isOn else { return }
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapRecognizer)
    }

    @objc private func searchButtonTapped() {
        guard let text = searchBar.text, !text.isEmpty else { return }
        presenter.searchButtonTapped()
    }
}

extension HomeViewController: HomeViewInput {
    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    func showCoverLoader() {
        guard let imageDescription = searchBar.text, !imageDescription.isEmpty else { return }
        let coverLoader = CoverLoaderModuleAssembly.makeModule(with: imageDescription)
        navigationController?.pushViewController(coverLoader, animated: true)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_: UISearchBar) {
        presenter.searchButtonTapped()
    }
}
