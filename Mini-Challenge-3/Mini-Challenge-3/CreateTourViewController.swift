//
//  CreateTourViewController.swift
//  Mini-Challenge-3
//
//  Created by Nathanael Adolf Sukiman on 18/07/20.
//  Copyright © 2020 Nathanael Adolf Sukiman. All rights reserved.
//

import UIKit

class CreateTourViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var participantTableView: UITableView!
    
    var playerNameListArray: [String] = []
    var participantMatchArray: [Match] = []
    var tableRowIndex: Int = 0
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerNameListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "participantCell") as! ParticipantTableViewCell
        
        cell.playerNameLabel.text = playerNameListArray[indexPath.row]
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
        
  
    @IBAction func addAction(_ sender: Any) {
        tableRowIndex += 1
        playerNameListArray.append("Player Name")
        
        participantTableView.reloadData()
    }
    
    func makeMatch( listOfPlayerName: [String])
    {
        for firstIndex in 0...listOfPlayerName.count - 1 {
            
            for secondIndex in 0...listOfPlayerName.count - 1 {
                if firstIndex == secondIndex {
                    print("Skipp")
                }
                else
                {
                    if secondIndex < firstIndex
                    {
                        print("skipp")
                    }
                    else
                    {
                    participantMatchArray.append(Match(firstPlayer: listOfPlayerName[firstIndex], secondPlayer: listOfPlayerName[secondIndex]))
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        participantTableView.delegate = self
        participantTableView.dataSource = self
        
        doneButton.layer.cornerRadius = 5
        
        playerNameListArray.append("Nael")
        playerNameListArray.append("Adolf")
        playerNameListArray.append("Sukiman")
        playerNameListArray.append("Yere")
        
        makeMatch(listOfPlayerName:  playerNameListArray)
        print(participantMatchArray[0].firstPlayerName,participantMatchArray[0].secondPlayerName)
        print(participantMatchArray[1].firstPlayerName,participantMatchArray[1].secondPlayerName)
        print(participantMatchArray[2].firstPlayerName,participantMatchArray[2].secondPlayerName)
        print(participantMatchArray[3].firstPlayerName,participantMatchArray[3].secondPlayerName)
        print(participantMatchArray[4].firstPlayerName,participantMatchArray[4].secondPlayerName)
        print(participantMatchArray[5].firstPlayerName,participantMatchArray[5].secondPlayerName)
        print(participantMatchArray.count)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
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
