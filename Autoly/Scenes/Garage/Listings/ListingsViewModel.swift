//
//  ListingsViewModel.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-04-08.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import Foundation
import RxSwift

protocol ListingsViewModelType {
    var listings: Variable<[Listing]> { get }
    var isLoading: Variable<Bool> { get }
    
    func getListings()
}

class ListingsViewModel: ListingsViewModelType {
    var listings = Variable<[Listing]>([])
    var isLoading = Variable<Bool>(false)
 
    private let listingService = ListingsService()
    
    func getListings() {
        
    }
    
}
