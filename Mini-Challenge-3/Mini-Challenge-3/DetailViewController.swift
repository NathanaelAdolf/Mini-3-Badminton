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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
