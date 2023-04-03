//
//  SignUpViewController.swift
//  BusBus
//
//  Created by Noyan Çepikkurt on 2.04.2023.
//

import UIKit
import FirebaseAuth

final class SignUpViewController: UIViewController {
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureRegoznizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRegoznizer)
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        if usernameTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().createUser(withEmail: usernameTextField.text!, password: passwordTextField.text!) { (authdata, error) in
                if error != nil {
                    UIAlertController.alertMessage(title: "Hata", message: error?.localizedDescription ?? "Hata", vc: self)
                } else {
                    self.dismiss(animated: true)
                }
            }
        } else {
            UIAlertController.alertMessage(title: "Hata", message: "Kullanıcı adı veya şifre girmedin", vc: self)
        }
    }
}
