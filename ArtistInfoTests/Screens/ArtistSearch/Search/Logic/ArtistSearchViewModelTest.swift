//
//  ArtistSearchViewModelTest.swift
//  ArtistInfoTests
//
//  Created by Tonte Owuso on 15/02/2024.
//

import XCTest

@testable import ArtistInfo

final class ArtistSearchViewModelTest: XCTestCase {
    var viewModel = ArtistSearchViewModel(repository: MockArtistRepository())

    func testSearch() async throws {
        // call search function
        try await viewModel.search(query: "The Cure")
        // check if search results have been populated succesfuly
        XCTAssert(viewModel.artists.count > 0)
    }

    func testCancelSearch() {
        // populate search results
        let mockArtist = MockArtistRepository().mockArtist
        viewModel.artists = [mockArtist]

        // cancel search
        viewModel.cancelSearch()

        // check if search results are empty
        XCTAssert(viewModel.artists.isEmpty)
    }
}
