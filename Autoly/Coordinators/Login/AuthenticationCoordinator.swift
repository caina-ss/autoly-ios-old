//
//  AuthenticationCoordinator.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-05-08.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import UIKit

protocol AuthenticationCoordinatorDelegate: class {
    func didCancelAuthentication(coordinator: AuthenticationCoordinator)
}

class AuthenticationCoordinator: RootViewCoordinator {
    // MARK: - Properties
    weak var delegate: AuthenticationCoordinatorDelegate?
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
        guard let tutorialController = controller(for: .tutorial, from: .authentication) as? TutorialController else { return }
        tutorialController.delegate = self
        
        self.navigationController.viewControllers = [tutorialController]
    }
    
}

extension AuthenticationCoordinator: TutorialControllerDelegate {
    
    internal func didCancelAuthentication(tutorialController: TutorialController) {
        delegate?.didCancelAuthentication(coordinator: self)
    }
    
    internal func didSelectSignup(tutorialController: TutorialController) {
        guard let signupController = controller(for: .signup, from: .authentication) as? SignupController else { return }
//        signupController.inject(viewModel: SignupViewModel())
        
        tutorialController.navigationController?.pushViewController(signupController, animated: true)
    }
    
    internal func didSelectLogin(tutorialController: TutorialController) {
        guard let loginController = controller(for: .login, from: .authentication) else { return }
        
        tutorialController.navigationController?.pushViewController(loginController, animated: true)
    }
    
}
