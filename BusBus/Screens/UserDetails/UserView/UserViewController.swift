//
//  UserViewController.swift
//  BusBus
//
//  Created by Noyan Çepikkurt on 2.04.2023.
//

import UIKit

class UserViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var buyingSeatLabel: UILabel!
    var buyingSeatArray = [String]()
    var totalPrice = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewRegister()
        arrayToString()
    }
    
    private func arrayToString() {
        let seatsString = buyingSeatArray.joined(separator: ",")
        buyingSeatLabel.text = seatsString
        totalPriceLabel.text = "\(totalPrice) ₺"
    }
    private func tableViewRegister() {
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "tableViewCell")
    }
    @IBAction func nextButtonAction(_ sender: Any) {
        
    }
    
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buyingSeatArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell") as! UserTableViewCell
        cell.passengerLabel.text = "Yolcu \(indexPath.item + 1)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
