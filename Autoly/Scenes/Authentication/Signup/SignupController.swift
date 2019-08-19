//
//  SignupController.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-05-24.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import UIKit
import RxSwift

class SignupController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordConfirmationField: UITextField!
    @IBOutlet weak var signupButton: PWLoadingButton!
    
    private let disposeBag = DisposeBag()
    private let viewModel = SignupViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup UI elements
        setupUI()
        
        // Setup bindings
        setupBindings()
    }
}

// MARK: Private
extension SignupController {
    
    private func setupUI() {
        
    }
    
    private func setupBindings() {
        // Bind text field with view model
        emailField.rx.text.map { $0 ?? "" }.bind(to: viewModel.emailText).disposed(by: disposeBag)
        passwordField.rx.text.map { $0 ?? "" }.bind(to: viewModel.passwordText).disposed(by: disposeBag)
        passwordConfirmationField.rx.text.map { $0 ?? "" }.bind(to: viewModel.passwordConfirmationText).disposed(by: disposeBag)
        
        // Bind login button enabled state with view model
        viewModel.isValid.bind(to: signupButton.rx.isEnabled).disposed(by: disposeBag)
        
        // Bind to isLoading to update button title
        viewModel.isLoading.asDriver().drive(signupButton.rx.isLoading).disposed(by: disposeBag)
        
        // Bind to tap gesture on sign up button
        signupButton.rx.tap.bind { [unowned self] in
            self.viewModel.signUp().subscribe(onNext: { canProceed in
                if canProceed {
                    print("Sign up finished! Can proceed!")
//                    self.delegate?.didCompleteSignup(signupPasswordController: self)
                } else {
                    self.alert(title: "Oops".localized, message: "Não foi possível processar seu cadastro nesse momento. Por favor tente novamente.".localized)
                }
            }, onError: { error in
                self.alert(title: "Oops".localized, message: error.localizedDescription)
            }).disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
    }
    
}
