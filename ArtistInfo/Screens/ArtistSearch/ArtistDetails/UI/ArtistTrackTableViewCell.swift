//
//  ArtistTrackTableViewCell.swift
//  ArtistInfo
//
//  Created by Tonte Owuso on 14/02/2024.
//

import Foundation
import UIKit
import SDWebImage

class ArtistTrackTableViewCell: UITableViewCell {

    static var reuseIdentifier: String {
        "\(String(describing: self))-reuseIdentifier"
    }

    struct CONSTANTS {
        static let defaultMargin: CGFloat = 10.0
        static let imageHeight: CGFloat = 65.0
        static let trackNameLeadingMargin: CGFloat = 20
    }

    struct uiModel {
        let name: String
        let duration: String
        let imageUrl: String
    }


    private let albumArtImageView: UIImageView = {
        let imageView =  UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .caption1)
        return label
    }()

    private let trackDurationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .caption2)
        return label
    }()

    private let containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .systemBackground
        return containerView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        [containerView].forEach(contentView.addSubview)
        [albumArtImageView, trackNameLabel, trackDurationLabel].forEach(containerView.addSubview)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            albumArtImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            albumArtImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: CONSTANTS.defaultMargin),
            albumArtImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -CONSTANTS.defaultMargin),
            albumArtImageView.heightAnchor.constraint(equalToConstant: CONSTANTS.imageHeight),
            albumArtImageView.widthAnchor.constraint(equalToConstant: CONSTANTS.imageHeight)
        ])

        NSLayoutConstraint.activate([
            trackNameLabel.leadingAnchor.constraint(equalTo: albumArtImageView.trailingAnchor, constant: CONSTANTS.trackNameLeadingMargin),
            trackNameLabel.topAnchor.constraint(greaterThanOrEqualTo: containerView.topAnchor, constant: CONSTANTS.defaultMargin),
            trackNameLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -CONSTANTS.defaultMargin),
            trackNameLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            trackDurationLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -CONSTANTS.defaultMargin),
            trackDurationLabel.topAnchor.constraint(greaterThanOrEqualTo: containerView.topAnchor, constant: CONSTANTS.defaultMargin),
            trackDurationLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: CONSTANTS.defaultMargin),
            trackDurationLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            trackDurationLabel.leadingAnchor.constraint(equalTo: trackNameLabel.trailingAnchor, constant: CONSTANTS.defaultMargin)
        ])

    }

    func updateData(_ uiModel: uiModel ) {
        self.trackNameLabel.text = uiModel.name
        self.trackDurationLabel.text = uiModel.duration
        self.albumArtImageView.sd_setImage(with: URL(string: uiModel.imageUrl))
    }

}
