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
    
    private var shouldShowOverview = false
    var overviewText:String = ""
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.reset()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.reset()
    }
    
    @IBAction func showHideTouchUp(_ sender: Any) {
        self.shouldShowOverview = !self.shouldShowOverview
        
        if self.shouldShowOverview {
            self.overviewLabel.text = self.overviewText
        } else {
            self.overviewLabel.text = ""
        }
    }
    
    override func prepareForReuse() {
        self.reset()
    }
    
    private func reset() {
        shouldShowOverview = false
//        overviewLabel.text = ""
    }
}
