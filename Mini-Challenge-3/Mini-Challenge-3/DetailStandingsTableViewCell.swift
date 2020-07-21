//
//  DetailStandingsTableViewCell.swift
//  Mini-Challenge-3
//
//  Created by Griffin on 21/07/20.
//  Copyright © 2020 Nathanael Adolf Sukiman. All rights reserved.
//

import UIKit

class DetailStandingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerMatchPlayed: UILabel!
    @IBOutlet weak var playerWin: UILabel!
    @IBOutlet weak var playerLoss: UILabel!
    @IBOutlet weak var playerDiff: UILabel!
    @IBOutlet weak var playerPts: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
