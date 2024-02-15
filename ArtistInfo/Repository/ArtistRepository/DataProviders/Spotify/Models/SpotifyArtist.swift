//
//  Artist.swift
//  ArtistInfo
//
//  Created by Tonte Owuso on 11/02/2024.
//

import Foundation
struct SpotifyArtist: Codable {
    let externalUrls: ExternalUrls?
    let followers: Followers?
    let genres: [String]
    let href: String
    let id: String
    let images: [Image]
    let name: String
    let popularity: Int
    let type: String
    let uri: String

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case followers, genres, href, id, images, name, popularity, type, uri
    }

    // MARK: - ExternalUrls
    struct ExternalUrls: Codable {
        let spotify: String
    }

    // MARK: - Followers
    struct Followers: Codable {
        let href: String?
        let total: Int
    }

    // MARK: - Image
    struct Image: Codable {
        let height: Int
        let url: String
        let width: Int
    }
}
