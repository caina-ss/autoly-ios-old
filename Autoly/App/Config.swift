//
//  Config.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-02-15.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import Foundation

struct Config {
    static let isProd = false
    
    struct Parse {
        private static let appId = "autoly-aw0S7RMDRnuzranwFE1a"
        private static let clientKey = "autoly-ck-cO5VQXgD28OuUZqLbJcd"
        private static let url = "https://autoly.herokuapp.com/api/v1"
        private static let devAppId = "autoly-aw0S7RMDRnuzranwFE1a"
        private static let devClientKey = "autoly-ck-cO5VQXgD28OuUZqLbJcd"
        private static let devUrl = "https://autoly.herokuapp.com/api/v1"
        
        /** Return Credentials according to isProd value */
        static var credentials: (appId: String, clientKey: String, url: String) {
            if isProd {
                return (appId: Parse.appId, clientKey: Parse.clientKey, url: Parse.url)
            } else {
                return (appId: Parse.devAppId, clientKey: Parse.devClientKey, url: Parse.devUrl)
            }
        }
    }
    
    struct App {
        /** Identifier on iTunes connect. Used for Rate the App */
        static let appStoreId = ""
        static let identifier = "br.com.papelweb.Autoly"
    }
    
}
