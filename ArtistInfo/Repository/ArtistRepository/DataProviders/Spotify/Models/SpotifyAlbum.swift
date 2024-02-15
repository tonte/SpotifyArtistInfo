//
//  SpotifyAlbum.swift
//  ArtistInfo
//
//  Created by Tonte Owuso on 13/02/2024.
//

import Foundation
struct SpotifyAlbum: Codable {
    let albumType: String?
    let totalTracks: Int?
    let href, id: String
    let images: [Image]
    let name: String
    let releaseDate, releaseDatePrecision: String?
    let type, uri: String?
    let artists: [Artist]

    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case totalTracks = "total_tracks"
        case href, id, images, name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case type, uri, artists
    }
    struct Artist: Codable {
        let href, id, name, type: String
        let uri: String

        enum CodingKeys: String, CodingKey {
            case href, id, name, type, uri
        }
    }
    struct Image: Codable {
        let height: Int
        let url: String
        let width: Int
    }

}
