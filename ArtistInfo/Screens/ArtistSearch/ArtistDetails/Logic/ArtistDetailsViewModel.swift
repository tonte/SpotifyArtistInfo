//
//  ArtistDetailsViewModel.swift
//  ArtistInfo
//
//  Created by Tonte Owuso on 13/02/2024.
//

import Foundation
import Combine

protocol ArtistDetailsViewModelProtocol {
    func fetchArtistDetails() async throws
    func fetchTopFiveTracks() async throws
}

class ArtistDetailsViewModel: ArtistDetailsViewModelProtocol {

    @Published var artist: Artist
    @Published var tracks: [Track] = []

    private var repository: ArtistRepositoryProtocol

    init(repository: ArtistRepositoryProtocol, artist: Artist) {
        self.repository = repository
        self.artist = artist
    }

    func fetchArtistDetails() async throws {
        artist = try await repository.getArtistDetails(id: artist.id)
    }

    func fetchTopFiveTracks() async throws {
        let results = try await repository.getArtistTopTracks(id: artist.id)
        // show only the first 5
        self.tracks = Array(results.prefix(5))
    }
}
