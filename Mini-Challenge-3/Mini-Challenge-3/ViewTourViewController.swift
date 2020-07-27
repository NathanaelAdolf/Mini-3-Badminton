//
//  ViewTourViewController.swift
//  Mini-Challenge-3
//
//  Created by Aldo on 24/07/20.
//  Copyright © 2020 Nathanael Adolf Sukiman. All rights reserved.
//


import UIKit

class ViewTourViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var jointournamentTableView: UITableView!
    
    var tournamentListArray: [CupThumbnail] = []
    var choosenCupTitle: String = ""
    var choosenCupCode: String = ""
    var deviceId: String = ""
    
    var newTourName: String = ""
    var newTourDesc: String = ""
    var newTourCode: String = ""
    
    var status: String = "Player"
    
    var addButton = UIButton()
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tournamentListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tournamentCell", for: indexPath) as! TournamentTableViewCell
        
        cell.cupTitleLabel.text = tournamentListArray[indexPath.row].cupTitle
        cell.cupDescriptionLabel.text = tournamentListArray[indexPath.row].cupDesc
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        choosenCupTitle = tournamentListArray[indexPath.row].cupTitle
        choosenCupCode = tournamentListArray[indexPath.row].cupCode
        print(choosenCupTitle)
        performSegue(withIdentifier: "toDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController
        {
            destination.tempTitle = choosenCupTitle
            destination.tempCode = choosenCupCode
            destination.status = self.status
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Tournament Joined"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           
             let headerView = UIView()
             headerView.backgroundColor = UIColor.white

             let sectionLabel = UILabel(frame: CGRect(x: 0, y: 28, width:
             100, height: 30))
             sectionLabel.font = UIFont(name: "Helvetica", size: 20)
             sectionLabel.textColor = UIColor.black
           sectionLabel.text = "Tournament Joined"
             sectionLabel.sizeToFit()
        
             addButton = UIButton(frame: CGRect(x: 335, y: 23, width:
            30, height: 37))
            let plusSystemImage = UIImage(systemName: "plus.circle")
            addButton.setImage(plusSystemImage, for: .normal)
            addButton.tintColor = .red
        
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        
            headerView.addSubview(sectionLabel)
            headerView.addSubview(addButton)

             return headerView
       }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let leave = leaveAction(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [leave])
    }
    
    
    func leaveAction(at indexPath: IndexPath)->UIContextualAction
    {
        let action = UIContextualAction(style: .destructive, title: "Leave") { (action, view, completion) in
            
            self.tournamentListArray.remove(at: indexPath.row)
//            self.tournamentTableView.deleteRows(at: [indexPath], with: .automatic)
            //hapus data yang ada di api
            
        }
        
        action.image = UIImage(systemName: "trash")
        action.backgroundColor = .red
        
        return action
    }
    
   @objc func addButtonPressed()
    {
        print("add button pressed")
        performSegue(withIdentifier: "toJoinTourSegue", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
         navigationController?.setNavigationBarHidden(false, animated: animated)
        tournamentListArray.removeAll()
        if UserDefaults.standard.array(forKey: "joinTourName") != nil {
            let tourName = UserDefaults.standard.array(forKey: "joinTourName") as! [String]
            let tourDesc = UserDefaults.standard.array(forKey: "joinTourDesc") as! [String]
            let tourCode = UserDefaults.standard.array(forKey: "joinTourCode") as! [String]
            var counter: Int = 0
            for _ in tourName {
                tournamentListArray.append(CupThumbnail(title: tourName[counter], desc: tourDesc[counter], code: tourCode[counter]))
                counter += 1
            }
            
            jointournamentTableView.reloadData()
            
        }
    }
    
    
    @IBAction func unwindToTable(sender: UIStoryboardSegue)
    {
        tournamentListArray.append(CupThumbnail(title: newTourName, desc: newTourDesc, code: newTourCode))
        jointournamentTableView.reloadData()
    }
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
        tournamentListArray.append(CupThumbnail(title: newTourName, desc: newTourDesc, code: newTourCode))
        jointournamentTableView.reloadData()
    }
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        tournamentTableView.reloadData()
//    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        loadManageTournament()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jointournamentTableView.dataSource = self
        jointournamentTableView.delegate = self
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
   
    
    
    

    
}
    

