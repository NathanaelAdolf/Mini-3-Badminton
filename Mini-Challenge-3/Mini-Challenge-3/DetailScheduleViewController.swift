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
    @IBOutlet weak var standingsTableView: UITableView!
    
    @IBOutlet weak var pickerSegmented: UISegmentedControl!
    
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
    
    var playerList: [String] = []
    var play: [String] = []
    var win: [String] = []
    var lose: [String] = []
    var dif: [String] = []
    var point: [String] = []
    
    var status: String = ""
    //player g bisa ke halaman modal, klo admin bisa
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int = 0
        switch tableView {
        case scheduleTableView:
            count = tempParticipantMatchArray.count
        case standingsTableView:
            count = playerList.count
        default:
            print("something went wrong")
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == scheduleTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailScheduleCell", for: indexPath) as! DetailScheduleTableViewCell
            
            cell.firstPlayerLabel.text = tempParticipantMatchArray[indexPath.row].firstPlayerName
            cell.secondPlayerLabel.text = tempParticipantMatchArray[indexPath.row].secondPlayerName
            if tempParticipantMatchArray[indexPath.row].status == "0" {
                cell.secondScoreLabel.text = "N/A"
                cell.firstScoreLabel.isHidden = true
                cell.thirdScoreLabel.isHidden = true
            }
            else {
                cell.firstScoreLabel.isHidden = false
                cell.thirdScoreLabel.isHidden = false
                if tempParticipantMatchArray[indexPath.row].firstGame3 == "0" && tempParticipantMatchArray[indexPath.row].secondGame3 == "0" {
                    cell.firstScoreLabel.text = "\(tempParticipantMatchArray[indexPath.row].firstGame1 ?? "") - \(tempParticipantMatchArray[indexPath.row].secondGame1 ?? "")"
                    cell.secondScoreLabel.text = "\(tempParticipantMatchArray[indexPath.row].firstGame2 ?? "") - \(tempParticipantMatchArray[indexPath.row].secondGame2 ?? "")"
                    cell.thirdScoreLabel.isHidden = true
                }
                else {
                    cell.firstScoreLabel.text = "\(tempParticipantMatchArray[indexPath.row].firstGame1 ?? "") - \(tempParticipantMatchArray[indexPath.row].secondGame1 ?? "")"
                    cell.secondScoreLabel.text = "\(tempParticipantMatchArray[indexPath.row].firstGame2 ?? "") - \(tempParticipantMatchArray[indexPath.row].secondGame2 ?? "")"
                     cell.thirdScoreLabel.text = "\(tempParticipantMatchArray[indexPath.row].firstGame3 ?? "") - \(tempParticipantMatchArray[indexPath.row].secondGame3 ?? "")"
                }
            }
            
            
            
            return cell
        }
        else if tableView == standingsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailStandingsCell", for: indexPath) as! DetailStandingsTableViewCell
            
            cell.position.text = String(indexPath.row + 1)
            cell.playerName.text = playerList[indexPath.row]
            
            cell.playerMatchPlayed.text = play[indexPath.row]
            cell.playerWin.text = win[indexPath.row]
            cell.playerLoss.text = lose[indexPath.row]
            cell.playerDiff.text = dif[indexPath.row]
            cell.playerPts.text = point[indexPath.row]
            
            if indexPath.row % 2 == 0
            {
                cell.backgroundColor = .white
            }
            else
            {
                cell.backgroundColor = UIColor.init(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
            }
            
            return cell
        }
        return UITableViewCell()
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
        var x: Int = 0
        switch tableView {
        case scheduleTableView:
            x = 120
        case standingsTableView:
            x = 45
        default:
            print("something went wrong")
        }
        return CGFloat(x)
    }
    
    @IBAction func segmentedChanged(_ sender: Any) {
        if pickerSegmented.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.standingsTableView.alpha = 0
                self.scheduleTableView.alpha = 1
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.standingsTableView.alpha = 1
                self.scheduleTableView.alpha = 0
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
        
        standingsTableView.delegate = self
        standingsTableView.dataSource = self
        
        print(tempParticipantMatchArray)
        print(tempCode)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadTournamentMatches()
        loadStandings()
    }
    
    @IBAction func unwindSegueFromScore(sender: UIStoryboardSegue){
        print("unwind ke schedule")
        loadTournamentMatches()
        loadStandings()
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
            "api-host": "https://stefanjivalino9.000webhostapp.com/"
            //                        "api-host": "free-nba.p.rapidapi.com",
            //                        "x-rapidapi-key": "3a512fd609mshca217d2587053fap1a30d3jsnd633afea68cb"
        ]
        
        //        let id = 1
        //
        //        let request = NSMutableURLRequest(url: NSURL(string: "https://stefanjivalino9.000webhostapp.com/index.php/user/user?id=1")! as URL,
        //                                          cachePolicy: .useProtocolCachePolicy,
        //                                          timeoutInterval: 10.0)
        let request = NSMutableURLRequest(url: NSURL(string: "https://stefanjivalino9.000webhostapp.com/tournament/matches?badmintour-key=badmintour399669&code=\(tempCode)")! as URL,
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
                            self.tempParticipantMatchArray.append(Match(firstPlayer: jsonTour["player1"] as! String, secondPlayer: jsonTour["player2"] as! String, status: jsonTour["status"] as! String, firstGame1: jsonTour["first_g1"] as! String, firstGame2: jsonTour["first_g2"] as! String, firstGame3: jsonTour["first_g3"] as! String, secondGame1: jsonTour["second_g1"] as! String, secondGame2: jsonTour["second_g2"] as! String, secondGame3: jsonTour["second_g3"] as! String))
                            
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
    
    func loadStandings() {
            playerList.removeAll()
            play.removeAll()
            win.removeAll()
            lose.removeAll()
            dif.removeAll()
            point.removeAll()
    //        tempParticipantMatchArray.removeAll()
            let headers = [
                "api-host": "https://stefanjivalino9.000webhostapp.com/"
                //                        "api-host": "free-nba.p.rapidapi.com",
                //                        "x-rapidapi-key": "3a512fd609mshca217d2587053fap1a30d3jsnd633afea68cb"
            ]
            
            //        let id = 1
            //
            //        let request = NSMutableURLRequest(url: NSURL(string: "https://stefanjivalino9.000webhostapp.com/index.php/user/user?id=1")! as URL,
            //                                          cachePolicy: .useProtocolCachePolicy,
            //                                          timeoutInterval: 10.0)
            let request = NSMutableURLRequest(url: NSURL(string: "https://stefanjivalino9.000webhostapp.com/tournament/players?badmintour-key=badmintour399669&code=\(tempCode)")! as URL,
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
                                self.playerList.append(jsonTour["nama"] as! String)
                                self.play.append(jsonTour["play"] as! String)
                                self.win.append(jsonTour["win"] as! String)
                                self.lose.append(jsonTour["lose"] as! String)
                                self.dif.append(jsonTour["dif"] as! String)
                                self.point.append(jsonTour["point"] as! String)
                            }
                            
                            DispatchQueue.main.async {
                                self.standingsTableView.reloadData()
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
