//
//  ArtistSearchNavigationController.swift
//  ArtistInfo
//
//  Created by Tonte Owuso on 13/02/2024.
//

import Foundation
import UIKit

class ArtistSearchCoordinator: UINavigationController {

    // Coordinator serves as the entry point for the UI and handles Dependency Injection

    // Dependencies
    private let artistRepository: ArtistRepositoryProtocol = ArtistRepository(dataProvider: SpotifyArtistRepository(client: SpotifyAPIClient(networkClient: NetworkRepository())))

    enum screen {
        case search
        case artistSearchDetails(artist: Artist)
    }

    func createViewController(_ screen: screen) -> UIViewController{
        switch screen {
        case .search:
            return ArtistSearchViewController(viewModel: .init(repository: artistRepository))
        case .artistSearchDetails (let artist):
            return ArtistDetailsViewController(viewModel: .init(repository: artistRepository, artist: artist))
        }
    }

    func navigateTo(_ screen: screen){
        if viewControllers.isEmpty {
            viewControllers = [createViewController(screen)]
        } else {
            DispatchQueue.main.async {
                let viewController = self.createViewController(screen)
                viewController.modalPresentationStyle = .fullScreen
                self.pushViewController(viewController, animated: true)
            }
        }

    }

}
