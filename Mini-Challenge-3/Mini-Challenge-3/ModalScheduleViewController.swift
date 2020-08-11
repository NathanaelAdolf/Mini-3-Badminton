//
//  ModalScheduleViewController.swift
//  Mini-Challenge-3
//
//  Created by Nathanael Adolf Sukiman on 22/07/20.
//  Copyright © 2020 Nathanael Adolf Sukiman. All rights reserved.
//

import UIKit

class ModalScheduleViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstPlayerName: UILabel!
    @IBOutlet weak var secondPlayerName: UILabel!
    @IBOutlet weak var firstPlayerGame1: UITextField!
    @IBOutlet weak var firstPlayerGame2: UITextField!
    @IBOutlet weak var firstPlayerGame3: UITextField!
    
    @IBOutlet weak var secondPlayerGame1: UITextField!
    @IBOutlet weak var secondPlayerGame2: UITextField!
    @IBOutlet weak var secondPlayerGame3: UITextField!
    
    var firstPlayerScore: Int = 0
    var secondPlayerScore: Int = 0
    var firstPlayerDiff: Int = 0
    var secondPlayerDiff: Int = 0
    var winnerDiff: Int = 0
    var losserDiff: Int = 0
    
    var firstPlayerPoint: Int = 0
    var secondPlayerPoint: Int = 0
    
    var winner: String = ""
    var losser: String = ""
    
    var firstWin: Int = 0
    var secondWin: Int = 0
    
    
    var firstGame1: Int = 0
    var firstGame2: Int = 0
    var firstGame3: Int = 0
    
    var secondGame1: Int = 0
    var secondGame2: Int = 0
    var secondGame3: Int = 0
    
    @IBAction func cancelUpdateScore(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var gameP1: Int = 0
    var gameP2: Int = 0
    
    
    var firstPlayer: String = ""
    var secondPlayer: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        self.hideKeyboardWhenTappedAround()

        firstPlayerGame1.delegate = self
        firstPlayerGame2.delegate = self
        firstPlayerGame3.delegate = self
        secondPlayerGame1.delegate = self
        secondPlayerGame2.delegate = self
        secondPlayerGame3.delegate = self
        
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
        
        gameP1 = 0
        gameP2 = 0
        
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
        
        print("gameP1 = \(gameP1), gameP2 = \(gameP2)")
        
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
        print("gameP1 = \(gameP1), gameP2 = \(gameP2)")
        
        if ((gameP1 == 1 && gameP2 == 1) && (firstPlayerGame3.text == "" || secondPlayerGame3.text == "")) {
            //error
            return 0
        }
        else if ((gameP1 == 2 || gameP2 == 2) && (firstPlayerGame3.text != "" || secondPlayerGame3.text != "")){
            //error
            return 0
        }
        else if ((gameP1 == 1 && gameP2 == 1) && (firstPlayerGame3.text != "" || secondPlayerGame3.text != "")){
            let w13 = Int(firstPlayerGame3.text!)!
            let w23 = Int(secondPlayerGame3.text!)!
            
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
        print("FINAL RES >> gameP1 = \(gameP1), gameP2 = \(gameP2)")
        return 1
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""

        // cek range
        guard let stringRange = Range(range, in: currentText) else { return false }

        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        
        return updatedText.count <= 2
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
            
            firstGame1 = Int(firstPlayerGame1.text!)!
            firstGame2 = Int(firstPlayerGame2.text!)!
            
            
            secondGame1 = Int(secondPlayerGame1.text!)!
            secondGame2 = Int(secondPlayerGame2.text!)!
            
            
            if firstPlayerGame3.text! != "" || secondPlayerGame3.text! != "" {
                firstGame3 = Int(firstPlayerGame3.text!)!
                secondGame3 = Int(secondPlayerGame3.text!)!
            }
            
            if firstGame1 > secondGame1 {
                firstPlayerScore += 1
            }
            else {
                secondPlayerScore += 1
            }
            
            if firstGame2 > secondGame2 {
                firstPlayerScore += 1
            }
            else {
                secondPlayerScore += 1
            }
            
            if firstPlayerGame3.text! != "" || secondPlayerGame3.text! != "" {
                if firstGame3 > secondGame3 {
                    firstPlayerScore += 1
                }
                else if firstGame3 < secondGame3 {
                    secondPlayerScore += 1
                }
                else {
                    
                }
            }
            else {
                firstGame3 = 0
                secondGame3 = 0
            }
            
            //update skor menang
            firstPlayerDiff = (firstGame1-secondGame1) + (firstGame2-secondGame2)
            secondPlayerDiff = (secondGame1-firstGame1) + (secondGame2-firstGame2)
            if firstPlayerGame3.text! != "" || secondPlayerGame3.text! != "" {
                firstPlayerDiff = firstPlayerDiff+(firstGame3-secondGame3)
                secondPlayerDiff = secondPlayerDiff+(secondGame3-firstGame3)
            }
            
            if firstPlayerDiff > secondPlayerDiff {
                winnerDiff = firstPlayerDiff
                losserDiff = secondPlayerDiff
            }
            else {
                winnerDiff = secondPlayerDiff
                losserDiff = firstPlayerDiff
            }
            
            if firstPlayerScore > secondPlayerScore  {
                firstPlayerPoint = 3
                firstWin = 1
                secondWin = -1
                winner = firstPlayer
                losser = secondPlayer
            }
            else {
                secondPlayerPoint = 3
                firstWin = -1
                secondWin = 1
                winner = secondPlayer
                losser = firstPlayer
            }
            
            updateWin()
            updateLose()
            updateScore()
            
        }
    
    func updateScore(){
        let semaphore = DispatchSemaphore (value: 0)

        let parameters = "player1=\(firstPlayer)&player2=\(secondPlayer)&badmintour-key=badmintour399669&first_g1=\(firstGame1)&first_g2=\(firstGame2)&first_g3=\(firstGame3)&second_g1=\(secondGame1)&second_g2=\(secondGame2)&second_g3=\(secondGame3)&status=1"
        let postData =  parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://badmintour.viablosolution.com/tournament/matchesupd")!,timeoutInterval: Double.infinity)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
       
    }
    
    func updateWin() {
        let semaphore = DispatchSemaphore (value: 0)

        let parameters = "badmintour-key=badmintour399669&nama=\(winner)&play=1&win=1&lose=0&dif=\(winnerDiff)&point=3"
        let postData =  parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://badmintour.viablosolution.com/tournament/players1")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
       
    }
    
    func updateLose() {
        let semaphore = DispatchSemaphore (value: 0)

        let parameters = "badmintour-key=badmintour399669&nama=\(losser)&play=1&win=0&lose=1&dif=\(losserDiff)&point=0"
        let postData =  parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://badmintour.viablosolution.com/tournament/players1")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
    }
    

}
