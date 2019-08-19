//
//  CGSize.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-04-08.
//  Copyright © 2018 PapelWeb. All rights reserved.
//


import UIKit

extension CGSize {
    
    var min: CGFloat {
        return CGFloat.minimum(width, height)
    }
    
}
