//
//  CoverLoaderViewController.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 22.02.2024.
//

import UIKit
import SnapKit
import Lottie

final class CoverLoaderViewController: UIViewController {
    private enum Constants {
        static let animationName = "plane"
        static let overtimeLabelText = "We need a little bit more time..."
        static let countdownDuration = 7
        static let labelTextSize: CGFloat = 30
        static let offsetTop = 15
    }

    private var countdownTimer: Timer?
    private var countdownSeconds = Constants.countdownDuration

    private lazy var planeAnimationView: LottieAnimationView = {
        let view = LottieAnimationView(name: Constants.animationName)
        view.contentMode = .scaleAspectFit
        view.loopMode = .loop
        view.backgroundColor = .black
        view.isHidden = true
        return view
    }()

    private lazy var waitingLabel: UILabel = {
        let label = UILabel(UIFont.appFont(.misterBrush, size: Constants.labelTextSize))
        label.textColor = .white
        label.text = getTextForEstimatedTime(seconds: Constants.countdownDuration)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        return label
    }()

    override func loadView() {
        view = planeAnimationView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.addSubview(waitingLabel)
        let guide = view.safeAreaLayoutGuide

        waitingLabel.snp.makeConstraints {
            $0.leading.equalTo(guide)
            $0.trailing.equalTo(guide)
            $0.top.equalTo(guide).offset(Constants.offsetTop)
        }
    }

    func startAnimating() {
        planeAnimationView.isHidden = false
        planeAnimationView.play()
        startCountdownTimer()
    }

    func stopAnimating() {
        planeAnimationView.stop()
        planeAnimationView.isHidden = true
        stopCountdownTimer()
    }

    private func startCountdownTimer() {
        countdownTimer?.invalidate()
        countdownSeconds = Constants.countdownDuration

        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self else { return }

            countdownSeconds -= 1
            waitingLabel.text = getTextForEstimatedTime(seconds: countdownSeconds)

            if countdownSeconds == 0 {
                timer.invalidate()
                waitingLabel.text = Constants.overtimeLabelText
            }
        }
    }

    private func stopCountdownTimer() {
        countdownTimer?.invalidate()
    }

    private func getTextForEstimatedTime(seconds: Int) -> String {
        return "Estimated time \(seconds) sec"
    }
}
