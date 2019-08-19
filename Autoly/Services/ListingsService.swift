//
//  ListingsService.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-02-21.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import Foundation
import RxSwift
import Parse

struct ListingPayload {
    var photos: [Data]?
    var make: Make?
    var model: Model?
    var year: Int?
    var price: Int?
    var color: Color?
    var kilometers: Int?
    var transmission: Transmission?
    var fuel: Fuel?
    var plate: Int?
    var category: VehicleCategory?
    var details: String?
}

class ListingsService {
    let disposeBag = DisposeBag()
    
    /**
     * Fetches all listings based on a location.
     *
     * - parameter user: The user who created the listing
     * - parameter limit: The limit of listings to be returned
     * - parameter skip: The amount of listings to be skipped
     * - return: An observable containing an array of listings
     */
    public func fetchListingsByProximity(location: PFGeoPoint, limit: Int = 100, skip: Int = 0) -> Observable<[Listing]> {
        let query = Listing.query()!
        
        query.whereKey(Listing.Properties.location, nearGeoPoint: location, withinKilometers: 15)
        query.includeKeys([Listing.Properties.make, Listing.Properties.model])
        query.limit = limit
        query.skip = skip
        
        return createObservableFor(query: query)
    }
    
    /**
     * Fetches all listings created by a specific user.
     *
     * - parameter user: The user who created the listing
     * - parameter limit: The limit of listings to be returned
     * - parameter skip: The amount of listings to be skipped
     * - return: An observable containing an array of listings
     */
    public func fetchListingsFor(user: User, limit: Int = 100, skip: Int = 0) -> Observable<[Listing]> {
        let query = Listing.query()!
        
        query.whereKey(Listing.Properties.user, equalTo: user)
        query.includeKeys([Listing.Properties.make, Listing.Properties.model])
        query.limit = limit
        query.skip = skip
        
        return createObservableFor(query: query)
    }
    
    public func createListing(_ payload: ListingPayload) -> Observable<Bool> {
        var photos: [ListingPhoto] = []
        
        for photoData in payload.photos ?? [] {
            let file = PFFile(data: photoData, contentType: "image/png")
            let listingPhoto = ListingPhoto()
            listingPhoto.photo = file
            
            photos.append(listingPhoto)
        }
        
        let listing = Listing()
        listing.photos = photos
        listing.make = payload.make
        listing.model = payload.model
        listing.year = NSNumber(value: payload.year ?? 0)
        listing.price = NSNumber(value: payload.price ?? 0)
        listing.color = payload.color
        listing.kilometers = NSNumber(value: payload.kilometers ?? 0)
        listing.transmission = payload.transmission
        listing.fuel = payload.fuel
        listing.plate = payload.plate?.description
        listing.category = payload.category
        listing.overview = payload.details
        listing.user = User.current()
        
        return listing.rx.save()
    }
    
    // MARK: PRIVATE
    
    private func createObservableFor(query: PFQuery<PFObject>) -> Observable<[Listing]> {
        let observable = Observable<[Listing]>.create { [weak self] observer in
            query.rx.findObjects().subscribe(onNext: { objects in
                guard let listings = objects as? [Listing] else {
                    observer.onNext([])
                    return
                }
                
                observer.onNext(listings)
            }, onError: { error in
                observer.onError(error)
            }, onCompleted: {
                observer.onCompleted()
            }).disposed(by: self!.disposeBag)
            
            return Disposables.create()
        }
        
        return observable
    }
    
    
    
}
