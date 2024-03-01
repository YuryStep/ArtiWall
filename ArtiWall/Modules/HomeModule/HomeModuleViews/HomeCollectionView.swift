//
//  HomeCollectionView.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 01.03.2024.
//

import UIKit

protocol HomeCollectionViewDelegate: AnyObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func getPromptCellDisplayData() -> [HomeCollectionView.Item]
}

final class HomeCollectionView: UICollectionView {
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>

    enum Section: Int {
        case main
    }

    enum Item: Hashable {
        case prompt(String)
    }

    private var homeDataSource: DataSource!
    private var homeCollectionViewDelegate: HomeCollectionViewDelegate!

    init(frame: CGRect, delegate: HomeCollectionViewDelegate) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewLayout())
        homeCollectionViewDelegate = delegate
        setupCollection()
        configureDataSource()
        applySnapshot(animatingDifferences: false)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("This class does not support NSCoder")
    }

    private func setupCollection() {
        register(PromptCell.self)
        delegate = homeCollectionViewDelegate
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        setLayout()
    }

    private func setLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .vertical
        collectionViewLayout = layout
    }

    private func configureDataSource() {
        homeDataSource = DataSource(collectionView: self) { collectionView, indexPath, itemIdentifier in
            guard let section = Section(rawValue: indexPath.section) else {
                assertionFailure("Failed to initialize Section in DataSource")
                return UICollectionViewCell()
            }

            switch section {
            case .main:
                let cell = collectionView.reuse(PromptCell.self, indexPath)
                if case let .prompt(promptString) = itemIdentifier {
                    cell.configure(with: promptString)
                }
                return cell
            }
        }
    }

    func applySnapshot(animatingDifferences: Bool) {
        var snapshot = Snapshot()
        let promptItems = homeCollectionViewDelegate.getPromptCellDisplayData()

        snapshot.appendSections([.main])
        snapshot.appendItems(promptItems)
        homeDataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}
