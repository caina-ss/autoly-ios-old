//
//  AppCoordinator.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-02-20.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import Foundation
import UIKit

/// The AppCoordinator is our first coordinator
/// In this example the AppCoordinator as a rootViewController
class AppCoordinator: NSObject, RootViewCoordinator {
    
    // MARK: - Properties
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        return self.tabBarController
    }
    
    /// Window to manage
    var window: UIWindow?
    
    private lazy var tabBarController: UITabBarController = {
        let tabBarController = PWTabBarController()
        tabBarController.delegate = self
        
        return tabBarController
    }()
    
    // MARK: - Init
    
    public init(window: UIWindow) {
        super.init()
        
        self.window = window
        self.window?.rootViewController = self.rootViewController
        self.window?.makeKeyAndVisible()
    }
    
    // MARK: - Functions
    
    /// Starts the coordinator
    public func start() {
        setupTabBar()
    }
    
    /// Creates a new TutorialViewController and places it into the navigation controller
    private func setupTabBar() {
        // Create search coordinator
        let searchCoordinator = SearchCoordinator()
        searchCoordinator.start()
        
        self.addChildCoordinator(searchCoordinator)
        
        // Create favorites coordinator
        let favoritesCoordinator = FavoritesCoordinator()
        favoritesCoordinator.start()
        
        self.addChildCoordinator(favoritesCoordinator)
        
        // Create garage coordinator
        let garageCoordinator = GarageCoordinator()
        garageCoordinator.start()
        
        self.addChildCoordinator(garageCoordinator)
        
        // Create messages coordinator
        let messagesCoordinator = MessagesCoordinator()
        messagesCoordinator.start()
        
        self.addChildCoordinator(messagesCoordinator)
        
        self.tabBarController.viewControllers = [searchCoordinator.rootViewController,
                                                 favoritesCoordinator.rootViewController,
                                                 garageCoordinator.rootViewController,
                                                 messagesCoordinator.rootViewController]
    }
    
    private func startLoginCoordinator() {
        // Create messages coordinator
        let loginCoordinator = AuthenticationCoordinator()
        loginCoordinator.start()
        
        self.addChildCoordinator(loginCoordinator)
        self.tabBarController.present(loginCoordinator.rootViewController, animated: true, completion: nil)
    }
    
}

extension AppCoordinator: UITabBarControllerDelegate {
    
    internal func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print(#function)
        print(viewController)
        guard let navController = viewController as? UINavigationController,
            let controller = navController.viewControllers.first
            else { return true }
        
        if controller is ListingsController {
//            guard User.current() != nil else {
//                startLoginCoordinator()
//                return false
//            }
            
            return true
        }
        
        return true
    }
    
}
