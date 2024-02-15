//
//  SpotifyTrackToTrackMapper.swift
//  ArtistInfo
//
//  Created by Tonte Owuso on 13/02/2024.
//

import Foundation

// class to convert Spotify models to generic models that are used in the rest of the codebase

class SpotifyTrackToTrackMapper {
    private let spotifyArtistToArtistMapper = SpotifyArtistToArtistMapper()
    func map(_ input: SpotifyTrack) -> Track {
        let album = input.album
        return Track(
            id: input.id,
            durationMS: input.durationMS,
            album: .init(
                href: album.href,
                id: album.id,
                images: album.images.map { Album.Image(height: $0.height, url: $0.url, width: $0.width) },
                name: album.name,
                releaseDate: album.releaseDate,
                artists: album.artists.map { Album.Artist(href: $0.href, id: $0.id, name: $0.name, type: $0.type, uri: $0.uri) }
            ),
            name: input.name,
            popularity: input.popularity,
            trackNumber: input.trackNumber, 
            artist: input.artists.map { spotifyAlbumArtist in
                return Artist(followers: nil, genres: nil, href: spotifyAlbumArtist.href, id: spotifyAlbumArtist.id, images: nil, name: spotifyAlbumArtist.name, popularity: nil)
            }
        )
    }
}
