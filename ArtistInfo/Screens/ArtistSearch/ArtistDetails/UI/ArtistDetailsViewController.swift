//
//  ArtistDetailsViewController.swift
//  ArtistInfo
//
//  Created by Tonte Owuso on 13/02/2024.
//

import UIKit
import Combine

class ArtistDetailsViewController: UIViewController {
    
    /// ViewModel
    var viewModel: ArtistDetailsViewModel
    var cancellables: [AnyCancellable] = []

    // DataSource for TableView
    var tracks: [Track] = []

    init(viewModel: ArtistDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    var artistDetailsView: ArtistDetailsView = {
        let view = ArtistDetailsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDataSource()
        fetchArtistTopFiveTracks()
    }

    deinit {
        cancellables.removeAll()
    }

    func fetchArtistTopFiveTracks() {
        Task {
            do {
                try await viewModel.fetchTopFiveTracks()
            } catch {
                displayError(error)
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        self.view.addSubview(artistDetailsView)
        setConstraints()
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            artistDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            artistDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            artistDetailsView.topAnchor.constraint(equalTo: view.topAnchor),
            artistDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setupDataSource() {
        // listen for changes in data
        viewModel.$artist.receive(on: DispatchQueue.main)
            .sink(receiveValue: { artist in
                self.updateArtistDetails(artist)
            })
            .store(in: &cancellables)

        viewModel.$tracks.receive(on: DispatchQueue.main)
            .sink(receiveValue: { tracks in
                self.updateArtistTopTracks(tracks)
            })
            .store(in: &cancellables)
    }

    func updateArtistDetails(_ artist: Artist) {
        let name = artist.name
        var genre = ""
        if let genres = artist.genres {
            genre = genres.joined(separator: ", ")
        }
        var imageURL = ""
        if let artistImage = artist.images?.first {
            imageURL = artistImage.url
        }
        artistDetailsView.updateArtistDetails(
            .init(
                name: name,
                genre: genre,
                imageUrl: imageURL
            )
        )
    }

    func updateArtistTopTracks(_ tracks: [Track]) {
        self.tracks = tracks
        artistDetailsView.setTableView(delegate: self, dataSource: self)
        artistDetailsView.updateTopTracks()
    }

    func displayError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(.init(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
    }
}
