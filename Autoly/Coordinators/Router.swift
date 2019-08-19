//
//  Router.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-02-15.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import Foundation
import UIKit

public enum Storyboards: String {
    case main = "Main"
    case authentication = "Authentication"
    case search = "Search"
    case garage = "Garage"
    case creation = "Creation"
}

/* Define your routes here. For Login in Storyboard, add the LoginController identifier. You can then access it using Route.routeLogin.identifier.
 For Segues beetween screens name it like : FirstToSecond, then use : Route.routeFirst.to(.routeSecond)
 */
public enum Route: String {
    // Authentication
    case tutorial = "Tutorial"
    case login = "Login"
    case signup = "Signup"
    // Home
    case menu = "Menu"
    case home = "Home"
    // Search
    case searchResults = "SearchResults"
    case listing = "Listing"
    // Garage
    case listings = "Listings"
    case creation = "ListingCreation"
    case picker = "Picker"
    case tags = "Tags"
    
    /*! Return the view controller identifier */
    public var identifier: String {
        return "\(self.rawValue)Controller"
    }
    
    /*! Return the segue associated to the destination ex: LoginToSignup */
    public func to(_ to: Route) -> String {
        return "\(self.rawValue)To\(to.rawValue)"
    }
}

/**
 * Initialize a view controller from a route and storyboard
 * - params route The view controller identifier
 * - params storyboard The storyboard where the view controller is located
 */
public func controller(for route: Route, from storyboard: Storyboards) -> UIViewController? {
    let controller = UIStoryboard(name: storyboard.rawValue, bundle: nil).instantiateViewController(withIdentifier: route.identifier)
    
    return controller
}

