//
//  ArtistSearchTableViewCell.swift
//  ArtistInfo
//
//  Created by Tonte Owuso on 13/02/2024.
//

import UIKit
import SDWebImage

class ArtistSearchTableViewCell: UITableViewCell {

    static var reuseIdentifier: String {
        "\(String(describing: self))-reuseIdentifier"
    }

    struct CONSTANTS {
        static let defaultMargin: CGFloat = 10.0
        static let imageHeight: CGFloat = 30
        static let imageLeadingMargin: CGFloat = 30
        static let trackNameLeadingMargin: CGFloat = 20
    }

    struct uiModel {
        let name: String
        let imageUrl: String
    }


    private let albumArtImageView: UIImageView = {
        let imageView =  UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = CONSTANTS.imageHeight/2
        return imageView
    }()

    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .subheadline)
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
        [albumArtImageView, artistNameLabel].forEach(containerView.addSubview)
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
            albumArtImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: CONSTANTS.imageLeadingMargin),
            albumArtImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: CONSTANTS.defaultMargin),
            albumArtImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -CONSTANTS.defaultMargin),
            albumArtImageView.heightAnchor.constraint(equalToConstant: CONSTANTS.imageHeight),
            albumArtImageView.widthAnchor.constraint(equalToConstant: CONSTANTS.imageHeight)
        ])

        NSLayoutConstraint.activate([
            artistNameLabel.leadingAnchor.constraint(equalTo: albumArtImageView.trailingAnchor, constant: CONSTANTS.trackNameLeadingMargin),
            artistNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant:  -CONSTANTS.defaultMargin),
            artistNameLabel.topAnchor.constraint(greaterThanOrEqualTo: containerView.topAnchor, constant: CONSTANTS.defaultMargin),
            artistNameLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -CONSTANTS.defaultMargin),
            artistNameLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])

    }

    func updateData(_ uiModel: uiModel ) {
        self.artistNameLabel.text = uiModel.name
        self.albumArtImageView.sd_setImage(with: URL(string: uiModel.imageUrl))
    }


}
