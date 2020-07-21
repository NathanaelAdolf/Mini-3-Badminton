//
//  DetailStandingsViewController.swift
//  Mini-Challenge-3
//
//  Created by Griffin on 21/07/20.
//  Copyright © 2020 Nathanael Adolf Sukiman. All rights reserved.
//

import UIKit

class DetailStandingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var standingsTableView: UITableView!
    var playerList: [String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return playerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailStandingsCell", for: indexPath) as! DetailStandingsTableViewCell
        
        cell.position.text = String(indexPath.row + 1)
        cell.playerName.text = playerList[indexPath.row]
        
        return cell
        
    }
    


    
    override func viewDidLoad() {
        print("masuk standings")
        
        super.viewDidLoad()
        
        standingsTableView.delegate = self
        standingsTableView.dataSource = self
        
        print("Peserta = \(playerList.count)")
        // Do any additional setup after loading the view.
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
