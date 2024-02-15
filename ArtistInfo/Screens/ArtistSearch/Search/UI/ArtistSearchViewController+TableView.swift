//
//  ArtistSearchViewController+TableView.swift
//  ArtistInfo
//
//  Created by Tonte Owuso on 14/02/2024.
//

import Foundation
import UIKit

// MARK: - UITableViewDataSource

extension ArtistSearchViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let artist = artists[indexPath.row]
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: ArtistSearchTableViewCell.reuseIdentifier) as? ArtistSearchTableViewCell else {
            return UITableViewCell()
        }
        var imageUrl = ""
        if let image = artist.images?.last {
            imageUrl = image.url
        }
        tableViewCell.updateData(.init(name: artist.name, imageUrl: imageUrl))
        return tableViewCell
    }

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let artist = artists[indexPath.row]
        self.navigateToArtistDetails(artist: artist)
        return nil
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
