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
    func getPromptCellDisplayData() -> [HomeCollectionView.Item]
    func didTapOnCell(at indexPath: IndexPath)
}

protocol HomeViewInput: AnyObject {
    func hideKeyboard()
    func showCoverLoader()
    func insertIntoSearchBar(prompt: String)
}

final class HomeViewController: UIViewController {
    private enum Constants {
        static let verticalOffset = 20
        static let horizontalOffset = 10
        static let searchBarHeight = 44
        static let searchBarCornerRadius: CGFloat = 15
        static let searchBarBorderWidth: CGFloat = 3
        static let searchButtonIconSize: CGFloat = 25
        static let titleLabelFontSize: CGFloat = 20
        static let titleLabelText = "Choose one of an inspiring prompt below or craft your own unique idea"
    }

    var presenter: HomeViewOutput!

    private lazy var collectionView: HomeCollectionView = {
        let collectionView = HomeCollectionView(frame: .zero, delegate: self)
        collectionView.keyboardDismissMode = .onDrag
        return collectionView
    }()

    private lazy var titleLabel: UILabel = {
        let font = UIFont.appFont(.misterBrush, size: Constants.titleLabelFontSize)
        let label = UILabel(font)
        label.text = Constants.titleLabelText
        return label
    }()

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.layer.borderWidth = Constants.searchBarBorderWidth
        searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.keyboardAppearance = .dark
        searchBar.tintColor = .white
        searchBar.barTintColor = .clear
        searchBar.searchTextField.defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        searchBar.layer.cornerRadius = Constants.searchBarCornerRadius
        searchBar.searchTextField.leftView = nil
        searchBar.delegate = self
        return searchBar
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
        view.addSubviews([collectionView, titleLabel, searchBar])
        let guide = view.safeAreaLayoutGuide

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(guide).offset(Constants.verticalOffset)
            $0.leading.equalToSuperview().offset(Constants.horizontalOffset)
            $0.trailing.equalToSuperview().inset(Constants.horizontalOffset)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.verticalOffset)
            $0.leading.equalToSuperview().offset(Constants.horizontalOffset)
            $0.trailing.equalToSuperview().inset(Constants.horizontalOffset)
            $0.bottom.equalTo(searchBar.snp.top).inset(-Constants.horizontalOffset)
        }

        searchBar.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Constants.horizontalOffset)
            $0.trailing.equalToSuperview().inset(Constants.horizontalOffset)
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-Constants.verticalOffset)
            $0.height.equalTo(Constants.searchBarHeight)
        }
    }

    private func hideKeyboardOnTap(isOn: Bool) {
        guard isOn else { return }
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapRecognizer.cancelsTouchesInView = false
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

    func insertIntoSearchBar(prompt: String) {
        searchBar.text = prompt
        searchBar.becomeFirstResponder()
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

extension HomeViewController: HomeCollectionViewDelegate {
    func getPromptCellDisplayData() -> [HomeCollectionView.Item] {
        presenter.getPromptCellDisplayData()
    }

    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - CGFloat(Constants.horizontalOffset * 3)) / 2
        return CGSize(width: width, height: width * 0.7)
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section == HomeCollectionView.Section.main.rawValue else { return }
        presenter.didTapOnCell(at: indexPath)
    }
}
