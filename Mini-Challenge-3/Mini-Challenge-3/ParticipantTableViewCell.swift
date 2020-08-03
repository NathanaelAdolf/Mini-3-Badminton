//
//  ParticipantTableViewCell.swift
//  Mini-Challenge-3
//
//  Created by Nathanael Adolf Sukiman on 18/07/20.
//  Copyright © 2020 Nathanael Adolf Sukiman. All rights reserved.
//

import UIKit

class ParticipantTableViewCell: UITableViewCell {

    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var inputNameTextField: UITextField!
    
    @IBOutlet weak var submitAction: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

 
    @IBAction func submitButtonPressed(_ sender: Any) {
        playerNameLabel.text = inputNameTextField.text
        
        inputNameTextField.isHidden = true
        submitAction.isHidden = true
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
