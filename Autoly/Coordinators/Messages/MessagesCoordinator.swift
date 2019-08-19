//
//  MessagesCoordinator.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-04-03.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import UIKit

class MessagesCoordinator: RootViewCoordinator {
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
        guard let homeController = controller(for: .home, from: .search) as? HomeController else { return }
//        homeController.delegate = self
        homeController.tabBarItem.image = #imageLiteral(resourceName: "MessagesDisabledTabBar")
        homeController.tabBarItem.selectedImage = #imageLiteral(resourceName: "MessagesEnabledTabBar")
        homeController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        self.navigationController.viewControllers = [homeController]
    }
    
}
