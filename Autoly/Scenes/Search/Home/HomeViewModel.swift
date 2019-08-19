//
//  HomeViewModel.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-02-22.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import Parse

protocol HomeViewModelType {
    var categories: Variable<[VehicleCategory]> { get }
    var closestListings: Variable<[Listing]> { get }
    var isLoadingListings: Variable<Bool> { get }
    
    func fetchCategories()
    func fetchListingsByProximity()
    func populate(cell: VehicleSuggestionCellType, listing: Listing)
}

class HomeViewModel: HomeViewModelType {
    var categories = Variable<[VehicleCategory]>([])
    var closestListings = Variable<[Listing]>([])
    var isLoadingListings = Variable<Bool>(false)
    
    private let listingsService = ListingsService()
    private let disposeBag = DisposeBag()
    
    /**
     * Fetch vehicles categories.
     */
    public func fetchCategories() {
//        let carCategory = VehicleCategory(name: "Carros", code: "car", icon: #imageLiteral(resourceName: "Car"))
//        let motorbikeCategory = VehicleCategory(name: "Motocicletas", code: "motorbike", icon: #imageLiteral(resourceName: "Motorbike"))
//        let truckCategory = VehicleCategory(name: "Caminhões", code: "truck", icon: #imageLiteral(resourceName: "Truck"))
//        let busCategory = VehicleCategory(name: "Ônibus", code: "bus", icon: #imageLiteral(resourceName: "Bus"))
        
        categories.value = []//[carCategory, motorbikeCategory, truckCategory, busCategory]
    }
    
    internal func fetchListingsByProximity() {
        let testPoint = PFGeoPoint(latitude: 45.525616, longitude: -73.581354)
        
        isLoadingListings.value = true
        
        listingsService.fetchListingsByProximity(location: testPoint, limit: 10).subscribe { event in
            print(event)
            self.isLoadingListings.value = false
            
            switch event {
            case let .next(listings):
                self.closestListings.value = listings
            case let .error(error):
                print(error)
            default:
                break
            }
            }.disposed(by: disposeBag)
    }
    
    internal func populate(cell: VehicleSuggestionCellType, listing: Listing) {
        cell.display(photo: nil)
        cell.displayDistance(from: listing.location)
    }
    
}
