//
//  SearchVehicleCell.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-02-15.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import UIKit
import Parse

protocol SearchVehicleCellType {
    func display(photo: PFFile?)
    func display(make: Make?, model: Model?)
    func display(price: NSNumber?)
}

class SearchVehicleCell: UITableViewCell, NibLoadableView, ReusableView {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardView.layer.shadowOpacity = 0.4
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowRadius = 8
        cardView.layer.cornerRadius = 20
        photoView.layer.cornerRadius = 20
    }
    
}

// MARK: SearchVehicleCellType

extension SearchVehicleCell: SearchVehicleCellType {
    
    internal func display(photo: PFFile?) {
        
    }
    
    internal func display(make: Make?, model: Model?) {
        nameLabel.text = ((make?.name ?? "") + " " + (model?.name ?? "")).trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
     }
    
    internal func display(price: NSNumber?) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "pt-BR")
        
        priceLabel.text = numberFormatter.string(from: price ?? NSNumber(value: 0))
    }
    
}

// MARK: UIGestureRecognizerDelegate

extension SearchVehicleCell {
    
//    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print(#function)
//        UIView.animate(withDuration: 0.2, animations: { self.cardView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95) })
//    }
//    
//    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print(#function)
//        UIView.animate(withDuration: 0.2, animations: { self.cardView.transform = CGAffineTransform.identity })
//    }
    
}
