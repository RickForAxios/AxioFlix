//
//  Persistence.swift
//  AxioFlix
//
//  Created by Rick Terrill on 5/26/18.
//  Copyright © 2018 Rick Terrill. All rights reserved.
//

import UIKit
import CoreData

// CoreData handles persistence

func getPersistentContainer() -> NSPersistentContainer {
    return (UIApplication.shared.delegate as! AppDelegate).persistentContainer
}

func persistMovie(_ movie: MovieModel, inContext context: NSManagedObjectContext) {
    
    let managedObject = NSEntityDescription.insertNewObject(forEntityName: "Movie", into: context)
    
    managedObject.setPrimitiveValue(movie.id, forKey: "id")
    managedObject.setValue(movie.title, forKey: "title")
    managedObject.setValue(movie.overview, forKey: "overview")
    managedObject.setPrimitiveValue(movie.popularity, forKey: "popularity")
    managedObject.setValue("", forKey: "backdropPath")
    managedObject.setValue(movie.poster_path, forKey: "posterPath")
    managedObject.setValue(movie.release_date, forKey: "releaseDate")
}

// The main func that the API will use to persist results.
// Note that we could swap out CoreData without affecting the API layer
func persistMovies(_ movies: [MovieModel]) {
    DispatchQueue.main.async {
        getPersistentContainer().performBackgroundTask { context in
            
            // The CD model lists "id" as a constraint.
            // Setting overwrite below means any incoming movies that
            // we already have will simply be overwritten now
            context.mergePolicy = NSMergePolicy.overwrite
            
            movies.forEach({ (movie) in
                persistMovie(movie, inContext: context)
            })
            
            do {
                try context.save()
            } catch {
                print("Encountered an error while trying to save Movies to a CD Context: \(error)")
            }
        }
    }
}
