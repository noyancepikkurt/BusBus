//
//  LoginViewController.swift
//  BusBus
//
//  Created by Noyan Çepikkurt on 1.04.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func loginButtonAction(_ sender: Any) {
        //Uygulama ikinci kez açılırsa tekrar onboarding ekranı gözükmemesi için
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "FirstTime") == nil {
            defaults.set("No",forKey: "FirstTime")
            performSegue(withIdentifier: "toOnboardingVC", sender: nil)
        } else {
            performSegue(withIdentifier: "toHomeVC", sender: nil)
        }
    }
    
    
}
