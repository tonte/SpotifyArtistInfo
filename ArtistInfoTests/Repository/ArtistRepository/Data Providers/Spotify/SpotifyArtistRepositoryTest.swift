//
//  SpotifyArtistRepositoryTest.swift
//  ArtistInfoTests
//
//  Created by Tonte Owuso on 15/02/2024.
//

import XCTest

@testable import ArtistInfo

final class SpotifyArtistRepositoryTest: XCTestCase {
    let repository = SpotifyArtistRepository(client: MockSpotifyAPIClient())

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchForArtist() async throws {
        // check if MockSpotifyAPIClient returns mock data succesfully
        let response = try await repository.searchForArtist(query: "test artist")
        XCTAssert(response.items.count > 0)
        XCTAssert(response.items.first!.name == "test artist")
    }

    func testGetArtistDetails() async throws {
        // check if MockSpotifyAPIClient returns mock data succesfully
        let response = try await repository.getArtistDetails(id: "12328232")
        XCTAssert(response.name == "test artist")
    }

    func testGetArtistTopTracks() async throws {
        // check if MockSpotifyAPIClient returns mock data succesfully
        let response = try await repository.getArtistTopTracks(id: "123232")
        XCTAssert(response.count > 0)
        XCTAssert(response.first!.name == "Miseducation")
    }

}
