//
//  MovieTVCDataSource.swift
//  AxioFlix
//
//  Created by Rick Terrill on 5/28/18.
//  Copyright © 2018 Rick Terrill. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher

extension MoviesTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        cell.tableViewController = self
        
        if let dic = self.fetchedResultsController.object(at: indexPath) as? NSManagedObject {
            // title
            if let movieTitle = dic.value(forKey: "title") as? String {
                cell.titleLabel.text = movieTitle
            }
            
            // poster image
            if let posterPath = dic.value(forKey: "posterPath") as? String, let posterUrl = Api.sharedInstance.getImageUrl(for: posterPath) {
                if (posterPath.trimmingCharacters(in: .whitespaces)) != "" {
                    
                    // Kingfisher smartly caches the images. They will be available offline.
                    cell.posterImageView.kf.setImage(with: posterUrl)
                }
            }
            
            // release date
            if let releaseDate = dic.value(forKey: "releaseDate") as? Date {
                cell.releaseDateLabel.text = self.dateFormatter.string(from: releaseDate)
            }
            
            // popularity score
            if let popularity = dic.value(forKey: "popularity") as? Double
            {
                cell.popularityLabel.text = String(Int(round(popularity)))
            }
            
            // overview
            if let overview = dic.value(forKey: "overview") as? String {
                cell.overviewLabel.text = overview
                if overview.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                    cell.showHideButton.isEnabled = false
                } else {
                    cell.showHideButton.isEnabled = true
                }
            } else {
                cell.showHideButton.isEnabled = false
            }
            
            // movie id
            if let movieId = dic.value(forKey: "id") as? Int64 {
                cell.movieId = movieId
                
                if self.openMovieIds.contains(movieId) {
                    cell.snapOpen()
                }
            }            
        }
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = self.fetchedResultsController.sections else {
            fatalError("No sections in fetchedResultsController")
        }
        
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = self.fetchedResultsController.sections else {
            fatalError("No sections in fetchedResultsController")
        }
        
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
}
