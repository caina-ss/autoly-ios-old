//
//  ListingPhoto.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-04-04.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import Parse

class ListingPhoto: PFObject, PFSubclassing {
    @NSManaged var photo: PFFile?
    
    static func parseClassName() -> String {
        return String(describing: self)
    }
}
