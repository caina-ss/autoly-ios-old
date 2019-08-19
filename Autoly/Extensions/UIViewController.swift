//
//  UIViewController.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-04-10.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // MARK: Action sheets
    
    public func actionSheet(title: String, _ handler: @escaping () -> Void) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancelar".localized, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: title, style: .default) { _ in
            handler()
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    public func actionSheet(title: String?, options: [(title: String, handler: () -> Void, style: UIAlertActionStyle)]) {
        guard options.count > 0 else { return }
        
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancelar".localized, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        for option in options {
            let action = UIAlertAction(title: option.title, style: option.style) { _ in
                option.handler()
            }
            alertController.addAction(action)
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Alerts
    
    public func alert(title: String, message: String, _ handler: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default) { _ in
            handler?()
        }
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    public func alertTextField(title: String,
                                   message: String,
                                   placeholder: String,
                                   keyboardType: UIKeyboardType = .default,
                                   isSecure: Bool = false,
                                   handler: ((String) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = placeholder
            textField.keyboardType = keyboardType
            textField.isSecureTextEntry = isSecure
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar".localized, style: .cancel)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            guard let text = alertController.textFields?[0].text else { return }
            
            handler?(text)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    public func confirm(title: String, message: String, _ confirmation: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Não".localized, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let yesAction = UIAlertAction(title: "Sim".localized, style: .default) { _ in
            confirmation()
        }
        alertController.addAction(yesAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}

