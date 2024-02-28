//
//  ResultPresenter.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 28.02.2024.
//

import UIKit

final class ResultPresenter {
    private struct State {
        var generatedImage: UIImage
    }
    
    private weak var view: ResultViewInput?
    private var state: State

    init(view: ResultViewInput?, generatedImage: UIImage) {
        self.view = view
        self.state = State(generatedImage: generatedImage)
    }
}

extension ResultPresenter: ResultViewOutput {
    func getImage() -> UIImage {
        return state.generatedImage
    }
    
    func backButtonTapped() {
        print("backButtonTapped")
    }

    func saveButtonTapped() {
        print("saveButtonTapped")
    }

    func showTimeButtonTapped() {
        print("showTimeButtonTapped")
    }
}
