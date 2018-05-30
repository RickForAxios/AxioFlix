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
            overviewContainer.isHidden = true
        }
    }
    
    weak var tableViewController: MoviesTableViewController?
    var movieId:Int64?
    
    @IBAction func showHideTouchUp(_ sender: Any) {
        let willBeHidden = !self.overviewContainer.isHidden
        if let mId = self.movieId {
//            self.tableViewController?.setMovie(movieId: mId, isOpen: !willBeHidden)
        }
//        self.showHideButton.setTitle(willBeHidden ? "Show Overview" : "Hide Overview", for: .normal)
        self.overviewContainer.isHidden = willBeHidden
//        self.layoutIfNeeded()
        
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
//        self.overviewContainer.isHidden = true
    }
}
