//
//  SpotifyTrackToTrackMapper.swift
//  ArtistInfoTests
//
//  Created by Tonte Owuso on 15/02/2024.
//

import XCTest

@testable import ArtistInfo

final class SpotifyTrackToTrackMapperTest: XCTestCase {
    let mapper = SpotifyTrackToTrackMapper()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }


    func testMap() {
        // This tests if the mapper can successfully convert the SpotifyTrack model to a Track model
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


        let track = mapper.map(spotifyTrack)
        XCTAssert(track.name == spotifyTrack.name)
        XCTAssert(track.trackNumber == spotifyTrack.trackNumber)
        XCTAssert(track.durationMS == spotifyTrack.durationMS)
        XCTAssert(track.popularity == spotifyTrack.popularity)
        XCTAssert(track.id == spotifyTrack.id)
    }


}

