//
//  VehicleCategoryCell.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-02-22.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import UIKit

class VehicleCategoryCell: UICollectionViewCell, ReusableView, NibLoadableView {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var iconView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardView.layer.cornerRadius = 8
        cardView.layer.shadowOpacity = 0.15
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize.zero
        cardView.layer.shadowRadius = 10
    }
    
}
