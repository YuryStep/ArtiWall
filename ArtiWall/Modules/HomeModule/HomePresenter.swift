//
//  HomePresenter.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 28.02.2024.
//

import Foundation

final class HomePresenter {
    private weak var view: HomeViewInput?

    init(view: HomeViewInput?) {
        self.view = view
    }
}

extension HomePresenter: HomeViewOutput {
    func searchButtonTapped() {
        view?.hideKeyboard()
        view?.showCoverLoader()
    }
}
