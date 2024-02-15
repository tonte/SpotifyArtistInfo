//
//  ArtistRepositoryTest.swift
//  ArtistInfoTests
//
//  Created by Tonte Owuso on 15/02/2024.
//

import XCTest
@testable import ArtistInfo

final class ArtistRepositoryTest: XCTestCase {
    let repository = ArtistRepository(dataProvider: MockSpotifyArtistRepository())

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchForArtist() async throws {
        let response = try await repository.searchForArtist(query: "test artist")
        XCTAssert(response.items.count > 0)
        XCTAssert(response.items.first!.name == "test artist")
    }

    func testGetArtistsDetails() async throws {
        let response = try await repository.getArtistDetails(id: "12345")
        XCTAssert(response.name == "test artist")
    }

    func testGetArtistTopTracks() async throws {
        let response = try await repository.getArtistTopTracks(id: "5432")
        XCTAssert(response.first!.name == "Big for your boots")
    }

}
