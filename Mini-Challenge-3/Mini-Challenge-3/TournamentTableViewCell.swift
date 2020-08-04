//
//  TournamentTableViewCell.swift
//  Mini-Challenge-3
//
//  Created by Nathanael Adolf Sukiman on 17/07/20.
//  Copyright © 2020 Nathanael Adolf Sukiman. All rights reserved.
//

import UIKit
import Foundation
class TournamentTableViewCell: UITableViewCell {

    @IBOutlet weak var cupTitleLabel: UILabel!
    @IBOutlet weak var cupDescriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        /*
       // View to hold the CAGradientLayer.
        let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: gradientBackground.frame.size.width, height: gradientBackground.frame.size.height))
        
       // Initialize gradient layer.
       let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.cornerRadius = 8
        gradientLayer.shadowRadius = 1
        gradientLayer.shadowOpacity = 0.2
        gradientLayer.shadowOffset = CGSize(width: 5, height: 3)
    
        
       // Set frame of gradient layer.
        gradientLayer.frame = view.frame

       // Color at the top of the gradient.
        let topColor: CGColor = UIColor.init(red: 234/255, green: 61/255, blue: 61/255, alpha: 1).cgColor

       // Color at the bottom of the gradient.
       let bottomColor: CGColor = UIColor.init(red: 157/255, green: 104/255, blue: 104/255, alpha: 1).cgColor

       // Set colors.
       gradientLayer.colors = [topColor, bottomColor]

       // Set start point.
       gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)

       // Set end point.
       gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)

       // Insert gradient layer into view's layer heirarchy.
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        gradientBackground.insertSubview(view, at: 0)
        
        print("gradient background width : \(gradientBackground.frame.size.width)")
        gradientBackground.backgroundColor = .black
 */
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
