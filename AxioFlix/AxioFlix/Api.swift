//
//  Api.swift
//  AxioFlix
//
//  Created by Rick Terrill on 5/26/18.
//  Copyright © 2018 Rick Terrill. All rights reserved.
//

import Foundation

// Simple model of the TMDb data.
// This makes it simple to go from JSON to Swift,
// and then to CoreData
struct MovieModel: Codable {
    let title: String
    let overview: String
    let popularity: Double
    let id: Int
}

struct MoviesModel: Codable {
    let page: Int
    let results: [MovieModel]
}

class Api {
    static let sharedInstance = Api()
    private let decoder = JSONDecoder()
    
    func refresh() {
        if let apiUrl = self.getURL() {
            URLSession.shared.dataTask(with: apiUrl) { (data, response, error) in
                print("Api done")
                if let e = error {
                    // TODO: do something appropriate with this error
                    print("Got an error when hitting the API: \(e)")
                } else if let movieData = data {
                    if let movies = try? self.decoder.decode(MoviesModel.self, from: movieData) {
                        print("decoded movies")
                        
                        DataController.sharedInstance.addMovies(movies: movies.results)
                    } else {
                        print("couldn't decode movie JSON")
                    }
                }
            }.resume()
        }
    }
    
    private func getURL() -> URL? {
        var urlComponents = URLComponents(string: TmdbApiUrl)!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: TmdbApiKey),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "sort_by", value: "popularity.desc"),
            URLQueryItem(name: "include_adult", value: String(false)),
            URLQueryItem(name: "include_video", value: String(false)),
            URLQueryItem(name: "page", value: String(1)),
            URLQueryItem(name: "primary_release_year", value: String(2016))
        ];
        
        return urlComponents.url
    }
}
