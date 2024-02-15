//
//  ArtistSearchResponse.swift
//  ArtistInfo
//
//  Created by Tonte Owuso on 12/02/2024.
//

import Foundation
struct ArtistSearchResponse: Codable {
    let href: String?
    let items: [Artist]
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: String?
    let total: Int?
}

