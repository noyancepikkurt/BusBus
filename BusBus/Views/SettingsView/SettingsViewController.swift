//
//  SettingsViewController.swift
//  BusBus
//
//  Created by Noyan Çepikkurt on 2.04.2023.
//

import UIKit
import FirebaseAuth

final class SettingsViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private let settingsArray = ["Profilim","Bildirim Ayarlarım","Ayarlarım"]
    private let settingsImages = ["profile","noti","setting"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewRegister()
    }
    
    private func tableViewRegister() {
        tableView.register(UINib(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsCell")
    }
    
    @IBAction func logOutButtonAction(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toLoginVC", sender: nil)
        } catch {
            print("error")
        }
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell") as! SettingsTableViewCell
        cell.labelCell.text = settingsArray[indexPath.row]
        cell.imageCell.image = UIImage(named: settingsImages[indexPath.row])
        return cell
    }
}
