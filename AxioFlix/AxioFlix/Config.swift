//
//  Config.swift
//  AxioFlix
//
//  Created by Rick Terrill on 5/26/18.
//  Copyright © 2018 Rick Terrill. All rights reserved.
//

import Foundation

// We default to sorting by Popularity. A good enhancement would be to let the user sort by other fields.
let DefaultSortField = "popularity"

// API constants
let TmdbBaseUrl = "https://api.themoviedb.org/3"
let TmdbDiscoverEndpoint = "/discover/movie"
let TmdbConfigEndpoint = "/configuration"
let TmdbApiKey = "1821c6b6049945b0e08619035590d15b"
let TmdbConfigTimeout:TimeInterval = 3600
let TmdbReleaseYear: UInt = 2016
// changing the page and re-running the app will bring in additional results. Try 100 for a movie with no poster or overview
let TmdbMoviesPage: Int = 1
