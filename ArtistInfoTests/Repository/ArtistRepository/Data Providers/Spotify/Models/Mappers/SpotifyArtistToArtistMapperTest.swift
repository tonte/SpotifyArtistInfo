//
//  SpotifyArtistToArtistMapperTest.swift
//  ArtistInfoTests
//
//  Created by Tonte Owuso on 14/02/2024.
//

import XCTest

@testable import ArtistInfo

final class SpotifyArtistToArtistMapperTest: XCTestCase {
    let mapper = SpotifyArtistToArtistMapper()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testMap() {
        // This tests if the mapper can successfully convert the SpotifyArtist model to an Artist model
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

        let artist = mapper.map(spotifyArtist)
        XCTAssert(artist.name == spotifyArtist.name)
        XCTAssert(artist.genres == spotifyArtist.genres)
        XCTAssert(artist.href == spotifyArtist.href)
        XCTAssert(artist.id == spotifyArtist.id)
        XCTAssert(artist.popularity == spotifyArtist.popularity)
    }


}
