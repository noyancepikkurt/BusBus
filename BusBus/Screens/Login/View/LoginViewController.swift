//
//  LoginViewController.swift
//  BusBus
//
//  Created by Noyan Çepikkurt on 1.04.2023.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func loginButtonAction(_ sender: Any) {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authdata, error) in
                if error != nil {
                    UIAlertController.alertMessage(title: "Hata", message: error?.localizedDescription ?? "Hata", vc: self)
                } else {
                    self.performSegue(withIdentifier: "toOnboardingVC", sender: nil)
                }
            }
        } else {
            UIAlertController.alertMessage(title: "Hata", message: "Kullanıcı adı veya şifre girilmedi", vc: self)
        }
        
        
        
        
        //Uygulama ikinci kez açılırsa tekrar onboarding ekranı gözükmemesi için
//        let defaults = UserDefaults.standard
//        if defaults.object(forKey: "FirstTime") == nil {
//            defaults.set("No",forKey: "FirstTime")
//            performSegue(withIdentifier: "toOnboardingVC", sender: nil)
//        } else {
//            performSegue(withIdentifier: "toHomeVC", sender: nil)
//        }
        
    }
    
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "toSignUpVC", sender: nil)
    }
    
    @IBAction func LoginAsGuestButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "toOnboardingVC", sender: nil)
    }
    
}
