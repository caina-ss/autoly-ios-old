//
//  SignupViewModel.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-05-24.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import Foundation
import RxSwift

protocol SignupViewModelType {
    var emailText: Variable<String> { get set }
    var passwordText: Variable<String> { get set }
    var passwordConfirmationText: Variable<String> { get set }
    var isLoading: Variable<Bool> { get }
    var isValid: Observable<Bool> { get }
    
    func signUp() -> Observable<Bool>
}

class SignupViewModel: SignupViewModelType {
    var emailText = Variable<String>("")
    var passwordText = Variable<String>("")
    var passwordConfirmationText = Variable<String>("")
    var isLoading = Variable<Bool>(false)
    
    var isValid: Observable<Bool> {
        let email = emailText
            .asDriver()
            .distinctUntilChanged()
            .throttle(0.3)
            .map { $0.isValidEmail }
        
        let password = passwordText
            .asDriver()
            .distinctUntilChanged()
            .throttle(0.3)
            .map { $0.isValidPassword }
        
        let passwordConfirmation = passwordConfirmationText
            .asDriver()
            .distinctUntilChanged()
            .throttle(0.3)
            .map { $0.isValidPassword }
        
        return Observable.combineLatest(email.asObservable(), password.asObservable(), passwordConfirmation.asObservable()) { email, password, passwordConfirmation in
            email && password && passwordConfirmation && (self.passwordText.value == self.passwordConfirmationText.value)
        }
    }
    
    // Private variables
    private let userService = UsersService()
    private let disposeBag = DisposeBag()
    
    internal func signUp() -> Observable<Bool> {
        return Observable<Bool>
            .just(false)
            .do { self.isLoading.value = true }
            .flatMapLatest { _ -> Observable<Bool> in
                return self.userService.signUp(email: self.emailText.value,
                                               password: self.passwordText.value)
            }
            .do { self.isLoading.value = false }
    }
    
}
