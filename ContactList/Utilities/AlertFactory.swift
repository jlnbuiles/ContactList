//
//  AlertFactory.swift
//  ContactList
//
//  Created by Julian Builes on 1/13/22.
//

import UIKit

class AlertFactory {
    
    static func genericErrorAlert() -> UIAlertController {
        let alertController = UIAlertController(title: "An unknown error happened",
                                           message: "Something went wrong. Please check your connection and try again. If this issue continues, please drop us a line at support@yourapp.com",
                                           preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        return alertController
    }
}
