//
//  UViewController+CreateAlert.swift
//  NousAssesmentProject
//
//  Created by Atalay Asa on 22.09.2019.
//  Copyright © 2019 Atalay Asa. All rights reserved.
//

import UIKit


extension UIViewController {
    func showAlert(with title: String, and message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
