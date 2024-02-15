//
//  ArtistRepository.swift
//  ArtistInfo
//
//  Created by Tonte Owuso on 12/02/2024.
//

import Foundation
protocol ArtistRepositoryProtocol {
    // This is a protocol for data providers. The idea is to make it easy to switch data providers if need be.
    // Currently, Spotify is the only data provider but if this has to be changed in future, all changes can be made here leaving
    // the rest of the codebase intact.

    func searchForArtist(query: String, offset: Int) async throws -> ArtistSearchResponse
    func getArtistDetails(id: String) async throws -> Artist
    func getArtistTopTracks(id: String) async throws -> [Track]
}

struct ArtistRepository: ArtistRepositoryProtocol {
    let dataProvider: ArtistRepositoryProtocol

    init(dataProvider: ArtistRepositoryProtocol) {
        self.dataProvider = dataProvider
    }

    func searchForArtist(query: String, offset: Int = 0) async throws -> ArtistSearchResponse {
        return try await dataProvider.searchForArtist(query: query, offset: offset)
    }

    func getArtistDetails(id: String) async throws -> Artist {
        return try await dataProvider.getArtistDetails(id: id)
    }

    func getArtistTopTracks(id: String) async throws -> [Track] {
        return try await dataProvider.getArtistTopTracks(id: id)
    }
}
