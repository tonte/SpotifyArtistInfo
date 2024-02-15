//
//  URL+Helpers.swift
//  ArtistInfo
//
//  Created by Tonte Owuso on 12/02/2024.
//

import Foundation
extension URL {
    // URL builder for Spotify API endpoints
    enum Spotify {
        case authenticate
        case getArtist(id: String)
        case search(query: String, type: String, limit: String, offset: String)
        case getArtistTopTracks(id: String)

        func url() -> URL? {
            guard let baseURL = URL(string: "https://api.spotify.com/v1/") else { return nil }
            switch self {
            case .authenticate:
                return URL(string: "https://accounts.spotify.com/api/token")

            case .getArtist(let id):
                guard let artistsURL = URL(string: "artists/\(id)", relativeTo: baseURL),
                      let components = URLComponents(url: artistsURL, resolvingAgainstBaseURL: true) else { return nil }
                return components.url

            case .search(let query, let type, let limit, let offset):
                guard let searchURL = URL(string: "search", relativeTo: baseURL),
                      var components = URLComponents(url: searchURL, resolvingAgainstBaseURL: true) else { return nil }
                components.queryItems = [
                    URLQueryItem(name: "q", value: query),
                    URLQueryItem(name: "type", value: type),
                    URLQueryItem(name: "market", value: "GB"),
                    URLQueryItem(name: "limit", value: limit),
                    URLQueryItem(name: "offset", value: offset),
                ]
                return components.url

            case .getArtistTopTracks(id: let id):
                guard let tracksURL = URL(string: "artists/\(id)/top-tracks", relativeTo: baseURL),
                      var components = URLComponents(url: tracksURL, resolvingAgainstBaseURL: true) else { return nil }
                components.queryItems = [URLQueryItem(name: "country", value: "GB")]
                return components.url
            }
        }
    }
}
