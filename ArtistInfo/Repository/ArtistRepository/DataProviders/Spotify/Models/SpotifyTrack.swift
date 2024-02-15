//
//  SpotifyTrack.swift
//  ArtistInfo
//
//  Created by Tonte Owuso on 13/02/2024.
//

import Foundation

// MARK: - Track
struct SpotifyTrack: Codable {
    let album: SpotifyAlbum
    let artists: [SpotifyAlbumArtist]
    let discNumber, durationMS: Int
    let explicit: Bool?
    let href: String?
    let id: String
    let name: String
    let popularity: Int
    let previewURL: String?
    let trackNumber: Int?
    let type: String?
    let uri: String?

    enum CodingKeys: String, CodingKey {
        case album
        case artists
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case explicit
        case href, id
        case name, popularity
        case previewURL = "preview_url"
        case trackNumber = "track_number"
        case type, uri
    }
    
    // MARK: - AlbumArtist
    struct SpotifyAlbumArtist: Codable {
        let href, id, name, type: String
        let uri: String

        enum CodingKeys: String, CodingKey {
            case href, id, name, type, uri
        }
    }


    // MARK: - Image
    struct Image: Codable {
        let url: String
        let height, width: Int
    }

    // MARK: - Followers
    struct Followers: Codable {
        let href: String
        let total: Int
    }
}
