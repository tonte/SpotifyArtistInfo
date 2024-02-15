//
//  Artist.swift
//  ArtistInfo
//
//  Created by Tonte Owuso on 12/02/2024.
//

import Foundation
struct Artist: Codable {
    let followers: Followers?
    let genres: [String]?
    let href: String
    let id: String
    let images: [Image]?
    let name: String
    let popularity: Int?

    // MARK: - Followers
    struct Followers: Codable {
        let href: String?
        let total: Int?
    }

    // MARK: - Image
    struct Image: Codable {
        let height: Int
        let url: String
        let width: Int
    }
}
