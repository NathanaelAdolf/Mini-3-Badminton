//
//  JoinTourViewController.swift
//  Mini-Challenge-3
//
//  Created by Aldo on 24/07/20.
//  Copyright © 2020 Nathanael Adolf Sukiman. All rights reserved.
//

import UIKit

class JoinTourViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var TournamentCodeTextField: UITextField!
    
    @IBOutlet weak var ParticipantNameTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var tournamentCodeArray: [String] = []
    var participantNamesArray: [String] = []
    
    var addButton = UIButton()

    @IBOutlet weak var joinButton: UIButton!
    
    
    var status: String = "Player"
    
    
    @IBAction func doneAction(_ sender: Any) {
        
        if TournamentCodeTextField.text == ""
        {
            errorLabel.isHidden = false
            errorLabel.text = "Tournament code must be filled"
        }
        else if ParticipantNameTextField.text == ""
        {
            errorLabel.isHidden = false
            errorLabel.text = "Player name must be filled"
        }
            performSegue(withIdentifier: "toDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController
        {
            destination.status = self.status
        }
    }
                    
//            postTournament()
//            postPlayers()
//        }
//
//    }
    
//    func postTournament() {
//        let semaphore = DispatchSemaphore (value: 0)
//
//        let parameters = "tour_name=\(tempInputTournamentname)&tour_location=\(venueTextField.text!)&device_id=\(UIDevice.current.identifierForVendor!.uuidString)&badmintour-key=badmintour399669&tour_code=\(tempCodeTour)"
//        let postData =  parameters.data(using: .utf8)
//
//        var request = URLRequest(url: URL(string: "https://stefanjivalino9.000webhostapp.com/tournament/tournament")!,timeoutInterval: Double.infinity)
//        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//
//        request.httpMethod = "POST"
//        request.httpBody = postData
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//          guard let data = data else {
//            print(String(describing: error))
//            return
//          }
//          print(String(data: data, encoding: .utf8)!)
//          semaphore.signal()
//        }
//
//        task.resume()
//        semaphore.wait()
//    }
//
//    func postPlayers() {
//        for item in playerNameListArray {
//            let semaphore = DispatchSemaphore (value: 0)
//
//            let parameters = "badmintour-key=badmintour399669&tour_code=\(tempCodeTour)&nama=\(item)"
//            let postData =  parameters.data(using: .utf8)
//
//            var request = URLRequest(url: URL(string: "https://stefanjivalino9.000webhostapp.com/tournament/players?badmintour-key=badmintour399669")!,timeoutInterval: Double.infinity)
//            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//
//            request.httpMethod = "POST"
//            request.httpBody = postData
//
//            let task = URLSession.shared.dataTask(with: request) { data, response, error in
//              guard let data = data else {
//                print(String(describing: error))
//                return
//              }
//              print(String(data: data, encoding: .utf8)!)
//              semaphore.signal()
//            }
//
//            task.resume()
//            semaphore.wait()
//        }
//
//    }
    
  
    
    
//    func makeMatch( listOfPlayerName: [String])
//    {
//        for firstIndex in 0...listOfPlayerName.count - 1 {
//
//            for secondIndex in 0...listOfPlayerName.count - 1 {
//                if firstIndex == secondIndex {
//
//                }
//                else
//                {
//                    if secondIndex < firstIndex
//                    {
//                    }
//                    else
//                    {
//                        participantMatchArray.append(Match(firstPlayer: listOfPlayerName[firstIndex], secondPlayer: listOfPlayerName[secondIndex], status: "0", firstGame1: "0", firstGame2: "0", firstGame3: "0", secondGame1: "0", secondGame2: "0", secondGame3: "0"))
//                    }
//                }
//            }
//        }
//    }
//
//    func printMatch(listOfPlayerMatch: [Match])
//    {
//        for i in 0...participantMatchArray.count - 1 {
//            print("\(String(describing: participantMatchArray[i].firstPlayerName)) vs \(String(describing: participantMatchArray[i].secondPlayerName))")
//
//            let semaphore = DispatchSemaphore (value: 0)
//
//            let parameters = "player1=\( participantMatchArray[i].firstPlayerName! )&player2=\( participantMatchArray[i].secondPlayerName!)&tour_code=\(tempCodeTour)&badmintour-key=badmintour399669"
//            let postData =  parameters.data(using: .utf8)
//
//            var request = URLRequest(url: URL(string: "https://stefanjivalino9.000webhostapp.com/tournament/matches")!,timeoutInterval: Double.infinity)
//            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//
//            request.httpMethod = "POST"
//            request.httpBody = postData
//
//            let task = URLSession.shared.dataTask(with: request) { data, response, error in
//              guard let data = data else {
//                print(String(describing: error))
//                return
//              }
//              print(String(data: data, encoding: .utf8)!)
//              semaphore.signal()
//            }
//
//            task.resume()
//            semaphore.wait()
//        }
//    }
//
//
//

//
//    @IBAction func unwindSegueFromModal(sender: UIStoryboardSegue){
//        participantTableView.reloadData()
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        self.tabBarController?.tabBar.isHidden = true
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.tabBarController?.tabBar.isHidden = false
//    }
//
//    @objc func dismissKeyboard() {
//        //Causes the view (or one of its embedded text fields) to resign the first responder status.
//        view.endEditing(true)
//    }
//
   
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        joinButton.layer.cornerRadius = 5
        
        errorLabel.isHidden = true
//
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
//        view.addGestureRecognizer(tap)
//
    }
}

