//
//  ModalScheduleViewController.swift
//  Mini-Challenge-3
//
//  Created by Nathanael Adolf Sukiman on 22/07/20.
//  Copyright © 2020 Nathanael Adolf Sukiman. All rights reserved.
//

import UIKit

class ModalScheduleViewController: UIViewController {

    @IBOutlet weak var firstPlayerName: UILabel!
    @IBOutlet weak var secondPlayerName: UILabel!
    @IBOutlet weak var firstPlayerGame1: UITextField!
    @IBOutlet weak var firstPlayerGame2: UITextField!
    @IBOutlet weak var firstPlayerGame3: UITextField!
    
    @IBOutlet weak var secondPlayerGame1: UITextField!
    @IBOutlet weak var secondPlayerGame2: UITextField!
    @IBOutlet weak var secondPlayerGame3: UITextField!
    
    @IBAction func cancelUpdateScore(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var firstPlayer: String = ""
    var secondPlayer: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstPlayerName.text = firstPlayer
        secondPlayerName.text = secondPlayer
    }
    

    
     //MARK: - Navigation

     //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
        {
        
            print("skor masuk!")
            print(firstPlayerGame1.text!)
            if let dest = segue.destination as? DetailScheduleViewController
            {
                dest.firstPlayerGame1 = firstPlayerGame1.text!
                dest.firstPlayerGame2 = firstPlayerGame2.text!
                dest.firstPlayerGame3 = firstPlayerGame3.text!
                dest.secondPlayerGame1 = secondPlayerGame1.text!
                dest.secondPlayerGame2 = secondPlayerGame2.text!
                dest.secondPlayerGame3 = secondPlayerGame3.text!
            }
            
        }
    

}
