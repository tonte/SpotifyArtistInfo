//
//  ArtistSearchViewModel.swift
//  ArtistInfo
//
//  Created by Tonte Owuso on 13/02/2024.
//

import Foundation
import Combine

protocol ArtistSearchViewModelProtocol {
    func search(query: String) async throws 
    func cancelSearch()
}

class ArtistSearchViewModel: ObservableObject, ArtistSearchViewModelProtocol {

    private var repository: ArtistRepositoryProtocol
    @Published var artists: [Artist] = []

    init(repository: ArtistRepositoryProtocol) {
        self.repository = repository
    }

    func search(query: String) async throws {
        self.artists = try await repository.searchForArtist(query: query, offset: 0).items
    }

    func cancelSearch() {
        self.artists = []
    }

}
