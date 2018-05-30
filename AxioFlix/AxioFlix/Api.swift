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
    let poster_path: String
    let popularity: Double
    let id: Int64
}

struct MoviesModel: Codable {
    let page: Int
    let results: [MovieModel]
}

struct TmdbImagesConfiguration: Codable {
    let secure_base_url: String
    let poster_sizes: [String]
}

struct TmdbConfiguration: Codable {
    let images: TmdbImagesConfiguration
}

class Api {
    static let sharedInstance = Api()
    private let decoder = JSONDecoder()
    private var imagesBaseUrl: String = "https://image.tmdb.org/t/p"
    private var posterSizes: [String] = ["w92"]
    private var configLoadDate = Date(timeIntervalSince1970: 0)
    
    func refresh() {
        self.fetchConfiguration { (didLoad) in
            if didLoad {
                if let apiUrl = self.makeDiscoverUrl() {
                    URLSession.shared.dataTask(with: apiUrl) { (data, response, error) in
                        //                print("Api done")
                        if let e = error {
                            // TODO: do something appropriate with this error, like send it to a canary monitor
                            print("Got an error when hitting the API: \(e)")
                        } else if let movieData = data {
                            if let movies = try? self.decoder.decode(MoviesModel.self, from: movieData) {
                                //                        print("decoded movies")
                                
                                persistMovies(movies.results)
                            } else {
                                print("couldn't decode movie JSON")
                            }
                        }
                    }.resume()
                }
            }
        }
    }
    
    func getImageUrl(for imagePath: String) -> URL? {
        let imageUrl = URL(string: self.imagesBaseUrl)?.appendingPathComponent("w92").appendingPathComponent(imagePath)
        
        return imageUrl
    }
    
    private func makeDiscoverUrl() -> URL? {
        var urlComponents = URLComponents(string: "\(TmdbBaseUrl)\(TmdbDiscoverEndpoint)")!
        
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
    
    private func fetchConfiguration(_ callback: @escaping (Bool) -> ()) {
        // don't refresh the
        guard self.configLoadDate.timeIntervalSinceNow < (TmdbConfigTimeout * -1) else {
            callback(true)
            return
        }
        
        var urlComponents = URLComponents(string: "\(TmdbBaseUrl)\(TmdbConfigEndpoint)")!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: TmdbApiKey)
        ]
        
        URLSession.shared.dataTask(with: urlComponents.url!) { (data, response, error) in
            if let e = error {
                // we would do some canary logging here because it might mean the API is down
                print("got an error from the API: \(e)")
                
                callback(false)
            } else if let configData = data {
                if let config = try? self.decoder.decode(TmdbConfiguration.self, from: configData) {
                    self.imagesBaseUrl = config.images.secure_base_url
                    self.posterSizes = config.images.poster_sizes
                    self.configLoadDate = Date()
                    
                    callback(true)
                } else {
                    callback(false)
                }
            }
        }.resume()
    }
}
