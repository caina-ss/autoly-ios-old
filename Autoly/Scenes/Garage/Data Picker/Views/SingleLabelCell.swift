//
//  SingleLabelCell.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-04-09.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import UIKit

protocol SingleLabelCellType {
    func display(text: String?)
}

class SingleLabelCell: UITableViewCell, ReusableView, NibLoadableView {
    @IBOutlet weak var optionLabel: UILabel!
}

extension SingleLabelCell: SingleLabelCellType {
    
    internal func display(text: String?) {
        optionLabel.text = text
    }
    
}
