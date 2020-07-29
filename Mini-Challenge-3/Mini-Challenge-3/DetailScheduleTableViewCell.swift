//
//  DetailScheduleTableViewCell.swift
//  Mini-Challenge-3
//
//  Created by Nathanael Adolf Sukiman on 21/07/20.
//  Copyright © 2020 Nathanael Adolf Sukiman. All rights reserved.
//

import UIKit

class DetailScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var firstPlayerLabel: UILabel!
    @IBOutlet weak var secondPlayerLabel: UILabel!
    
    @IBOutlet weak var firstScoreLabel: UILabel!
    @IBOutlet weak var secondScoreLabel: UILabel!
    @IBOutlet weak var thirdScoreLabel: UILabel!
    @IBOutlet weak var scheduleBackgroundView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        scheduleBackgroundView.layer.cornerRadius = 5
        scheduleBackgroundView.backgroundColor = UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
  
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
