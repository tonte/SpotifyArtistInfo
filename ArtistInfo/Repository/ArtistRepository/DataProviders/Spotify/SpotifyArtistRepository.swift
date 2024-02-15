//
//  SpotifyArtistRepository.swift
//  ArtistInfo
//
//  Created by Tonte Owuso on 12/02/2024.
//

import Foundation

// The idea for this is that we should be able to switch providers without breaking any code as long as they conform to
// ArtistRepositoryProtocol

class SpotifyArtistRepository: ArtistRepositoryProtocol {
    let client: SpotifyAPIClientProtocol
    var spotifyArtistToArtistMapper = SpotifyArtistToArtistMapper()
    var spotifyTrackToTrackMapper = SpotifyTrackToTrackMapper()

    init(client: SpotifyAPIClientProtocol) {
        self.client = client
    }

    func searchForArtist(query: String, offset: Int = 0) async throws -> ArtistSearchResponse {
        let data = try await client.searchForArtist(query: query, offset: offset)
        let results = ArtistSearchResponse(
            href: data.results.href,
            items: data.results.items.map { spotifyArtistToArtistMapper.map($0) },
            limit: data.results.limit,
            next: data.results.next,
            offset: data.results.offset,
            previous: data.results.previous,
            total: data.results.total
        )
        return results
    }
    
    func getArtistDetails(id: String) async throws -> Artist {
        let data = try await client.getArtistDetails(id: id)
        let results = spotifyArtistToArtistMapper.map(data)
        return results
    }
    
    func getArtistTopTracks(id: String) async throws -> [Track] {
        let data = try await client.getArtistTopTracks(id: id)
        let results = data.map{ spotifyTrackToTrackMapper.map($0) }
        return results
    }

}
