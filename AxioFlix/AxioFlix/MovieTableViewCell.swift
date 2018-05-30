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
    
    weak var tableView: UITableView?
    
    @IBAction func showHideTouchUp(_ sender: Any) {
        let willBeHidden = !self.overviewContainer.isHidden
        self.showHideButton.setTitle(willBeHidden ? "Show Overview" : "Hide Overview", for: .normal)
        self.overviewContainer.isHidden = willBeHidden
        self.layoutIfNeeded()
        
        if let table = self.tableView {
            table.beginUpdates()
            table.endUpdates()
        }
    }
    
    override func prepareForReuse() {
        self.overviewLabel.isHidden = true
    }
}
