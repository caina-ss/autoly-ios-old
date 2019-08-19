//
//  TagCell.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-04-17.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import UIKit

protocol TagCellType {
    func display(name: String?)
}

class TagCell: UICollectionViewCell, ReusableView, NibLoadableView {
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shadowView.layer.cornerRadius = 18.0
        shadowView.layer.shadowOpacity = 0.2
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowRadius = 6
    }
    
    override var isSelected: Bool {
        didSet {
            updateSelectionState()
        }
    }
    
}

// MARK: Private

extension TagCell {

    private func updateSelectionState() {
        shadowView.backgroundColor = isSelected ? Constants.Colors.PWBlue : .white
        nameLabel.textColor = isSelected ? .white : .black
    }
    
}

extension TagCell: TagCellType {
    
    internal func display(name: String?) {
        nameLabel.text = name
    }
    
}
