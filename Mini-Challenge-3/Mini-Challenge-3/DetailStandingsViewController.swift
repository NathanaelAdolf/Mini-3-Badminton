//
//  DetailStandingsViewController.swift
//  Mini-Challenge-3
//
//  Created by Griffin on 21/07/20.
//  Copyright © 2020 Nathanael Adolf Sukiman. All rights reserved.
//

import UIKit

class DetailStandingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var standingsTableView: UITableView!
    var playerList: [String] = []
    var tempCode: String = ""
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return playerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailStandingsCell", for: indexPath) as! DetailStandingsTableViewCell
        
        cell.position.text = String(indexPath.row + 1)
        cell.playerName.text = playerList[indexPath.row]
        
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
    

    override func viewDidAppear(_ animated: Bool) {
        loadStandings()
    }
    
    override func viewDidLoad() {
        print("masuk standings")
        
        super.viewDidLoad()
        
        standingsTableView.delegate = self
        standingsTableView.dataSource = self
        
        print("Peserta = \(playerList.count)")
        // Do any additional setup after loading the view.
    }
    
    func loadStandings() {
        playerList.removeAll()
//        tempParticipantMatchArray.removeAll()
        let headers = [
            "api-host": "http://localhost:8080/badmintour-api/"
            //                        "api-host": "free-nba.p.rapidapi.com",
            //                        "x-rapidapi-key": "3a512fd609mshca217d2587053fap1a30d3jsnd633afea68cb"
        ]
        
        //        let id = 1
        //
        //        let request = NSMutableURLRequest(url: NSURL(string: "https://stefanjivalino9.000webhostapp.com/index.php/user/user?id=1")! as URL,
        //                                          cachePolicy: .useProtocolCachePolicy,
        //                                          timeoutInterval: 10.0)
        let request = NSMutableURLRequest(url: NSURL(string: "http://localhost:8080/badmintour-api/tournament/players?badmintour-key=badmintour399669&code=\(tempCode)")! as URL,
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
