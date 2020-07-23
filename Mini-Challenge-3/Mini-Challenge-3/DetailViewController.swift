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

        // Do any additional setup after loading the view.
        cupTitleLabel.text = tempTitle
        codeLabel.text = tempCode
        
        let test = DetailViewController()
        print("test variable: \(test.tempTitle)")
        
        //data dummy
        tempParticipantMatchArray.append(Match(firstPlayer: "Adolf", secondPlayer: "Griffin"))
        tempParticipantMatchArray.append(Match(firstPlayer: "Adolf", secondPlayer: "Griffin"))
        tempParticipantMatchArray.append(Match(firstPlayer: "Adolf", secondPlayer: "Griffin"))
        tempParticipantMatchArray.append(Match(firstPlayer: "Adolf", secondPlayer: "Griffin"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
          navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        if segmented.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.standingsView.alpha = 0
                self.scheduleView.alpha = 1
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.standingsView.alpha = 1
                self.scheduleView.alpha = 0
            })
        }
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
        if let destination = segue.destination as? DetailStandingsViewController
        {
            print("tes standings")
            destination.playerList = tempParticipantName
            destination.tempCode = tempCode
        }
    }
}
