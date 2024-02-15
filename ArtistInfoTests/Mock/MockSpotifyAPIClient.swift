//
//  MockSpotifyAPIClient.swift
//  ArtistInfoTests
//
//  Created by Tonte Owuso on 15/02/2024.
//

import Foundation
@testable import ArtistInfo

class MockSpotifyAPIClient: SpotifyAPIClientProtocol {
    // model mocks
    let spotifyArtist = SpotifyArtist(
        externalUrls: nil,
        followers: nil,
        genres: ["pop", "folk"],
        href: "www.google.com",
        id: "3310",
        images: [
            .init(height: 90, url: "web", width: 200)
        ],
        name: "test artist",
        popularity: 98,
        type: "artist",
        uri: ""
    )

    let spotifyTrack = SpotifyTrack(
        album: .init(
            albumType: "soul",
            totalTracks: 20,
            href: "web",
            id: "9319312",
            images: [],
            name: "TrapSoul",
            releaseDate: "2024",
            releaseDatePrecision: "day",
            type: "album",
            uri: "tracks/web",
            artists: []
        ),
        artists: [],
        discNumber: 1,
        durationMS: 1970,
        explicit: false,
        href: "23b2",
        id: "723823",
        name: "Miseducation",
        popularity: 99,
        previewURL: nil,
        trackNumber: 4,
        type: "soul",
        uri: "/web/open"
    )


    func authenticate() async throws {}

    func searchForArtist(query: String, offset: Int) async throws -> ArtistInfo.SpotifyArtistSearchResponse {
        return SpotifyArtistSearchResponse(results: .init(href: "web/test/second", items: [spotifyArtist], limit: 20, next: "", offset: 0, previous: nil, total: 100))
    }

    func getArtistDetails(id: String) async throws -> ArtistInfo.SpotifyArtist {
        return spotifyArtist
    }

    func getArtistTopTracks(id: String) async throws -> [ArtistInfo.SpotifyTrack] {

        return [spotifyTrack]
    }
}
