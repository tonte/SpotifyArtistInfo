//
//  ArtistDetailsViewModelTest.swift
//  ArtistInfoTests
//
//  Created by Tonte Owuso on 15/02/2024.
//

import XCTest
import Foundation

@testable import ArtistInfo

final class ArtistDetailsViewModelTest: XCTestCase {
    var viewModel = ArtistDetailsViewModel(
        repository: MockArtistRepository(),
        artist: MockArtistRepository().mockArtist
    )

    func testfetchTopFiveTracks() async throws {
        // fetch top five tracks
        try await viewModel.fetchTopFiveTracks()

        // check if top five tracks have been fetched
        XCTAssert(viewModel.tracks.count > 0)
    }




}
