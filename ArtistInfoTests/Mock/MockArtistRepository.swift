//
//  MockArtistRepository.swift
//  ArtistInfoTests
//
//  Created by Tonte Owuso on 15/02/2024.
//

import Foundation
@testable import ArtistInfo

class MockArtistRepository: ArtistRepositoryProtocol {

    let mockArtist = ArtistInfo.Artist(
        followers: nil,
        genres: ["afrobeats", "folk", "trap", "grime"],
        href: "music/web",
        id: "34567890",
        images: [],
        name: "test artist",
        popularity: 78
    )

    let mockTrack = ArtistInfo.Track(
        id: "324565",
        durationMS: 19928,
        album: .init(
            href: "link",
            id: "232131",
            images: [],
            name: "Hard Truth",
            releaseDate: nil,
            artists: []
        ),
        name: "Big for your boots",
        popularity: 98,
        trackNumber: 2,
        artist: []
    )


    func searchForArtist(query: String, offset: Int) async throws -> ArtistInfo.ArtistSearchResponse {
        return .init(
            href: "test link",
            items: [mockArtist],
            limit: 50,
            next: nil,
            offset: 0,
            previous: nil,
            total: 20
        )
    }

    func getArtistDetails(id: String) async throws -> ArtistInfo.Artist {
        return mockArtist
    }

    func getArtistTopTracks(id: String) async throws -> [ArtistInfo.Track] {
        return [mockTrack]
    }
}
