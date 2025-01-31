//
//  ViewTourViewController.swift
//  Mini-Challenge-3
//
//  Created by Aldo on 24/07/20.
//  Copyright © 2020 Nathanael Adolf Sukiman. All rights reserved.
//


import UIKit

class ViewTourViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var jointournamentTableView: UITableView!
    
    var tournamentListArray: [CupThumbnail] = []
    var choosenCupTitle: String = ""
    var choosenCupCode: String = ""
    var deviceId: String = ""
    
    var newTourName: String = ""
    var newTourDesc: String = ""
    var newTourCode: String = ""
    
    var availTourCode: [String] = []
    var tempCodeUD: [String] = []
    var tourNameUD: [String] = []
    var tourDescUD: [String] = []
    var tourCodeUD: [String] = []
    
    var status: String = "Player"
    
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

        if indexPath.row >= 0 && indexPath.row < tournamentListArray.count
       {
           choosenCupTitle = tournamentListArray[indexPath.row].cupTitle
           choosenCupCode = tournamentListArray[indexPath.row].cupCode

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
        return "Tournament Joined"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        
        let sectionLabel = UILabel(frame: CGRect(x: 0, y: 28, width:
            100, height: 30))
        sectionLabel.font = UIFont(name: "Helvetica", size: 20)
        sectionLabel.textColor = UIColor.black
        sectionLabel.text = "Tournament Joined"
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
        
        let leave = leaveAction(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [leave])
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

    func leaveAction(at indexPath: IndexPath)->UIContextualAction
    {
        var action = UIContextualAction()
        if indexPath.row >= 0 && indexPath.row < tournamentListArray.count
        {
              action = UIContextualAction(style: .destructive, title: "Leave")
              {
                (action, view, completion) in
                        
                print(self.tournamentListArray[indexPath.row].cupCode!)
                
                
                self.tourNameUD = UserDefaults.standard.array(forKey: "joinTourName") as! [String]
                self.tourDescUD = UserDefaults.standard.array(forKey: "joinTourDesc") as! [String]
                self.tourCodeUD = UserDefaults.standard.array(forKey: "joinTourCode") as! [String]
                var z: Int = 0
                for item in self.tourCodeUD {
                    if self.tournamentListArray[indexPath.row].cupCode! == item  {
                        self.tourNameUD.remove(at: z)
                        self.tourDescUD.remove(at: z)
                        self.tourCodeUD.remove(at: z)
                    }
                    z += 1
                }
                UserDefaults.standard.set(self.tourNameUD, forKey: "joinTourName")
                UserDefaults.standard.set(self.tourDescUD, forKey: "joinTourDesc")
                UserDefaults.standard.set(self.tourCodeUD, forKey: "joinTourCode")
                DispatchQueue.main.async {
                    self.jointournamentTableView.reloadData()
                }
                
                self.checkTournament()
                
            }
            
            action.image = UIImage(systemName: "trash")
            action.backgroundColor = .red
        
        }
        
       return action
    }
    
    @objc func addButtonPressed()
    {
        print("add button pressed")
        performSegue(withIdentifier: "toJoinTourSegue", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: animated)
        self.tabBarController?.tabBar.isUserInteractionEnabled = false
        
        _ = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
                   print("delayed message")
               }
        
        self.tabBarController?.tabBar.isUserInteractionEnabled = true
        
    }
    
    @IBAction func unwindToTable(sender: UIStoryboardSegue)
    {
        
    }
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
        
    }
    
    func checkTournament() {
        tournamentListArray.removeAll()
        availTourCode.removeAll()
        let headers = [
            "api-host": "https://badmintour.viablosolution.com/"
        ]
        
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://badmintour.viablosolution.com/tournament/manage?badmintour-key=badmintour399669")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
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
                            self.availTourCode.append(jsonTour["tour_code"] as! String)
                            
                            
                        }
                        
                        
                        
                        if UserDefaults.standard.array(forKey: "joinTourCode") != nil {
                            self.tempCodeUD = UserDefaults.standard.array(forKey: "joinTourCode") as! [String]
                            self.tourNameUD = UserDefaults.standard.array(forKey: "joinTourName") as! [String]
                            self.tourDescUD = UserDefaults.standard.array(forKey: "joinTourDesc") as! [String]
                            self.tourCodeUD = UserDefaults.standard.array(forKey: "joinTourCode") as! [String]
                            print(self.tourNameUD)
                            var x:Int = 0
                            for joinList in self.tempCodeUD {
                                if self.availTourCode.contains(joinList) {
                                    print("yes")
                                }
                                else {
                                    if x >= 0 && x <= self.tourNameUD.count {
                                        self.tourNameUD.remove(at: x)
                                        self.tourDescUD.remove(at: x)
                                        self.tourCodeUD.remove(at: x)
                                    }
                                    
                                }
                                x += 1
                            }
                            UserDefaults.standard.set(self.tourNameUD, forKey: "joinTourName")
                            UserDefaults.standard.set(self.tourDescUD, forKey: "joinTourDesc")
                            UserDefaults.standard.set(self.tourCodeUD, forKey: "joinTourCode")
                            if UserDefaults.standard.array(forKey: "joinTourName") != nil {
                                let tourName = UserDefaults.standard.array(forKey: "joinTourName") as! [String]
                                let tourDesc = UserDefaults.standard.array(forKey: "joinTourDesc") as! [String]
                                let tourCode = UserDefaults.standard.array(forKey: "joinTourCode") as! [String]
                                var counter: Int = 0
                                for _ in tourName {
                                    self.tournamentListArray.append(CupThumbnail(title: tourName[counter], desc: tourDesc[counter], code: tourCode[counter]))
                                    counter += 1
                                }
                            
                                
                            }
                        }
                        
                        
                        DispatchQueue.main.async {
                            self.jointournamentTableView.reloadData()
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
    
    override func viewDidAppear(_ animated: Bool) {

        checkTournament()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        jointournamentTableView.dataSource = self
        jointournamentTableView.delegate = self
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle
        {
        return .lightContent
    }
    
}


