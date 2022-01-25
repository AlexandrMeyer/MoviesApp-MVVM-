//
//  AlertController.swift
//  MoviesApp
//
//  Created by Александр on 30.12.21.
//

import UIKit

class AlertController {
    
    static let shared = AlertController()

    private init() {}
    
    func showAlert(with title: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: "Add to Watchlist", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)
        return alertController
    }
}
