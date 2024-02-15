//
//  ArtistDetailsViewController+TableView.swift
//  ArtistInfo
//
//  Created by Tonte Owuso on 14/02/2024.
//

import Foundation
import UIKit

extension ArtistDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let track = tracks[indexPath.row]

        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: ArtistTrackTableViewCell.reuseIdentifier) as? ArtistTrackTableViewCell else {
            return UITableViewCell()
        }

        var duration = ""
        var imageUrl = ""
        if let image = track.album.images.first {
            imageUrl = image.url
        }
        if let time = convertMillisecondsToReadableFormat(track.durationMS) {
            duration = time
        }
        tableViewCell.updateData(.init(name: track.name, duration: duration, imageUrl: imageUrl))
        return tableViewCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: UITableViewHeaderFooterView = UITableViewHeaderFooterView()
        var content = UIListContentConfiguration.prominentInsetGroupedHeader()
        content.textProperties.font = .preferredFont(forTextStyle: .subheadline)
        content.text = "Top Tracks"
        headerView.contentConfiguration = content
        return headerView
    }

    private func convertMillisecondsToReadableFormat(_ milliseconds: Int?) -> String? {
        guard let milliseconds else { return nil }
        let seconds: Double = Double ( milliseconds/1000 )
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        guard let formattedString = formatter.string(from: TimeInterval(seconds)) else  { return nil}
        return formattedString
    }

}
