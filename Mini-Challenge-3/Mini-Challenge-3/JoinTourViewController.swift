//
//  JoinTourViewController.swift
//  Mini-Challenge-3
//
//  Created by Aldo on 22/07/20.
//  Copyright © 2020 Aldo. All rights reserved.
//

import UIKit

class JoinTourViewController: UIViewController, UITableViewDelegate, UIPickerViewDelegate {
  

    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var joinButton: UIButton!
    
    var tournamentCodeArray: [String] = []
    var participantNameArray: [String] = []
    
    
    @IBAction func joinAction(_ sender: Any) {
        performSegue(withIdentifier: "toJoinDetailSegue", sender: self)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        joinButton.layer.cornerRadius = 5
    }
}
 
  
