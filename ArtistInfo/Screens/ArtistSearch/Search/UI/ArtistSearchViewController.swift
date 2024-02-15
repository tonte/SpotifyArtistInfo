//
//  ArtistSearchViewController.swift
//  ArtistInfo
//
//  Created by Tonte Owuso on 13/02/2024.
//

import UIKit
import Combine
import SDWebImage
class ArtistSearchViewController: UITableViewController {

    /// Search controller to help us with filtering.
    var searchController: UISearchController!

    /// Data model for the table view.
    var artists: [Artist] = []

    /// ViewModel for updating table view source
    var viewModel: ArtistSearchViewModel?
    var cancellables: [AnyCancellable] = []

    init(viewModel: ArtistSearchViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupDataSource() {
        tableView.register(
            ArtistSearchTableViewCell.self,
            forCellReuseIdentifier: ArtistSearchTableViewCell.reuseIdentifier
        )

        // listen for changes
        viewModel?.$artists.receive(on: DispatchQueue.main)
            .sink(receiveValue: { artists in
                self.artists = artists
                self.tableView.dataSource = self
                self.tableView.reloadData()
            })
            .store(in: &cancellables)
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupDataSource()

        // Create search controller
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.searchTextField.placeholder = NSLocalizedString("Search for an artist", comment: "")
        searchController.searchBar.returnKeyType = .search

        // Place the search bar in the navigation bar.
        navigationItem.searchController = searchController

        // Make the search bar always visible.
        navigationItem.hidesSearchBarWhenScrolling = false


        // Monitor when the search button is tapped, and start/end editing.
        searchController.searchBar.delegate = self

        // Remove table view separators
        tableView.separatorStyle = .none
    }

    deinit {
        cancellables.removeAll()
    }

}

// MARK: - UISearchBarDelegate

extension ArtistSearchViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.isEmpty {
            artists.removeAll()
            viewModel?.cancelSearch()
        } else {
            Task {
                do {
                    guard let searchText = searchBar.text else { return }
                    try await viewModel?.search(query: searchText)
                } catch {
                    // This search is performed passively whenever the user enters text so there is no need to show the error to the user
                }
            }
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        cancelSearch()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // User tapped the Done button in the keyboard.
        if searchBar.text!.isEmpty {
            cancelSearch()
        } else {
            Task {
                do {
                    guard let searchText = searchBar.text else { return }
                    try await viewModel?.search(query: searchText)
                } catch {
                    searchBar.text = ""
                    self.displayError(error)

                }
            }
        }
    }

    func displayError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(.init(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
    }

    func cancelSearch() {
        artists.removeAll()
        viewModel?.cancelSearch()
        tableView.reloadData()
    }

    func navigateToArtistDetails(artist: Artist) {
        if let navigationController = navigationController as? ArtistSearchCoordinator {
            navigationController.navigateTo(.artistSearchDetails(artist: artist))
        }
    }
}
