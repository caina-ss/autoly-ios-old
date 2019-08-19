//
//  ListingCreationPhotoCell.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-04-10.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import UIKit

protocol ListingCreationPhotoCellType {
    func displayPhoto(from data: Data?)
}

class ListingCreationPhotoCell: UICollectionViewCell, ReusableView, NibLoadableView {
    @IBOutlet weak var photoView: UIImageView!
}

extension ListingCreationPhotoCell: ListingCreationPhotoCellType {
    
    internal func displayPhoto(from data: Data?) {
        guard data != nil else { return }
        
        photoView.image = UIImage(data: data!)
    }
    
}
