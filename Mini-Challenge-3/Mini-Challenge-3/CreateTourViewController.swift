//
//  CreateTourViewController.swift
//  Mini-Challenge-3
//
//  Created by Nathanael Adolf Sukiman on 18/07/20.
//  Copyright © 2020 Nathanael Adolf Sukiman. All rights reserved.
//

import UIKit

class CreateTourViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate {
  
    @IBOutlet weak var participantTableView: UITableView!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var venueTextField: UITextField!
    
    var playerNameListArray: [String] = []
    var participantMatchArray: [Match] = []
    let formatArray = ["Round Robin", "Knockout"]
    var tableRowIndex: Int = 0
    
    var addButton = UIButton()
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var randomCodeLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    var tempInputTournamentname: String = ""
    var tempCodeTour: String = ""
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerNameListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "participantCell") as! ParticipantTableViewCell
        
        cell.playerNameLabel.text = playerNameListArray[indexPath.row]
        
        return cell
    }
    
func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
          
            let headerView = UIView()
            headerView.backgroundColor = UIColor.init(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)

            let sectionLabel = UILabel(frame: CGRect(x: 0, y: 28, width:
            100, height: 30))
            sectionLabel.font = UIFont(name: "Helvetica", size: 15)
            sectionLabel.textColor = UIColor.gray
            sectionLabel.text = "     Participants"
            sectionLabel.sizeToFit()
       
            addButton = UIButton(frame: CGRect(x: 360, y: 20, width:
           30, height: 37))
           let plusSystemImage = UIImage(systemName: "plus.circle")
           addButton.setImage(plusSystemImage, for: .normal)
            addButton.tintColor = .red
       
            addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
       
           headerView.addSubview(sectionLabel)
           headerView.addSubview(addButton)

            return headerView
          }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           return "Participants"
       }
    
    //picker view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return formatArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return formatArray.count
    }

    @IBAction func doneAction(_ sender: Any) {
        
        if nameTextfield.text == ""
        {
            errorLabel.isHidden = false
            errorLabel.text = "Tournament name must be filled"
        }
        else if venueTextField.text == ""
        {
            errorLabel.isHidden = false
            errorLabel.text = "Tournament Venue must be filled"
        }
        else if playerNameListArray.count < 3
        {
           errorLabel.isHidden = false
            errorLabel.text = "Participant must be at least 3 person"
        }
        else{
            tempInputTournamentname = nameTextfield.text!
            makeMatch(listOfPlayerName:  playerNameListArray)
            printMatch(listOfPlayerMatch: participantMatchArray)
            performSegue(withIdentifier: "toDetailSegue", sender: self)
        }
       
    }
        
    @objc func addButtonPressed()
    {
        print("add button pressed")
        performSegue(withIdentifier: "toAddParticipantSegue", sender: self)
    }
    
    
    func makeMatch( listOfPlayerName: [String])
    {
        for firstIndex in 0...listOfPlayerName.count - 1 {
            
            for secondIndex in 0...listOfPlayerName.count - 1 {
                if firstIndex == secondIndex {
                    
                }
                else
                {
                    if secondIndex < firstIndex
                    {
                    }
                    else
                    {
                    participantMatchArray.append(Match(firstPlayer: listOfPlayerName[firstIndex], secondPlayer: listOfPlayerName[secondIndex]))
                    }
                }
            }
        }
    }
    
    func printMatch(listOfPlayerMatch: [Match])
    {
        for i in 0...participantMatchArray.count - 1 {
            print("\(String(describing: participantMatchArray[i].firstPlayerName)) vs \(String(describing: participantMatchArray[i].secondPlayerName))")
        }
    }
    
    func generateRandomString()->String
    {
        let letters: NSString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789"
        let len = UInt32(letters.length)
        var randomString = ""
        
        for _ in 0...4 {
            let random = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(random))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController
        {
            destination.tempTitle = tempInputTournamentname
            destination.tempParticipantMatchArray = participantMatchArray
            destination.tempParticipantName = playerNameListArray
            destination.tempCode = tempCodeTour
        }
    }
    
    @IBAction func unwindSegueFromModal(sender: UIStoryboardSegue){
          print("method masuk")
        participantTableView.reloadData()
       }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        participantTableView.delegate = self
        participantTableView.dataSource = self
        
        doneButton.layer.cornerRadius = 5
        
        //generate random code
        tempCodeTour = generateRandomString()
        randomCodeLabel.text = tempCodeTour
        
        errorLabel.isHidden = true
        
        /*data dummy
        playerNameListArray.append("Nael")
        playerNameListArray.append("Adolf")
        playerNameListArray.append("Sukiman")
        playerNameListArray.append("Yere")*/
        
    }
}
