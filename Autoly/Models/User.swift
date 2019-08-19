//
//  User.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-02-21.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import Parse

class User: PFUser {
    @NSManaged var avatar: PFFile?
    @NSManaged var avatarThumb: PFFile?
    @NSManaged var name: String?
    @NSManaged var location: PFGeoPoint?
}
