//
//  SpotifyArtistToArtistMapper.swift
//  ArtistInfo
//
//  Created by Tonte Owuso on 13/02/2024.
//

import Foundation

// Class to convert Spotify models to generic models that are used in the rest of the codebase

class SpotifyArtistToArtistMapper {
    func map(_ input: SpotifyArtist) -> Artist {
        return Artist(
            followers: .init(href: input.followers?.href, total: input.followers?.total),
            genres: input.genres,
            href: input.href,
            id: input.id,
            images: input.images.map{ mapSpotifyImageToImage($0) },
            name: input.name,
            popularity: input.popularity
        )
    }

    private func mapSpotifyImageToImage(_ input: SpotifyArtist.Image) -> Artist.Image {
        return Artist.Image(height: input.height, url: input.url, width: input.width)
    }
}
