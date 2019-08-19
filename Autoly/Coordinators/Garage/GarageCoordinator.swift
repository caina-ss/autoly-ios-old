//
//  GarageCoordinator.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-04-06.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import UIKit

class GarageCoordinator: NSObject, RootViewCoordinator {
    // MARK: - Properties
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    private let transition = PWCircleTransition()
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController(navigationBarClass: PWNavigationBar.self, toolbarClass: nil)
        
        if #available(iOS 11.0, *) {
            navigationController.navigationBar.prefersLargeTitles = true
        }
        
        return navigationController
    }()
    
    // MARK: Initializer
    
    
    // MARK: - Functions
    
    func start() {
        guard let listingsController = controller(for: .listings, from: .garage) as? ListingsController else { return }
        listingsController.tabBarItem.image = #imageLiteral(resourceName: "WarehouseDisabledTabBar")
        listingsController.tabBarItem.selectedImage = #imageLiteral(resourceName: "WarehouseEnabledTabBar")
        listingsController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        listingsController.delegate = self
        
        self.navigationController.viewControllers = [listingsController]
    }
    
}

extension GarageCoordinator: ListingsControllerDelegate {
    
    internal func didSelectListingCreation(from point: CGPoint, transitionColor: UIColor?) {
        let creationCoordinator = ListingCreationCoordinator()
        creationCoordinator.start()
        creationCoordinator.delegate = self
        creationCoordinator.rootViewController.transitioningDelegate = self
        creationCoordinator.rootViewController.modalPresentationStyle = .custom
        
        transition.startingPoint = point
        transition.circleColor = transitionColor ?? .white
        
        self.addChildCoordinator(creationCoordinator)
        self.rootViewController.present(creationCoordinator.rootViewController, animated: true, completion: nil)
    }
    
}

extension GarageCoordinator: ListingCreationCoordinatorDelegate {
    
    internal func didCloseListingCreation(creationCoordinator: ListingCreationCoordinator) {
        creationCoordinator.rootViewController.dismiss(animated: true, completion: nil)
        
        self.removeChildCoordinator(creationCoordinator)
    }
    
}

extension GarageCoordinator: UIViewControllerTransitioningDelegate {
    
    internal func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        
        return transition
    }
    
    internal func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        
        return transition
    }
    
}
