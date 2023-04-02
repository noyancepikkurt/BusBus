//
//  SignUpViewController.swift
//  BusBus
//
//  Created by Noyan Çepikkurt on 2.04.2023.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
