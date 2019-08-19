//
//  PWShadowButton.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-02-22.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import UIKit

class PWShadowButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = frame.height / 2
        layer.shadowOpacity = 0.1
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 8
    }
    
}
