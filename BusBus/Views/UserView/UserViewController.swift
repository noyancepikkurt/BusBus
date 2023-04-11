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
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
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
        indicatorConfig()
    }
    
    private func indicatorConfig() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .red
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
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
        activityIndicator.startAnimating()
        if passengerNames.count == buyingSeatArray.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in
                tabBarController!.selectedIndex = 1
                NotificationCenter.default.post(name: .notificationName, object: nil, userInfo: ["buyingSeatArray":buyingSeatArray,"boarding":boarding,"destination":destination,"date":date,"timeStarted":timeStarted,"passengerNames":passengerNames,"passengerId":passengerId])
                UserDefaults.standard.set(buyingSeatArray, forKey: "buyingSeatArray")
                self.activityIndicator.stopAnimating()
            }
        } else {
            UIAlertController.alertMessage(title: "Üzgünüz", message: "Eksik bilgi girdiniz, lütfen koltuk seçim ekranına dönüp tekrardan deneyiniz", vc: self)
        }
    }
    
    private func generateUUIDs(count: Int) -> [UUID] {
        var uuids = [UUID]()
        
        for _ in 1...count {
            let uuid = UUID()
            uuids.append(uuid)
        }
        return uuids
    }
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let enteredText = textField.text!
        passengerNames.append(enteredText)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buyingSeatArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell") as! UserTableViewCell
        cell.passengerLabel.text = "Yolcu \(indexPath.item + 1)"
        let uuidArray = generateUUIDs(count: buyingSeatArray.count)
        let uuidStrings = uuidArray.map { String($0.uuidString.prefix(8)) }
        passengerId = uuidStrings
        cell.idTextField.text = uuidStrings[indexPath.row]
        cell.idTextField.isUserInteractionEnabled = false
        cell.nameTextField.delegate = self
        return cell
    }
}
