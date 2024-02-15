//
//  Track.swift
//  ArtistInfo
//
//  Created by Tonte Owuso on 13/02/2024.
//

import Foundation
struct Track: Codable {
    let id: String
    let durationMS : Int?
    let album: Album
    let name: String
    let popularity: Int?
    let trackNumber: Int?
    let artist: [Artist]
}
