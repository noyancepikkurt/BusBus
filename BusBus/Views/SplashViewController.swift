//
//  SplashViewController.swift
//  BusBus
//
//  Created by Noyan Çepikkurt on 4.04.2023.
//

import UIKit

final class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            self.performSegue(withIdentifier: "toLoginVCfromSplash", sender: nil)
        }
    }
}
