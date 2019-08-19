//
//  Coordinator.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-02-20.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import Foundation

/// The Coordinator protocol
public protocol Coordinator: class {
    
    /// The services that the coordinator can use
    //    var services: Services { get }
    
    /// The array containing any child Coordinators
    var childCoordinators: [Coordinator] { get set }
    
}

public extension Coordinator {
    
    /// Add a child coordinator to the parent
    public func addChildCoordinator(_ childCoordinator: Coordinator) {
        self.childCoordinators.append(childCoordinator)
    }
    
    /// Remove a child coordinator from the parent
    public func removeChildCoordinator(_ childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== childCoordinator }
    }
    
}
