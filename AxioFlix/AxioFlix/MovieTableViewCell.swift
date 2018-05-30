//
//  MovieTableViewCell.swift
//  AxioFlix
//
//  Created by Rick Terrill on 5/28/18.
//  Copyright © 2018 Rick Terrill. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var showHideButton: UIButton!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewContainer: UIView! {
        didSet {
            // start out with the overview hidden
            overviewContainer.isHidden = true
        }
    }
    
    // a convenient way to talk to this cell's TVC
    weak var tableViewController: MoviesTableViewController?
    var movieId:Int64?
    
    @IBAction func showHideTouchUp(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            
            // toggle between hidden and shown
            let willBeHidden = !self.overviewContainer.isHidden
            
            // update TVC state regarding show/hide status of this movie
            if let mId = self.movieId {
                self.tableViewController?.setMovie(movieId: mId, isOpen: !willBeHidden)
            }
            
            // swap the title of the Show/Hide button
            self.showHideButton.setTitle(willBeHidden ? "Show Overview" : "Hide Overview", for: .normal)
            
            // toggling isHidden will trigger UIStackView to animate
            self.overviewContainer.isHidden = willBeHidden
            self.layoutIfNeeded()
        }
        
        // tell the TableView to animate
        if let table = self.tableViewController?.tableView {
            table.beginUpdates()
            table.endUpdates()
        }
    }
    
    // show the overview without animation
    // used when the TVC creates cells
    func snapOpen() {
        self.overviewContainer.isHidden = false
    }
    
    // default to the closed state
    override func prepareForReuse() {
        self.overviewContainer.isHidden = true
    }
}
