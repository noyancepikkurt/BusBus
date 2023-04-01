//
//  AlertExtension.swift
//  BusBus
//
//  Created by Noyan Çepikkurt on 2.04.2023.
//

import UIKit

extension UIAlertController {
    static func alertMessage(title: String, message: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(alertAction)
        vc.present(alert, animated: true)
    }
}
