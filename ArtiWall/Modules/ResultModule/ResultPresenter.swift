//
//  ResultPresenter.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 28.02.2024.
//

import UIKit

final class ResultPresenter: NSObject {
    private enum Constants {
        static let photoSavedMessage = "Photo saved"
        static let photoSavingErrorMessage = "There is some problems with saving photo"
    }

    private struct State {
        var generatedImage: UIImage
    }

    private weak var view: ResultViewInput?
    private var state: State

    init(view: ResultViewInput?, generatedImage: UIImage) {
        self.view = view
        state = State(generatedImage: generatedImage)
    }
}

extension ResultPresenter: ResultViewOutput {
    func getImage() -> UIImage {
        return state.generatedImage
    }

    func backButtonTapped() {
        view?.comebackToHomeView()
    }

    func saveButtonTapped() {
        saveImageToAlbum()
    }

    func showTimeButtonTapped() {
        view?.updateTimeLabelVisibility()
    }

    private func saveImageToAlbum() {
        UIImageWriteToSavedPhotosAlbum(state.generatedImage, self, #selector(savingToAlbum), nil)
    }

    @objc private func savingToAlbum(_: UIImage, error: NSError?, contextInfo _: UnsafeRawPointer) {
        guard error == nil else {
            view?.showSavingStatusInfoView(message: Constants.photoSavingErrorMessage, isSaved: false)
            performHapticFeedback()
            return
        }
        view?.showSavingStatusInfoView(message: Constants.photoSavedMessage, isSaved: true)
        performHapticFeedback()
    }

    private func performHapticFeedback() {
        let feedbackGenerator = UINotificationFeedbackGenerator()
        feedbackGenerator.notificationOccurred(.success)
    }
}
