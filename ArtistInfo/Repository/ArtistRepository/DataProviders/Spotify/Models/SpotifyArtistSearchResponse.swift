//
//  ArtistSearchResponse.swift
//  ArtistInfo
//
//  Created by Tonte Owuso on 11/02/2024.
//

import Foundation

struct SpotifyArtistSearchResponse: Codable {
    let results: SpotifyArtistSearchResults

    enum CodingKeys: String, CodingKey {
        case results = "artists"
    }
}

struct SpotifyArtistSearchResults: Codable {
    let href: String
    let items: [SpotifyArtist]
    let limit: Int
    let next: String
    let offset: Int
    let previous: String?
    let total: Int
}
