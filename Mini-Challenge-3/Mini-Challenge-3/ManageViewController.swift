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
        
        cell.backgroundView = cellBackgroundView(cellWidth: cell)
   
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
        
        addButton = UIButton(frame: CGRect(x: tableView.frame.size.width - 27, y: 23, width:
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
        
        let delete = deleteAction(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [delete])
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
    
    func cellBackgroundView(cellWidth: UITableViewCell)->UIView
    {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 10, width: cellWidth.frame.size.width, height: cellWidth.frame.size.height - 10)
        
        tempView.layer.cornerRadius = 5
               
          // Initialize gradient layer.
          let gradientLayer: CAGradientLayer = CAGradientLayer()
           gradientLayer.cornerRadius = 8
           gradientLayer.shadowRadius = 1
           gradientLayer.shadowOpacity = 0.2
           gradientLayer.shadowOffset = CGSize(width: 5, height: 3)
       
          // Set frame of gradient layer.
          gradientLayer.frame = tempView.frame

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
           tempView.layer.insertSublayer(gradientLayer, at: 0)
        
        return tempView
    }
    
   @objc func addButtonPressed()
    {
        print("add button pressed")
        performSegue(withIdentifier: "toCreateTourSegue", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
         self.tabBarController?.tabBar.isUserInteractionEnabled = false
         navigationController?.setNavigationBarHidden(false, animated: animated)
        self.tabBarController?.tabBar.isUserInteractionEnabled = false
        _ = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
            print("delayed message")
        }
        
        self.tabBarController?.tabBar.isUserInteractionEnabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
        overrideUserInterfaceStyle = .light
    
//        tournamentTableView.reloadData()
        deviceId = UIDevice.current.identifierForVendor!.uuidString
        tournamentTableView.dataSource = self
        tournamentTableView.delegate = self
 
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = UIColor.init(red: 216/255, green: 29/255, blue: 36/255, alpha: 1)
            self.navigationController?.navigationBar.standardAppearance = navBarAppearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }
    
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
