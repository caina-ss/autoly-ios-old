//
//  Make.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-02-21.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import Parse

class Make: PFObject, PFSubclassing {
    @NSManaged var name: String?
    
    static func parseClassName() -> String {
        return String(describing: self)
    }
    
}

extension Make {
    
    struct Properties {
        static let name = "name"
    }
    
}
