//
//  MoviesTableViewController.swift
//  AxioFlix
//
//  Created by Rick Terrill on 5/26/18.
//  Copyright © 2018 Rick Terrill. All rights reserved.
//

import UIKit
import CoreData


// NOTE: See Extension files for Table DataSource and NSFetchedResultsControllerDelegate

class MoviesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var dateFormatter:DateFormatter!
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    var openMovieIds = Set<Int64>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateStyle = .medium
        
        Api.sharedInstance.refresh()
        
        self.initializeFetchedResultsController()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeFetchedResultsController() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        let defaultSort = NSSortDescriptor(key: DefaultSortField, ascending: false)
        request.sortDescriptors = [defaultSort]
        
        let moc = getPersistentContainer().viewContext
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        self.fetchedResultsController.delegate = self
        
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }

    // MARK: - Table view data source

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
