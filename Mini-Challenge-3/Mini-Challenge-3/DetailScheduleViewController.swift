//
//  DetailScheduleViewController.swift
//  Mini-Challenge-3
//
//  Created by Nathanael Adolf Sukiman on 21/07/20.
//  Copyright © 2020 Nathanael Adolf Sukiman. All rights reserved.
//

import UIKit

class DetailScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tempParticipantMatchArray:[Match] = []
    
    @IBOutlet weak var scheduleTableView: UITableView!
    
    var tempString: String = ""
    var firstPlayer: String = ""
    var secondPlayer: String = ""
    var tempCode: String = ""
    
    var firstPlayerGame1: String = ""
    var firstPlayerGame2: String = ""
    var firstPlayerGame3: String = ""
    var secondPlayerGame1: String = ""
    var secondPlayerGame2: String = ""
    var secondPlayerGame3: String = ""
    
    var status: String = ""
    //player g bisa ke halaman modal, klo admin bisa
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempParticipantMatchArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailScheduleCell", for: indexPath) as! DetailScheduleTableViewCell
        
        cell.firstPlayerLabel.text = tempParticipantMatchArray[indexPath.row].firstPlayerName
        cell.secondPlayerLabel.text = tempParticipantMatchArray[indexPath.row].secondPlayerName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if status == "Admin" || status == "admin"
        {
            performSegue(withIdentifier: "updateScore", sender: self)
        }
        else
        {
            //nothing happened because the user is player
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
        
        print(tempParticipantMatchArray)
        print(tempCode)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadTournamentMatches()
    }
    
    
    @IBAction func unwindSegueFromScore(sender: UIStoryboardSegue){
        print("unwind ke schedule")
        
        print("FP1: \(firstPlayerGame1)")
        
        let indexPath = scheduleTableView.indexPathForSelectedRow!
        let currentCell = scheduleTableView.cellForRow(at: indexPath) as! DetailScheduleTableViewCell
        
        scheduleTableView.reloadData()
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "updateScore" {
            let dest = segue.destination as! ModalScheduleViewController
            let indexPath = scheduleTableView.indexPathForSelectedRow!
            let currentCell = scheduleTableView.cellForRow(at: indexPath) as! DetailScheduleTableViewCell
            
            firstPlayer = currentCell.firstPlayerLabel.text!
            secondPlayer = currentCell.secondPlayerLabel.text!
            
            
            dest.firstPlayer = firstPlayer
            dest.secondPlayer = secondPlayer
            
            //print("fp = \(firstPlayer)")
        }
        
    }
    
    func loadTournamentMatches() {
        tempParticipantMatchArray.removeAll()
        let headers = [
            "api-host": "http://localhost:8080/badmintour-api/"
            //                        "api-host": "free-nba.p.rapidapi.com",
            //                        "x-rapidapi-key": "3a512fd609mshca217d2587053fap1a30d3jsnd633afea68cb"
        ]
        
        //        let id = 1
        //
        //        let request = NSMutableURLRequest(url: NSURL(string: "http://localhost:8080/badmintour-api/index.php/user/user?id=1")! as URL,
        //                                          cachePolicy: .useProtocolCachePolicy,
        //                                          timeoutInterval: 10.0)
        let request = NSMutableURLRequest(url: NSURL(string: "http://localhost:8080/badmintour-api/tournament/matches?badmintour-key=badmintour399669&code=\(tempCode)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        //                let request = NSMutableURLRequest(url: NSURL(string: "https://free-nba.p.rapidapi.com/games/1")! as URL,
        //                    cachePolicy: .useProtocolCachePolicy,
        //                timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse as Any)
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
                        for item in json {
                            let jsonTour = item as! [String: AnyObject]
                            self.tempParticipantMatchArray.append(Match(firstPlayer: jsonTour["player1"] as! String, secondPlayer: jsonTour["player2"] as! String))
                            
                        }
                        
                        DispatchQueue.main.async {
                            self.scheduleTableView.reloadData()
                        }
                        
                        //                        let jsonUser = json["user"] as! [String: AnyObject]
                        
                        //                        print(jsonUser["fullname"] as! String)
                        
                        
                    }
                    catch let error {
                        print(error.localizedDescription)
                    }
                    
                }
            }
        })
        
        dataTask.resume()
        
    }
    
}
