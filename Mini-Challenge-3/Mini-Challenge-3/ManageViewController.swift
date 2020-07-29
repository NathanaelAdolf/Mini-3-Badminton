//
//  ManageViewController.swift
//  Mini-Challenge-3
//
//  Created by Nathanael Adolf Sukiman on 17/07/20.
//  Copyright © 2020 Nathanael Adolf Sukiman. All rights reserved.
//

import UIKit

class ManageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tournamentTableView: UITableView!
    
    var tournamentListArray: [CupThumbnail] = []
    var choosenCupTitle: String = ""
    var choosenCupCode: String = ""
    var deviceId: String = ""
    
    var status: String = "Admin"
    
    var addButton = UIButton()
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tournamentListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tournamentCell", for: indexPath) as! TournamentTableViewCell
        
        cell.cupTitleLabel.text = tournamentListArray[indexPath.row].cupTitle
        cell.cupDescriptionLabel.text = tournamentListArray[indexPath.row].cupDesc
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == tournamentTableView
        {
            choosenCupTitle = tournamentListArray[indexPath.row].cupTitle
            choosenCupCode = tournamentListArray[indexPath.row].cupCode
            print(choosenCupTitle)
            performSegue(withIdentifier: "toDetailSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController
        {
            destination.tempTitle = choosenCupTitle
            destination.tempCode = choosenCupCode
            destination.status = self.status
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Tournament Created"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           
             let headerView = UIView()
             headerView.backgroundColor = UIColor.white

             let sectionLabel = UILabel(frame: CGRect(x: 0, y: 28, width:
             100, height: 30))
             sectionLabel.font = UIFont(name: "Helvetica", size: 20)
             sectionLabel.textColor = UIColor.black
           sectionLabel.text = "Tournament Created"
             sectionLabel.sizeToFit()
        
             addButton = UIButton(frame: CGRect(x: 335, y: 23, width:
            30, height: 37))
            let plusSystemImage = UIImage(systemName: "plus.circle")
            addButton.setImage(plusSystemImage, for: .normal)
            addButton.tintColor = .red
        
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        
            headerView.addSubview(sectionLabel)
            headerView.addSubview(addButton)

             return headerView
       }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let edit = editAction(at: indexPath)
        let delete = deleteAction(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [delete,edit])
    }
    
    func editAction(at indexPath: IndexPath)-> UIContextualAction
    {
        let action = UIContextualAction(style: .normal, title: "Edit") { (action, view, completion) in
            completion(true)
        }
        action.image = UIImage(systemName: "pencil")
        action.backgroundColor = .gray
        
        return action
    }
    
    func deleteAction(at indexPath: IndexPath)->UIContextualAction
    {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            
//            self.tournamentListArray.remove(at: indexPath.row)
//            self.tournamentTableView.deleteRows(at: [indexPath], with: .automatic)
            let deleteCode = self.tournamentListArray[indexPath.row].cupCode!
//            print(deleteCode)
//
            self.deleteTournament(code: deleteCode)
            self.deleteMatches(code: deleteCode)
            self.deletePlayers(code: deleteCode)
            
            self.loadManageTournament()
//            print(self.tournamentListArray[indexPath.row].cupCode!)
            
        }
        
        action.image = UIImage(systemName: "trash")
        action.backgroundColor = .red
        
        return action
    }
    
   @objc func addButtonPressed()
    {
        print("add button pressed")
        performSegue(withIdentifier: "toCreateTourSegue", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
         navigationController?.setNavigationBarHidden(false, animated: animated)
        loadManageTournament()
    }
    
    @IBAction func pressedAction(_ sender: Any) {
        performSegue(withIdentifier: "toCreateTourSegue", sender: self)
    }
    
    @IBAction func unwindToTable(sender: UIStoryboardSegue)
    {
            
    }
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        tournamentTableView.reloadData()
        deviceId = UIDevice.current.identifierForVendor!.uuidString
        tournamentTableView.dataSource = self
        tournamentTableView.delegate = self
 
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
//    @objc func dismissKeyboard() {
//        //Causes the view (or one of its embedded text fields) to resign the first responder status.
//        view.endEditing(true)
//    }
    
    func deleteTournament(code: String) {
        let semaphore = DispatchSemaphore (value: 0)

        let parameters = "badmintour-key=badmintour399669&code=\(code)"
        let postData =  parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://stefanjivalino9.000webhostapp.com/tournament/deltour")!,timeoutInterval: Double.infinity)
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
    
    func deleteMatches(code: String) {
        let semaphore = DispatchSemaphore (value: 0)

        let parameters = "badmintour-key=badmintour399669&code=\(code)"
        let postData =  parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://stefanjivalino9.000webhostapp.com/tournament/delmatches")!,timeoutInterval: Double.infinity)
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
    
    func deletePlayers(code: String) {
        let semaphore = DispatchSemaphore (value: 0)

        let parameters = "badmintour-key=badmintour399669&code=\(code)"
        let postData =  parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://stefanjivalino9.000webhostapp.com/tournament/delplayer")!,timeoutInterval: Double.infinity)
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
    
    
    func loadManageTournament() {
        tournamentListArray.removeAll()
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
        let request = NSMutableURLRequest(url: NSURL(string: "https://stefanjivalino9.000webhostapp.com/tournament/manage?badmintour-key=badmintour399669")! as URL,
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
                            if jsonTour["device_id"] as! String == self.deviceId {
                                self.tournamentListArray.append(CupThumbnail(title: jsonTour["tour_name"] as! String, desc: jsonTour["tour_location"] as! String, code: jsonTour["tour_code"] as! String))
                            }
                            
                        }
                        
                        DispatchQueue.main.async {
                            self.tournamentTableView.reloadData()
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
