//
//  UIBezierPath.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-04-08.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import UIKit

extension UIBezierPath {
    
    convenience init(center: CGPoint, radius: CGFloat) {
        self.init(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(.pi * 2.0), clockwise: true)
    }
    
}
