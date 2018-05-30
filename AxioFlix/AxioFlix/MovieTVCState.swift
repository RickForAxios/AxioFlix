//
//  MovieTVCState.swift
//  AxioFlix
//
//  Created by Rick Terrill on 5/30/18.
//  Copyright © 2018 Rick Terrill. All rights reserved.
//

import UIKit

extension MoviesTableViewController {
    func setMovie(movieId: Int64, isOpen: Bool) {
        if isOpen {
            self.openMovieIds.insert(movieId)
        } else {
            self.openMovieIds.remove(movieId)
        }
    }
}
