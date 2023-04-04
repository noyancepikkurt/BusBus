//
//  UserViewController.swift
//  BusBus
//
//  Created by Noyan Çepikkurt on 2.04.2023.
//

import UIKit

final class UserViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var phoneNumberTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var totalPriceLabel: UILabel!
    @IBOutlet private weak var buyingSeatLabel: UILabel!
    var buyingSeatArray = [String]()
    var totalPrice = Int()
    var boarding = String()
    var destination = String() 
    var date = String()
    var timeStarted = String()
    var passengerNames = [String]()
    var passengerAges = [Int]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureRegoznizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRegoznizer)
        tableViewRegister()
        arrayToString()
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
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
        if passengerNames.count == buyingSeatArray.count && passengerAges.count == buyingSeatArray.count {
            tabBarController!.selectedIndex = 1
            NotificationCenter.default.post(name: .notificationName, object: nil, userInfo: ["buyingSeatArray":buyingSeatArray,"boarding":boarding,"destination":destination,"date":date,"timeStarted":timeStarted,"passengerNames":passengerNames,"passengerAges":passengerAges])
        } else {
            UIAlertController.alertMessage(title: "Üzgünüz", message: "Eksik bilgi giriniz", vc: self)
        }
    }
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let enteredText = textField.text!
        if let IntEnteredText = Int(enteredText) {
            passengerAges.append(IntEnteredText)
        } else {
            passengerNames.append(enteredText)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buyingSeatArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell") as! UserTableViewCell
        cell.passengerLabel.text = "Yolcu \(indexPath.item + 1)"
        cell.nameTextField.delegate = self
        cell.ageTextField.delegate = self
        return cell
    }
}
