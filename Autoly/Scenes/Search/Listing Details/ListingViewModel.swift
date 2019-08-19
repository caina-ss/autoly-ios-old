//
//  ListingViewModel.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-04-03.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import Foundation
import RxSwift

protocol ListingViewModelType {
    var listing: Listing? { get }
    var photos: Variable<[UIImage]> { get }
}

class ListingViewModel: ListingViewModelType {
    var photos = Variable<[UIImage]>([#imageLiteral(resourceName: "Porsche"), #imageLiteral(resourceName: "Porsche"), #imageLiteral(resourceName: "Porsche"), #imageLiteral(resourceName: "Porsche"), #imageLiteral(resourceName: "Porsche")])
    var listing: Listing?
    
    init(listing: Listing) {
        self.listing = listing
    }
    
}
