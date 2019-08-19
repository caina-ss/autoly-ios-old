//
//  ListingCreationSelectPhotoCell.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-04-10.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import UIKit

class ListingCreationSelectPhotoCell: UICollectionViewCell, ReusableView, NibLoadableView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.borderColor = UIColor.black.withAlphaComponent(0.6).cgColor
        contentView.layer.borderWidth = 1.0
        contentView.layer.cornerRadius = 6
    }
    
}
