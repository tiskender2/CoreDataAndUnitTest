//
//  AlertManager.swift
//  WeatherAppSnapKit
//
//  Created by Tolga İskender on 12.09.2020.
//  Copyright © 2020 Tolga İskender. All rights reserved.
//

import Foundation
import  UIKit
class AlertManager {
    static let shared = AlertManager()
    
    func showAlertWithText(title:String,buttonTitle:String, completion: @escaping (String) -> Void){
        var textField = UITextField()
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let action =  UIAlertAction(title: buttonTitle, style: .default) { (action) in
            completion(textField.text ?? "")
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Change Title"
            textField = alertTextField
        }
        UIApplication.shared.keyWindow?.rootViewController?.present(alert,animated:true,completion:nil)
    }
    
}
