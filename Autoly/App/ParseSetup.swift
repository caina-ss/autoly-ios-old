//
//  ParseSetup.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-02-15.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import Parse

class ParseSetup {
    
    class func initialize() {
        ParseSetup.registerSubclasses()
        ParseSetup.setupConnection()
    }
    
    class func setupConnection() {
        let configuration = ParseClientConfiguration {
            $0.applicationId = Config.Parse.credentials.appId
            $0.server = Config.Parse.credentials.url
            $0.clientKey = Config.Parse.credentials.clientKey
            $0.isLocalDatastoreEnabled = true
        }
        
        Parse.enableLocalDatastore()
        Parse.initialize(with: configuration)
    }
    
    class func registerSubclasses() {
        Installation.registerSubclass()
        User.registerSubclass()
        Make.registerSubclass()
        Model.registerSubclass()
        Color.registerSubclass()
        Fuel.registerSubclass()
        Transmission.registerSubclass()
        Listing.registerSubclass()
        ListingPhoto.registerSubclass()
        VehicleCategory.registerSubclass()
        Tag.registerSubclass()
    }
    
}
