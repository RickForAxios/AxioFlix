//
//  CoreDataStack.swift
//  AxioFlix
//
//  Created by Rick Terrill on 5/26/18.
//  Copyright © 2018 Rick Terrill. All rights reserved.
//

import UIKit
import CoreData

class DataController: NSObject {
    static let sharedInstance = DataController()
    
    // PersistentContainer requires iOS 10
    var persistentContainer: NSPersistentContainer
    
    private override init() {
        self.persistentContainer = NSPersistentContainer(name: "Movies")
        self.persistentContainer.loadPersistentStores() { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }
    
    func addMovie(title: String, overview: String, popularity: Double, backdropPath: String, posterPath: String, releaseDate: Date, inContext context: NSManagedObjectContext) {
        
        let managedObject = NSEntityDescription.insertNewObject(forEntityName: "Movie", into: context)
        
        managedObject.setValue(title, forKey: "title")
        managedObject.setValue(overview, forKey: "overview")
        managedObject.setPrimitiveValue(Double(0), forKey: "popularity")
        managedObject.setValue("", forKey: "backdropPath")
        managedObject.setValue("", forKey: "posterPath")
        managedObject.setValue(Date(), forKey: "releaseDate")
    }
    
    func addMovies(movies: [MovieModel]) {
        self.persistentContainer.performBackgroundTask { context in
            movies.forEach({ (movie) in
                self.addMovie(title: movie.title, overview: movie.overview, popularity: movie.popularity, backdropPath: "", posterPath: "", releaseDate: Date(), inContext: context)
            })
            
            do {
                try context.save()
            } catch {
                print("Encountered an error while trying to save Movies to a CD Context: \(error)")
            }
        }
    }
}
