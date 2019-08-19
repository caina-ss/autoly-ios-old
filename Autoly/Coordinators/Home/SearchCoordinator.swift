//
//  SearchCoordinator.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-02-20.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import UIKit

class SearchCoordinator: RootViewCoordinator {
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
        homeController.delegate = self
        homeController.tabBarItem.image = #imageLiteral(resourceName: "HomeDisabledTabBar")
        homeController.tabBarItem.selectedImage = #imageLiteral(resourceName: "HomeEnabledTabBar")
        homeController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        self.navigationController.viewControllers = [homeController]
    }
    
}

extension SearchCoordinator: HomeControllerDelegate {
    
    internal func didTapAllProximity(homeController: HomeController) {
        guard let resultsController = controller(for: .searchResults, from: .search) as? SearchResultsController else { return }
        resultsController.delegate = self
        
        self.navigationController.pushViewController(resultsController, animated: true)
    }
    
}

extension SearchCoordinator: SearchResultsControllerDelegate {
    
    internal func didSelect(listing: Listing) {
        guard let listingController = controller(for: .listing, from: .search) as? ListingController else { return }
        listingController.viewModel = ListingViewModel(listing: listing)
        
        self.navigationController.pushViewController(listingController, animated: true)
    }
    
}
