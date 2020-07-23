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
    
    var gameP1: Int = 0
    var gameP2: Int = 0
    
    
    var firstPlayer: String = ""
    var secondPlayer: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstPlayerName.text = firstPlayer
        secondPlayerName.text = secondPlayer
        
        // Do any additional setup after loading the view.
    }
    
    func validate() -> Int {
        if(firstPlayerGame1.text == "" || firstPlayerGame2.text == "" || secondPlayerGame1.text == "" ||
            secondPlayerGame2.text == ""){
           //error
            return 0
        }
        
        let w11 = Int(firstPlayerGame1.text!)!
        let w21 = Int(secondPlayerGame1.text!)!
        
        if ((w11 > w21 && w11 == 21 && w11-w21 >= 2) || (w11 > w21 && 22...30 ~= w11 && w11-w21 == 2) || (w11 == 30 && w21 == 29)) {
            gameP1 += 1
        }
        else if((w21 > w11 && w21 == 21 && w21-w11 >= 2) || (w21 > w11 && 22...30 ~= w21 && w21-w11 == 2) || (w21 == 30 && w11 == 29)) {
            gameP2 += 1
        }
        else{
            //error
            return 0
        }
        
        let w12 = Int(firstPlayerGame2.text!)!
        let w22 = Int(secondPlayerGame2.text!)!
        
        if ((w12 > w22 && w12 == 21 && w12-w22 >= 2) || (w12 > w22 && 22...30 ~= w12 && w12-w22 == 2) || (w12 == 30 && w22 == 29)) {
            gameP1 += 1
        }
        else if((w22 > w12 && w22 == 21 && w22-w12 >= 2) || (w22 > w12 && 22...30 ~= w22 && w22-w12 == 2) || (w22 == 30 && w12 == 29)) {
            gameP2 += 1
        }
        else{
            //error
            return 0
        }
        
        if ((gameP1 == 2 || gameP2 == 2) && (firstPlayerGame3.text != "" || secondPlayerGame3.text != "")) {
            //error
            return 0
        }
        else{
            let w13 = Int(firstPlayerGame2.text!)!
            let w23 = Int(secondPlayerGame2.text!)!
            
            if ((w13 > w23 && w13 == 21 && w13-w23 >= 2) || (w13 > w23 && 22...30 ~= w13 && w13-w23 == 2) || (w13 == 30 && w23 == 29)) {
                gameP1 += 1
            }
            else if((w23 > w13 && w23 == 21 && w23-w13 >= 2) || (w23 > w13 && 22...30 ~= w23 && w23-w13 == 2) || (w23 == 30 && w13 == 29)) {
                gameP2 += 1
            }
            else{
                //error
                return 0
            }
        }
        
        return 1
    }
    

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {

            if validate() == 1{
                return true
            }
            else{
                let alert = UIAlertController(title: "Error", message: "Invalid score", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                return false
        }
        
    }

    
     //MARK: - Navigation

     //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
        {
            print("skor masuk!")
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
