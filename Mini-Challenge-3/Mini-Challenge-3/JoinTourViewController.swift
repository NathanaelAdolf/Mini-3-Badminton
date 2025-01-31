//
//  JoinTourViewController.swift
//  Mini-Challenge-3
//
//  Created by Aldo on 24/07/20.
//  Copyright © 2020 Nathanael Adolf Sukiman. All rights reserved.
//

import UIKit

class JoinTourViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var TournamentCodeTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var tournamentCodeArray: [String] = []
    var addButton = UIButton()
    
    var tournamentListUserDefault: [CupThumbnail] = []
    var tempListTour: [CupThumbnail] = []
    
    var tempTourName: String = ""
    var tempTourCode: String = ""
    var tempTourDesc: String = ""
    
    var tourNameUD: [String] = []
    var tourDescUD: [String] = []
    var tourCodeUD: [String] = []
    
    var apiStatus: String = ""
    
    
    @IBOutlet weak var joinButton: UIButton!
    
    
    var status: String = "Player"
    
    
    @IBAction func doneAction(_ sender: Any) {
        
        
        if TournamentCodeTextField.text == ""
        {
            errorLabel.isHidden = false
            errorLabel.text = "Tournament code must be filled"
        }
        else {
            getViewData()

        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController
        {
            destination.tempCode = TournamentCodeTextField.text!
        }
    }
    
    
    func getViewData() {
        let tourCode = TournamentCodeTextField.text!
        let headers = [
            "api-host": "https://badmintour.viablosolution.com/"
            
        ]
        
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://badmintour.viablosolution.com/tournament/manage?badmintour-key=badmintour399669&code=\(tourCode)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        //
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
                        
                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: AnyObject]
                        if json["status"] as! String != "failed" {
                            self.tempTourName = json["tour_name"]! as! String
                            self.tempTourDesc = json["tour_location"] as! String
                            self.tempTourCode = tourCode
                            
                            if UserDefaults.standard.array(forKey: "joinTourName") != nil {
                                self.tourNameUD = UserDefaults.standard.array(forKey: "joinTourName") as! [String]
                                self.tourDescUD = UserDefaults.standard.array(forKey: "joinTourDesc") as! [String]
                                self.tourCodeUD = UserDefaults.standard.array(forKey: "joinTourCode") as! [String]
                            }
                            
                            
                            
                            self.tourNameUD.append(json["tour_name"]! as! String)
                            self.tourDescUD.append(json["tour_location"]! as! String)
                            self.tourCodeUD.append(json["tour_code"]! as! String)
                            UserDefaults.standard.set(self.tourNameUD, forKey: "joinTourName")
                            UserDefaults.standard.set(self.tourDescUD, forKey: "joinTourDesc")
                            UserDefaults.standard.set(self.tourCodeUD, forKey: "joinTourCode")
                            
                            
                            //                        print(self.tourNameUD)
                            //                        self.tournamentListUserDefault.append(CupThumbnail(title: self.tempTourName, desc: self.tempTourDesc, code: self.tempTourCode))
                            UserDefaults.standard.set(self.tournamentListUserDefault, forKey: "tempTour")
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "toDetailSegue", sender: JoinTourViewController.self)
                                
                            }
                            
                        }
                        else {
                            self.apiStatus = json["status"] as! String
                            print(self.apiStatus)
                            DispatchQueue.main.async {
                                self.errorLabel.isHidden = false
                                self.errorLabel.text = "Tournament code not found"
                            }
                            
                            
                            
                            //            performSegue(withIdentifier: "toDetailSegue", sender: self)
                        }
                        
                        
                        
                    }
                    catch let error {
                        print(error.localizedDescription)
                    }
                    
                }
            }
        })
        
        dataTask.resume()
        
    }
        
    override func viewDidLoad()
    {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        self.TournamentCodeTextField.delegate = self
       
        self.hideKeyboardWhenTappedAround()
        
        joinButton.layer.cornerRadius = 5
    
        errorLabel.isHidden = true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
               self.view.endEditing(true)
               return false
           }
           
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return.lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
}

