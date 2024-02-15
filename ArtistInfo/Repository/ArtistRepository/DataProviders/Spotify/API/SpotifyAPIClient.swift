//
//  SpotifyAPIClient.swift
//  ArtistInfo
//
//  Created by Tonte Owuso on 13/02/2024.
//

import Foundation
protocol SpotifyAPIClientProtocol {
    func authenticate() async throws
    func searchForArtist(query: String, offset: Int) async throws -> SpotifyArtistSearchResponse
    func getArtistDetails(id: String) async throws -> SpotifyArtist
    func getArtistTopTracks(id: String) async throws -> [SpotifyTrack]
}

class SpotifyAPIClient: SpotifyAPIClientProtocol {
    let networkClient: NetworkRepositoryProtocol

    // stores the accessToken here after authentication
    var accessToken: String?

    //JSON Encoders/Decoders
    var jsonDecoder: JSONDecoder = JSONDecoder()
    var jsonEncoder: JSONEncoder = JSONEncoder()

    init(networkClient: NetworkRepositoryProtocol) {
        self.networkClient = networkClient
    }

    internal func authenticate() async throws {
        
        // fetching spotify account credentials from info.plist
        guard let clientId = Bundle.main.object(forInfoDictionaryKey: "SPOTIFY_CLIENT_ID") as? String,
                let clientSecret = Bundle.main.object(forInfoDictionaryKey: "SPOTIFY_CLIENT_SECRET") as? String,
              !clientId.isEmpty, !clientSecret.isEmpty else {
            fatalError(" Please supply spotify account credentials in info.plist")
        }


        guard let url = URL.Spotify.authenticate.url() else { throw URLError(.badURL) }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        var requestBodyComponents = URLComponents()
        requestBodyComponents.queryItems = [
            URLQueryItem(name: "grant_type", value: "client_credentials"),
            URLQueryItem(name: "client_id", value: clientId),
            URLQueryItem(name: "client_secret", value: clientSecret)
        ]

        urlRequest.httpBody = requestBodyComponents.query?.data(using: .utf8)

        let data = try await networkClient.makeRequest(with: urlRequest)
        let authResponse = try jsonDecoder.decode(SpotifyAuthResponse.self, from: data)

        // store accessToken for subsequent calls
        self.accessToken = authResponse.accessToken
    }

    func searchForArtist(query: String, offset: Int = 20 ) async throws -> SpotifyArtistSearchResponse {
        guard accessToken != nil else {
            try await authenticate()
            return try await makeSearchCall(query: query, offset: offset)
        }
        return try await makeSearchCall(query: query, offset: offset)
    }

    private func makeSearchCall(query: String, offset: Int = 20) async throws -> SpotifyArtistSearchResponse {
        guard let url = URL.Spotify.search(query: query, type: "artist", limit: "20", offset: "\(offset)" ).url(), let urlRequest = createGETRequest(url: url) else  { throw URLError(.badURL) }
        let data = try await networkClient.makeRequest(with: urlRequest)
        let response = try jsonDecoder.decode(SpotifyArtistSearchResponse.self, from: data)
        return response
    }

    func getArtistDetails(id: String) async throws -> SpotifyArtist {
        guard accessToken != nil else {
            try await authenticate()
            return try await makeGetArtistDetailsCall(id: id)
        }
        return try await makeGetArtistDetailsCall(id: id)
    }

    private func makeGetArtistDetailsCall(id: String) async throws -> SpotifyArtist {
        guard let url = URL.Spotify.getArtist(id: id).url(),
              let urlRequest = createGETRequest(url: url) else  {
            throw URLError(.badURL)
        }
        let data = try await networkClient.makeRequest(with: urlRequest)
        let response = try jsonDecoder.decode(SpotifyArtist.self, from: data)
        return response
    }

    func getArtistTopTracks(id: String) async throws -> [SpotifyTrack] {
        guard accessToken != nil else {
            try await authenticate()
            return try await makeGetArtistTopTracksCall(id: id)
        }
        return try await makeGetArtistTopTracksCall(id: id)
    }

    private func makeGetArtistTopTracksCall(id: String) async throws -> [SpotifyTrack] {
        guard let url = URL.Spotify.getArtistTopTracks(id: id).url(),
              let urlRequest = createGETRequest(url: url) else  {
            throw URLError(.badURL)
        }
        let data = try await networkClient.makeRequest(with: urlRequest)
        let response = try jsonDecoder.decode(GetSpotifyTopTracksResponse.self, from: data)
        let tracks = response.tracks
        return tracks
    }

    private func createGETRequest(url: URL) -> URLRequest? {
        guard let accessToken else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        return urlRequest
    }
}
