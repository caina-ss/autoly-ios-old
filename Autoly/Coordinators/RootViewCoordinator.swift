//
//  RootViewCoordinator.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-02-20.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import Foundation
import UIKit

public protocol RootViewControllerProvider: class {
    // The coordinators 'rootViewController'. It helps to think of this as the view
    // controller that can be used to dismiss the coordinator from the view hierarchy.
    var rootViewController: UIViewController { get }
}

/// A Coordinator type that provides a root UIViewController
public typealias RootViewCoordinator = Coordinator & RootViewControllerProvider
