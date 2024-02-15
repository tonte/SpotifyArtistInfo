//
//  SpotifyAPIClientTest.swift
//  ArtistInfoTests
//
//  Created by Tonte Owuso on 15/02/2024.
//

import XCTest

@testable import ArtistInfo

final class SpotifyAPIClientTest: XCTestCase {
    var spotifyAPIClient = SpotifyAPIClient(networkClient: MockNetworkClient())

    override func setUpWithError() throws {
        // set accessToken so it doesn't go through the authentication process for each test case
        spotifyAPIClient.accessToken = "test"
    }

    func testAuthenticate() async throws {
        // check if it's able to fetch and store the accessToken succesfully

        // set accessToken to nil before the test so we can test authentication
        spotifyAPIClient.accessToken = nil

        // check if it's able to fetch and decode the mock json responses
        guard let networkClient = spotifyAPIClient.networkClient as? MockNetworkClient else { return }

        // set expected response in the mock network client so we can the correct json file back
        networkClient.expectedResponse = .authenticateSpotify

        // make authenticate call
        try await spotifyAPIClient.authenticate()

        // check if accessToken variable is populated, hence successful authentication
        XCTAssertNotNil(spotifyAPIClient.accessToken)
    }

    func testSearchForArtist() async throws {
        // check if it's able to fetch and decode the mock json responses
        guard let networkClient = spotifyAPIClient.networkClient as? MockNetworkClient else { return }

        // set expected response in the mock network client so we can the correct json file back
        networkClient.expectedResponse = .searchSpotify

        // call search function
        let response = try await spotifyAPIClient.searchForArtist(query: "Beyonce")

        // check if results were fetched succesfully
        let results = response.results

        XCTAssertNotNil(results)
        XCTAssert(results.items.count > 0)
        XCTAssert(results.items.first!.name == "Beyoncé")
    }

    func testGetArtistDetails() async throws {
        // check if it's able to fetch and decode the mock json response
        guard let networkClient = spotifyAPIClient.networkClient as? MockNetworkClient else { return }

        // set expected response in the mock network client so we can the correct json file back
        networkClient.expectedResponse = .getArtistFromSpotify
        let response = try await spotifyAPIClient.getArtistDetails(id: "testID")
        XCTAssert(response.name == "King Promise")
    }

    func testGetArtistTopTracks() async throws {
        // check if it's able to fetch and decode the mock json response
        guard let networkClient = spotifyAPIClient.networkClient as? MockNetworkClient else { return }

        // set expected response in the mock network client so we can the correct json file back
        networkClient.expectedResponse = .topTracksFromSpotify

        // fetch top tracks
        let response = try await spotifyAPIClient.getArtistTopTracks(id: "testID")

        // verify if tracks were fetched succesfully
        XCTAssertNotNil(response.first)
        XCTAssert(response.first!.name == "Crazy In Love (feat. Jay-Z)")
    }

}

