//
//  ManageViewController.swift
//  Mini-Challenge-3
//
//  Created by Nathanael Adolf Sukiman on 17/07/20.
//  Copyright © 2020 Nathanael Adolf Sukiman. All rights reserved.
//

import UIKit

class ManageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tournamentTableView: UITableView!
    
    var tournamentListArray: [CupThumbnail] = []
    
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Tournament Created"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           
             let headerView = UIView()
             headerView.backgroundColor = UIColor.white

             let sectionLabel = UILabel(frame: CGRect(x: 0, y: 28, width:
             100, height: 30))
             sectionLabel.font = UIFont(name: "Helvetica", size: 20)
             sectionLabel.textColor = UIColor.black
           sectionLabel.text = "Tournament Created"
             sectionLabel.sizeToFit()
        
            let addButton = UIButton(frame: CGRect(x: 335, y: 23, width:
            30, height: 37))
            let plusSystemImage = UIImage(systemName: "plus.circle")
            addButton.setImage(plusSystemImage, for: .normal)
            addButton.tintColor = .red
        
            headerView.addSubview(sectionLabel)
            headerView.addSubview(addButton)

             return headerView
       }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let edit = editAction(at: indexPath)
        let delete = deleteAction(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [delete,edit])
    }
    
    func editAction(at indexPath: IndexPath)-> UIContextualAction
    {
        let action = UIContextualAction(style: .normal, title: "Edit") { (action, view, completion) in
            completion(true)
        }
        action.image = UIImage(systemName: "pencil")
        action.backgroundColor = .gray
        
        return action
    }
    
    func deleteAction(at indexPath: IndexPath)->UIContextualAction
    {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            
            self.tournamentListArray.remove(at: indexPath.row)
            self.tournamentTableView.deleteRows(at: [indexPath], with: .automatic)
            //hapus data yang ada di api
            
        }
        
        action.image = UIImage(systemName: "trash")
        action.backgroundColor = .red
        
        return action
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func pressedAction(_ sender: Any) {
        performSegue(withIdentifier: "toCreateTourSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tournamentTableView.dataSource = self
        tournamentTableView.delegate = self
        
        //data dummy buat table view, nanti dihapus setelah udah bisa dapet data dari API
        self.tournamentListArray =
            [
                CupThumbnail(title: "July Cup", desc: "At Gor Ciputra"),
                CupThumbnail(title: "August Cup", desc: "At Jakarta")
            ]
    }
    
}
