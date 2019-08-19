//
//  VehicleCategory.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-02-22.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import Parse

class VehicleCategory: PFObject, PFSubclassing {
    @NSManaged var name: String?
    @NSManaged var icon: PFFile?
    
    static func parseClassName() -> String {
        return String(describing: self)
    }
}

extension VehicleCategory {
    
    struct Properties {
        static let name = "name"
    }
    
}
