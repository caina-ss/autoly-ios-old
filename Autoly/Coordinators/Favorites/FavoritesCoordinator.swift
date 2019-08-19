//
//  FavoritesCoordinator.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-04-08.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import UIKit

class FavoritesCoordinator: RootViewCoordinator {
    // MARK: - Properties
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController(navigationBarClass: PWNavigationBar.self, toolbarClass: nil)
        
        if #available(iOS 11.0, *) {
            navigationController.navigationBar.prefersLargeTitles = true
        }
        
        return navigationController
    }()
    
    // MARK: - Functions
    
    func start() {
        guard let listingsController = controller(for: .listings, from: .garage) as? ListingsController else { return }
        listingsController.tabBarItem.image = #imageLiteral(resourceName: "FavoritesDisabledTabBar")
        listingsController.tabBarItem.selectedImage = #imageLiteral(resourceName: "FavoritesEnabledTabBar")
        listingsController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        self.navigationController.viewControllers = [listingsController]
    }
    
}
