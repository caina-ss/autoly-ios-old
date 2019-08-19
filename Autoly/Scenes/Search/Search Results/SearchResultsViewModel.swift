//
//  SearchResultsViewModel.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-02-15.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import Parse

protocol SearchResultsViewModelType {
    var listings: Variable<[Listing]> { get }
//    var isLoading: Variable<Bool> { get set }
//    var isValid: Observable<Bool> { get }
    
    func fetchListingsByProximity()
    func populate(cell: SearchVehicleCellType, listing: Listing)
    func didSelectListing(at indexPath: IndexPath, delegate: SearchResultsControllerDelegate?)
}

class SearchResultsViewModel: SearchResultsViewModelType {
    var listings = Variable<[Listing]>([])
//    let isLoading: Driver<Bool>
//    let hasFailed: Driver<Bool>
    
    private let service = ListingsService()
    private let disposeBag = DisposeBag()
    
    internal func fetchListingsByProximity() {
        let testPoint = PFGeoPoint(latitude: 45.525616, longitude: -73.581354)
        
        service.fetchListingsByProximity(location: testPoint).subscribe { event in
            print(event)
            switch event {
            case let .next(listings):
                self.listings.value = listings + listings + listings
            case let .error(error):
                print(error)
            default:
                break
            }
        }.disposed(by: disposeBag)
    }
    
    func populate(cell: SearchVehicleCellType, listing: Listing) {
        cell.display(make: listing.make, model: listing.model)
        cell.display(price: listing.price)
    }
    
    internal func didSelectListing(at indexPath: IndexPath, delegate: SearchResultsControllerDelegate?) {
        let listing = listings.value[indexPath.row]
        
        delegate?.didSelect(listing: listing)
    }
    
}
