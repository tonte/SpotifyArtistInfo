//
//  MockNetworkClient.swift
//  ArtistInfoTests
//
//  Created by Tonte Owuso on 15/02/2024.
//

import XCTest

@testable import ArtistInfo

class MockNetworkClient: NetworkRepositoryProtocol {
    // This is a mock Network Client that's used for unit testing

    // Specify which type of response you want to retrieve for each call. JSON files of responses are in the MockResponses folder
    
    enum ResponseType {
        case authenticateSpotify
        case getArtistFromSpotify
        case searchSpotify
        case topTracksFromSpotify

        func json() -> String {
            switch self {
            case .authenticateSpotify:
                return "spotify-authenticate-response"
            case .getArtistFromSpotify:
                return "spotify-get-artist-response"
            case .searchSpotify:
                return "spotify-search-response"
            case .topTracksFromSpotify:
                return "spotify-top-tracks-response"
            }
        }
    }

    var expectedResponse: ResponseType?

    func makeRequest(with urlRequest: URLRequest) async throws -> Data {
        guard let expectedResponse else {
            fatalError("Did not specify expected response")
        }
        guard let path = Bundle.main.path(forResource: expectedResponse.json(), ofType: "json") else {
            throw SessionError.serverError
        }
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        return data
    }
}
