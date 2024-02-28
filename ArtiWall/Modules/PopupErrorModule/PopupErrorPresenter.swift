//
//  PopupErrorPresenter.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 28.02.2024.
//

import Foundation

final class PopupErrorPresenter {
    private weak var view: PopupErrorInput?

    init(view: PopupErrorInput?) {
        self.view = view
    }
}

extension PopupErrorPresenter: PopupErrorOutput {
    func tryAgainButtonTapped() {
        view?.retryLoading()
    }

    func cancelButtonTapped() {
        view?.goBackToHomeView()
    }
}
