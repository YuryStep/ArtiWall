//
//  CoverLoaderPresenter.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 28.02.2024.
//

final class CoverLoaderPresenter {
    private struct State {
        var imageDescription: String
    }

    private weak var view: CoverLoaderInput?
    private var networkService: AppNetworkService
    private var state: State

    init(view: CoverLoaderInput?, networkService: AppNetworkService, imageDescription: String) {
        self.view = view
        self.networkService = networkService
        self.state = State(imageDescription: imageDescription)
    }
}

extension CoverLoaderPresenter: CoverLoaderOutput {
    func startImageLoading() {
        print(state.imageDescription)
        getGeneratedImage(text: state.imageDescription)
    }

    private func getGeneratedImage(text: String) {
        networkService.fetchAIGeneratedImageUsing(description: text) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(image):
                view?.showGeneratedWallpaper(with: image)
            case .failure:
                view?.showPopupErrorAlert()
            }
        }
    }
}
