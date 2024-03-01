//
//  HomePresenter.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 28.02.2024.
//

import Foundation

final class HomePresenter {
    private enum Constants {
        static let stubItems = [
            "A futuristic cityscape with hovering cars and neon lights.",
            "A mystical forest with fireflies illuminating the night.",
            "An adorable puppy wearing sunglasses and surfing on a rainbow wave.",
            "A steaming cup of coffee on a rainy day by the window.",
            "A serene mountain lake reflecting the snow-capped peaks.",
            "A bustling market with colorful fruits and spices.",
            "A cosmic journey through swirling galaxies and sparkling stars.",
            "A cozy fireplace in a rustic cabin with a blanket and hot cocoa.",
            "A playful kitten chasing a trail of bouncing bubbles.",
            "An ancient temple surrounded by cherry blossoms in full bloom."
        ]
    }

    private struct State {
        let promptItems = Constants.stubItems.flatMap { [HomeCollectionView.Item.prompt($0)] }
    }

    private weak var view: HomeViewInput?
    private var state: State

    init(view: HomeViewInput?) {
        self.view = view
        state = State()
    }
}

extension HomePresenter: HomeViewOutput {
    func getPromptCellDisplayData() -> [HomeCollectionView.Item] {
        return state.promptItems
    }

    func didTapOnCell(at indexPath: IndexPath) {
        guard indexPath.row < state.promptItems.count else { return }

        let selectedItem = state.promptItems[indexPath.row]
        if case let .prompt(promptText) = selectedItem {
            view?.insertIntoSearchBar(prompt: promptText)
        }
    }

    func searchButtonTapped() {
        view?.hideKeyboard()
        view?.showCoverLoader()
    }
}
