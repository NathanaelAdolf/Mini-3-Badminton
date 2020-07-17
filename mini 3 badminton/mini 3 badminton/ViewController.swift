//
//  ViewController.swift
//  mini 3 badminton
//
//  Created by Griffin on 17/07/20.
//  Copyright © 2020 Griffin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tabBar.selectedItem = tabBar.items![0] as UITabBarItem
    }


}

