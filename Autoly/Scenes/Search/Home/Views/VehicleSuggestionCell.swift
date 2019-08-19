//
//  VehicleSuggestionCell.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-03-01.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import UIKit
import Parse

protocol VehicleSuggestionCellType {
    func display(photo: PFFile?)
    func displayDistance(from geoPoint: PFGeoPoint?)
}

class VehicleSuggestionCell: UICollectionViewCell, ReusableView, NibLoadableView {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var photoView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photoView.layer.cornerRadius = 8
        cardView.layer.cornerRadius = 8
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize.zero
        cardView.layer.shadowRadius = 8
    }
    
}

extension VehicleSuggestionCell: VehicleSuggestionCellType {
    
    internal func display(photo: PFFile?) {
        photoView.image = #imageLiteral(resourceName: "Porsche")
    }
    
    internal func displayDistance(from geoPoint: PFGeoPoint?) {
        
    }
    
}
