//
//  DetailViewController.swift
//  Mini-Challenge-3
//
//  Created by Nathanael Adolf Sukiman on 20/07/20.
//  Copyright © 2020 Nathanael Adolf Sukiman. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var standingsView: UIView!
    @IBOutlet weak var scheduleView: UIView!
    @IBOutlet weak var cupTitleLabel: UILabel!
    @IBOutlet weak var cupCodeLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    
    var tempCode: String = ""
    var tempTitle: String = ""
    
    var tempParticipantMatchArray: [Match] = []
    var tempParticipantName: [String] = []
    
    var status: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light

        // Do any additional setup after loading the view.
        if tempTitle == "" {
            getName(code: tempCode)
            print(tempTitle)
        } else {
            cupTitleLabel.text = tempTitle
        }
        
        codeLabel.text = tempCode
        
        let test = DetailViewController()
        print("test variable: \(test.tempTitle)")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
          navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
   
    
    @IBAction func unwindFromAdd(_ segue: UIStoryboardSegue) {
    //        tournamentListArray.append(CupThumbnail(title: newTourName, desc: newTourDesc, code: newTourCode))
    //        jointournamentTableView.reloadData()
            print(UserDefaults.standard.string(forKey: "tempTourName"))
            print("unwind")
        }
    
    func getName(code: String) {
        let headers = [
            "api-host": "https://stefanjivalino9.000webhostapp.com/"
            
        ]
        
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://stefanjivalino9.000webhostapp.com/tournament/manage?badmintour-key=badmintour399669&code=\(code)")! as URL,
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
                        
                        self.tempTitle = (json["tour_name"] as? String)!
                        DispatchQueue.main.async {
                            self.cupTitleLabel.text? = (json["tour_name"] as? String)!
                        }
                        
                        
                    }
                    catch let error {
                        print(error.localizedDescription)
                    }
                    
                }
            }
        })
        
        dataTask.resume()
        cupTitleLabel.text = tempTitle
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        
        if identifier == "cancelToManage"{
            print ("berhasil balik")
        }
        if let destination = segue.destination as? DetailScheduleViewController
        {
            print("tes schedule")
            destination.tempParticipantMatchArray = self.tempParticipantMatchArray
            destination.tempCode = tempCode
            destination.status = self.status
            
        }
//        if let destination = segue.destination as? DetailStandingsViewController
//        {
//            print("tes standings")
//            destination.playerList = tempParticipantName
//            destination.tempCode = tempCode
//        }
    }
}
