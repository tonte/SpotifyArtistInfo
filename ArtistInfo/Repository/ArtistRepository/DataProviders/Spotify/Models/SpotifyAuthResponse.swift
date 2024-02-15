//
//  SpotifyAuthResponse.swift
//  ArtistInfo
//
//  Created by Tonte Owuso on 12/02/2024.
//

import Foundation
struct SpotifyAuthResponse: Codable {
    let accessToken, tokenType: String
    let expiresIn: Int

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
    }
}
