//
//  DetailScheduleViewController.swift
//  Mini-Challenge-3
//
//  Created by Nathanael Adolf Sukiman on 21/07/20.
//  Copyright © 2020 Nathanael Adolf Sukiman. All rights reserved.
//

import UIKit

class DetailScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tempParticipantMatchArray:[Match] = []
    
    @IBOutlet weak var scheduleTableView: UITableView!
    
    var tempString: String = ""
    var firstPlayer: String = ""
    var secondPlayer: String = ""
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempParticipantMatchArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailScheduleCell", for: indexPath) as! DetailScheduleTableViewCell
        
        cell.firstPlayerLabel.text = tempParticipantMatchArray[indexPath.row].firstPlayerName
        cell.secondPlayerLabel.text = tempParticipantMatchArray[indexPath.row].secondPlayerName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //ke modal buat add score
        //let indexPath = scheduleTableView.indexPathForSelectedRow!
        //let currentCell = scheduleTableView.cellForRow(at: indexPath) as! DetailScheduleTableViewCell
        
        
        //print("cc fp= \(currentCell.firstPlayerLabel.text!)")
        //performSegue(withIdentifier: "updateScore", sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
    }
    

    @IBAction func unwindSegueFromScore(sender: UIStoryboardSegue){
        print("unwind ke schedule")
        scheduleTableView.reloadData()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "updateScore" {
            let dest = segue.destination as! ModalScheduleViewController
            let indexPath = scheduleTableView.indexPathForSelectedRow!
            let currentCell = scheduleTableView.cellForRow(at: indexPath) as! DetailScheduleTableViewCell
            
            firstPlayer = currentCell.firstPlayerLabel.text!
            secondPlayer = currentCell.secondPlayerLabel.text!
            
            
            dest.firstPlayer = firstPlayer
            dest.secondPlayer = secondPlayer
            
            //print("fp = \(firstPlayer)")
        }
        
    }
    

}
