//
//  String.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-04-04.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import Foundation

extension String {
    
    /// Function to check a regex
    func matchRegex(_ regex: String) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return test.evaluate(with: self)
    }
    
    /// Check if the string is a valid email
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        return self.matchRegex(emailRegEx)
    }
    
    /// Check if it's a valid password
    var isValidPassword: Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
        
        return self.matchRegex(passwordRegex)
    }
    
    /// Return the string from Localizable.strings
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
}
