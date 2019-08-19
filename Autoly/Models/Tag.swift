//
//  Tag.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-04-17.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import Parse

class Tag: PFObject, PFSubclassing {
    @NSManaged var name: String?
    
    static func parseClassName() -> String {
        return String(describing: self)
    }
    
}

extension Tag {
    
    struct Properties {
        static let name = "name"
    }
    
}
