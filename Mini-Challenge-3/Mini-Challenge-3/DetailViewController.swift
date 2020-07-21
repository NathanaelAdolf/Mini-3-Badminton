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
    
    var tempTitle: String = ""
    
    var tempParticipantMatchArray: [Match] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cupTitleLabel.text = tempTitle
        
        let test = DetailViewController()
        print("test variable: \(test.tempTitle)")
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
            destination.tempParticipantMatchArray = tempParticipantMatchArray
        }
    }
}
