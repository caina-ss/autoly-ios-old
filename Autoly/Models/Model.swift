//
//  Model.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-02-21.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import Parse

class Model: PFObject, PFSubclassing {
    @NSManaged var name: String?
    @NSManaged var make: Make?
    
    static func parseClassName() -> String {
        return String(describing: self)
    }
    
}

extension Model {
    
    struct Properties {
        static let make = "make"
    }
    
}
