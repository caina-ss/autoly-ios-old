//
//  Fuel.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-04-10.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import Parse

class Fuel: PFObject, PFSubclassing {
    @NSManaged var name: String?
    
    static func parseClassName() -> String {
        return String(describing: self)
    }
    
}

extension Fuel {
    
    struct Properties {
        static let name = "name"
    }
    
}
