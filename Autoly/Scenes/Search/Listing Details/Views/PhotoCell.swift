//
//  PhotoCell.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-04-03.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell, ReusableView, NibLoadableView {
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photoView.layer.cornerRadius = 7
        shadowView.layer.cornerRadius = 7
        shadowView.layer.shadowOpacity = 0.2
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 2, height: 6)
        shadowView.layer.shadowRadius = 8
    }
    
}
