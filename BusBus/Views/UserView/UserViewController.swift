//
//  UserViewController.swift
//  BusBus
//
//  Created by Noyan Çepikkurt on 2.04.2023.
//

import UIKit
import FirebaseAuth

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
    var passengerId = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.text = Auth.auth().currentUser?.email
        let gestureRegoznizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRegoznizer)
        tableViewRegister()
        arrayToString()
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    private func arrayToString() {
        if let index = buyingSeatArray.firstIndex(of: "") {
            buyingSeatArray.remove(at: index)
        }
        let seatsString = buyingSeatArray.joined(separator: ",")
        buyingSeatLabel.text = seatsString
        totalPriceLabel.text = "\(totalPrice) ₺"
    }
    
    private func tableViewRegister() {
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "tableViewCell")
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        if passengerNames.count == buyingSeatArray.count && passengerId.count == buyingSeatArray.count {
            navigationController?.popToRootViewController(animated: true)
            navigationController?.navigationBar.isHidden = true
            tabBarController!.selectedIndex = 1
            NotificationCenter.default.post(name: .notificationName, object: nil, userInfo: ["buyingSeatArray":buyingSeatArray,"boarding":boarding,"destination":destination,"date":date,"timeStarted":timeStarted,"passengerNames":passengerNames,"passengerId":passengerId])
            
            UserDefaults.standard.set(buyingSeatArray, forKey: "buyingSeatArray")
            
        } else {
            UIAlertController.alertMessage(title: "Üzgünüz", message: "Eksik bilgi girdiniz, lütfen koltuk seçim ekranına dönüp tekrardan deneyiniz", vc: self)
        }
    }
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let enteredText = textField.text!
        if let _ = Int(enteredText) {
            passengerId.append(enteredText)
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
        cell.idTextField.delegate = self
        
        return cell
    }
}
