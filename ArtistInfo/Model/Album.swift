//
//  Album.swift
//  ArtistInfo
//
//  Created by Tonte Owuso on 13/02/2024.
//

import Foundation
struct Album: Codable {
    let href, id: String
    let images: [Image]
    let name: String
    let releaseDate: String?
    let artists: [Artist]

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
