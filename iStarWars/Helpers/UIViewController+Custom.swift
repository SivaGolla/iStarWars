//
//  UIViewController+Custom.swift
//  iStarWars
//
//  Created by Venkata Sivannarayana Golla on 19/05/23.
//

import UIKit

extension UIViewController {
    func okAlertPrompt(title: String, message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        return alertController
    }
}
