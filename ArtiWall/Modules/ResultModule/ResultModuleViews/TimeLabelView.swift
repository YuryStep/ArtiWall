//
//  TimeLabelView.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 29.02.2024.
//

import SnapKit
import UIKit

final class TimeLabelView: UIView {
    private enum Constants {
        static let dayDateLabelFontSize: CGFloat = 20
        static let timeLabelFontSize: CGFloat = 90
        static let currentDayLabelFormat = "EEEE, dd MMMM"
        static let currentTimeLabelFormat = "HH:mm"
    }

    private lazy var currentDayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: Constants.dayDateLabelFontSize)
        return label
    }()

    private lazy var currentTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: Constants.timeLabelFontSize)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("This class does not support NSCoder")
    }

    private func setupSubviews() {
        addSubviews([currentTimeLabel, currentDayLabel])

        currentDayLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
        }

        currentTimeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(currentDayLabel.snp.bottom)
            $0.bottom.equalToSuperview()
        }
    }

    func updateDateTime() {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = Constants.currentDayLabelFormat
        let currentDay = dateFormatter.string(from: Date())

        dateFormatter.dateFormat = Constants.currentTimeLabelFormat
        let currentTime = dateFormatter.string(from: Date())

        currentDayLabel.text = currentDay
        currentTimeLabel.text = currentTime
    }
}
