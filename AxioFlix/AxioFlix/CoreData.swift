//
//  CoreDataStack.swift
//  AxioFlix
//
//  Created by Rick Terrill on 5/26/18.
//  Copyright © 2018 Rick Terrill. All rights reserved.
//

import UIKit
import CoreData

// CoreData helpers

func getPersistentContainer() -> NSPersistentContainer {
    return (UIApplication.shared.delegate as! AppDelegate).persistentContainer
}

func persistMovie(_ movie: MovieModel, inContext context: NSManagedObjectContext) {
    
    let managedObject = NSEntityDescription.insertNewObject(forEntityName: "Movie", into: context)
    
    managedObject.setValue(movie.title, forKey: "title")
    managedObject.setValue(movie.overview, forKey: "overview")
    managedObject.setPrimitiveValue(Double(0), forKey: "popularity")
    managedObject.setValue("", forKey: "backdropPath")
    managedObject.setValue("", forKey: "posterPath")
    managedObject.setValue(Date(), forKey: "releaseDate")
}

func persistMovies(_ movies: [MovieModel]) {
    DispatchQueue.main.async {
        getPersistentContainer().performBackgroundTask { context in
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
