//
//  ResultPresenter.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 28.02.2024.
//

import UIKit

final class ResultPresenter: NSObject {
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
        if let error = error {
            print("Ошибка сохранения изображения: \(error.localizedDescription)")
        } else {
            print("Изображение успешно сохранено в галерее")
            performHapticFeedback()
        }
    }

    private func performHapticFeedback() {
        let feedbackGenerator = UINotificationFeedbackGenerator()
        feedbackGenerator.notificationOccurred(.success)
    }
}
