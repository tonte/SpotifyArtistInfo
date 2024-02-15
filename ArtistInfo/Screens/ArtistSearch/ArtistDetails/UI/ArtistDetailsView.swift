//
//  ArtistDetailsView.swift
//  ArtistInfo
//
//  Created by Tonte Owuso on 13/02/2024.
//

import UIKit
import SDWebImage

class ArtistDetailsView: UIView {

    struct uiModel {
        let name: String
        let genre: String
        let imageUrl: String
    }

    struct CONSTANTS {
        static let leadingMargin: CGFloat = 10.0
        static let trailingMargin: CGFloat = -10.0
        static let imageHeight: CGFloat = 300.0
    }

    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()



    private let containerScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        return activityIndicator
    }()

    private let artistImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = .zero
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .preferredFont(forTextStyle: .extraLargeTitle)
        return titleLabel
    }()

    private let genreLabel: UILabel = {
        let genreLabel = UILabel()
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        genreLabel.numberOfLines = .zero
        genreLabel.font = .preferredFont(forTextStyle: .caption1)
        return genreLabel
    }()

    private let topTracksTableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.isUserInteractionEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.register(
            ArtistTrackTableViewCell.self,
            forCellReuseIdentifier: ArtistTrackTableViewCell.reuseIdentifier
        )
        tableView.setContentHuggingPriority(.defaultLow, for: .vertical)
        return tableView
    }()

    private var topTracksTableViewHeightConstraint: NSLayoutConstraint = .init()

    init() {
        super.init(frame: CGRect())
        self.createViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createViews() {
        backgroundColor = .systemBackground
        self.addSubview(containerScrollView)
        containerScrollView.addSubview(containerStackView)
        [artistImageView, titleLabel, genreLabel,topTracksTableView].forEach(containerStackView.addArrangedSubview(_:))
        containerStackView.setCustomSpacing(20, after: artistImageView)
        containerStackView.setCustomSpacing(20, after: genreLabel)
        self.addSubview(activityIndicator)
        setConstraints()
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            containerScrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            containerScrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            containerScrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            containerScrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: containerScrollView.leadingAnchor, constant: CONSTANTS.leadingMargin),
            containerStackView.trailingAnchor.constraint(equalTo: containerScrollView.trailingAnchor, constant: CONSTANTS.leadingMargin),
            containerStackView.centerXAnchor.constraint(equalTo: containerScrollView.centerXAnchor),
            containerStackView.topAnchor.constraint(equalTo: containerScrollView.topAnchor),
            containerStackView.bottomAnchor.constraint(lessThanOrEqualTo: containerScrollView.bottomAnchor, constant: -CONSTANTS.leadingMargin)
        ])

        topTracksTableViewHeightConstraint = topTracksTableView.heightAnchor.constraint(equalToConstant: .zero)
        topTracksTableViewHeightConstraint.isActive = true

        NSLayoutConstraint.activate([
            artistImageView.leadingAnchor.constraint(equalTo: containerStackView.leadingAnchor),
            artistImageView.trailingAnchor.constraint(equalTo: containerStackView.trailingAnchor),
            artistImageView.heightAnchor.constraint(equalToConstant: CONSTANTS.imageHeight)
        ])

    }


    func updateArtistDetails(_ model: uiModel) {
        titleLabel.text = model.name
        genreLabel.text = model.genre
        artistImageView.sd_setImage(with: URL(string: model.imageUrl))
        activityIndicator.stopAnimating()
    }

    func updateTopTracks() {
        topTracksTableView.reloadData()

        // since the tableview is in a stack view we need to update it's height constraint
        topTracksTableView.layoutIfNeeded()
        let height = topTracksTableView.contentSize.height
        topTracksTableViewHeightConstraint.constant = height
        topTracksTableViewHeightConstraint.isActive = true
        setNeedsLayout()
        layoutSubviews()

    }

    func setTableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        topTracksTableView.delegate = delegate
        topTracksTableView.dataSource = dataSource
    }
}
