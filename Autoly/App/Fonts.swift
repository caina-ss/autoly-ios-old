//
//  Fonts.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-04-04.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import UIKit

struct Fonts {
    enum Circular: String {
        case book = "Book"
        case medium = "Medium"
        case bold = "Bold"
        
        func size(_ size: CGFloat) -> UIFont {
            return UIFont(name: "CircularStd-\(self.rawValue)", size: size)!
        }
    }
}
