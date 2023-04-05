//
//  LoginViewController.swift
//  BusBus
//
//  Created by Noyan Çepikkurt on 1.04.2023.
//

import UIKit
import FirebaseAuth

final class LoginViewController: UIViewController {
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureRegoznizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRegoznizer)
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authdata, error) in
                if error != nil {
                    UIAlertController.alertMessage(title: "Hata", message: error?.localizedDescription ?? "Hata", vc: self)
                } else {
                    let defaults = UserDefaults.standard
                    if defaults.object(forKey: "FirstTime") == nil {
                        defaults.set("No",forKey: "FirstTime")
                        self.performSegue(withIdentifier: "toOnboardingVC", sender: nil)
                    } else {
                        self.performSegue(withIdentifier: "toHomeVC", sender: nil)
                    }
                }
            }
        } else {
            UIAlertController.alertMessage(title: "Hata", message: "Kullanıcı adı veya şifre girilmedi", vc: self)
        }
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "toSignUpVC", sender: nil)
    }
    
    @IBAction func LoginAsGuestButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "toOnboardingVC", sender: nil)
    }
}
