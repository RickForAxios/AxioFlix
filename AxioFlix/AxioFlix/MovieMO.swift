//
//  MovieMO.swift
//  AxioFlix
//
//  Created by Rick Terrill on 5/27/18.
//  Copyright © 2018 Rick Terrill. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class MovieMO: NSManagedObject {
    
    @NSManaged var title: String?
    @NSManaged var overview: String?
//    @NSManaged var popularity: Double?
    @NSManaged var backdropPath: String?
    @NSManaged var releaseDate: Date?
    
}
