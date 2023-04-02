//
//  UserTableViewCell.swift
//  BusBus
//
//  Created by Noyan Çepikkurt on 2.04.2023.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var passengerLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    func setup(passengerModel: PassengerModel) {
        nameTextField.text = passengerModel.name
        ageTextField.text = passengerModel.age
    }
}
