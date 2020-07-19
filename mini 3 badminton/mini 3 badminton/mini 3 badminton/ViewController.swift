//
//  ViewController.swift
//  mini 3 badminton
//
//  Created by Griffin on 17/07/20.
//  Copyright © 2020 Griffin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var standingsView: UIView!
    @IBOutlet weak var scheduleView: UIView!
    @IBOutlet weak var tabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tabBar.selectedItem = tabBar.items![0] as UITabBarItem
    }

    @IBAction func segmentedControl(_ sender: Any) {
        if segment.selectedSegmentIndex == 0 {
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
    
}

