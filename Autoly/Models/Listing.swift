//
//  Listing.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-02-21.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import Parse

class Listing: PFObject, PFSubclassing {
    @NSManaged var make: Make?
    @NSManaged var model: Model?
    @NSManaged var price: NSNumber?
    @NSManaged var year: NSNumber?
    @NSManaged var kilometers: NSNumber?
    @NSManaged var color: Color?
    @NSManaged var transmission: Transmission?
    @NSManaged var fuel: Fuel?
    @NSManaged var plate: String?
    @NSManaged var category: VehicleCategory?
    @NSManaged var overview: String?
    @NSManaged var location: PFGeoPoint?
    @NSManaged var tags: [String]?
    @NSManaged var photos: [ListingPhoto]?
    @NSManaged var user: User?
//    @NSManaged var dealership: Dealership?
    
    static func parseClassName() -> String {
        return String(describing: self)
    }
}

extension Listing {
    
    struct Properties {
        static let make = "make"
        static let model = "model"
        static let price = "price"
        static let year = "year"
        static let kilometers = "kilometers"
        static let color = "color"
        static let transmission = "transmission"
        static let fuel = "fuel"
        static let plate = "plate"
        static let category = "category"
        static let location = "location"
        static let tags = "tags"
        static let user = "user"
    }
    
}
