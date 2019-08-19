//
//  UsersService.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-05-24.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import Foundation
import Parse
import RxSwift

class UsersService {
    private struct Functions {
        static let requestVerificationToken = "requestVerificationToken"
        static let validatePhoneToken = "validatePhoneToken"
    }
    
    private let disposeBag = DisposeBag()
    
    /**
     * Creates a new user account using email and password
     *
     * - parameter email: The email address
     * - parameter password: The password chosen by the user
     * - returns: An Observable including a boolean flag whether the sign up process was successful or not
     */
    public func signUp(email: String, password: String) -> Observable<Bool> {
        let user = User()
        user.username = email
        user.password = password
        user.email = email
        
        return user.rx.signUp()
    }
    
    /**
     * Signs an user in based on email and password
     *
     * - parameter email: The email used to sign up
     * - parameter password: The password created when registered
     * - returns: An Observable including an Optional User object, being nil if operation is not successful
     */
    public func login(email: String, password: String) -> Observable<User?> {
        return User.rx.login(email, password: password).map { $0 as? User }
    }
    
    /**
     * Request an email to reset the user's password
     *
     * - parameter email: The email linked to the account
     * - returns: An Observable including a boolean whether the operation succeeded or not
     */
    public func resetPassword(email: String) -> Observable<Bool> {
        return User.rx.resetPassword(email)
    }
    
    /**
     * Logs an user out
     *
     * - returns: An Observable including a boolean whether the operation succeeded or not
     */
    public func logout() -> Observable<Bool> {
        return Observable<Bool>.create({ observer -> Disposable in
            User.rx.logout().subscribe(onNext: { error in
                if error == nil {
                    // Delete data linked to the current user or restore default values
                    
                }
                
                // Remove user from current installation
                self.unlinkUserFromInstallation()
                
                observer.onNext(error == nil)
            }, onError: { error in
                observer.onError(error)
            }, onCompleted: {
                observer.onCompleted()
            }).disposed(by: self.disposeBag)
            
            return Disposables.create()
        })
    }
    
    /**
     * Update the current installation with a device token data
     *
     * - parameter deviceToken: The device token received after registering for push notifications
     */
    public func save(deviceToken: Data) {
        let installation = Installation.current()
        installation?.setDeviceTokenFrom(deviceToken)
        installation?.user = User.current()
        installation?.saveEventually { success, error in
            print("Saving device token for push notification: \(success)")
            print("Saving device token for push notification error: \(error?.localizedDescription ?? "N/A")")
        }
    }
    
    /**
     * Requests a verification code sent by SMS to the phone number supplied
     *
     * - parameter phoneNumber: The phone number to receive the verification code by SMS
     * - parameter countryCode: The country code for the phone number supplied
     * - returns: An observable including a boolean flag whether the verification code has been sent or not
     */
    public func requestVerificationCode(phoneNumber: String, countryCode: String) -> Observable<Bool> {
        return Observable<Bool>.create { observer -> Disposable in
            let params: [AnyHashable: Any] = ["phoneNumber": phoneNumber, "countryCode": countryCode, "locale": "en"]
            
            PFCloud.rx.callFunction(Functions.requestVerificationToken, withParameters: params).subscribe { event in
                switch event {
                case .next(let response):
                    guard let data = response as? [String: Any], let success = data["success"] as? Bool else {
                        observer.onNext(false)
                        return
                    }
                    print(data)
                    
                    // Returns true if no user is found, telling the view controller to present next screen
                    observer.onNext(success)
                case .completed:
                    observer.onCompleted()
                case .error(let error):
                    observer.onError(error)
                }
                }.disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    /**
     * Validates a verification code received by SMS
     *
     * - parameter phoneNumber: The phone number to receive the verification code by SMS
     * - parameter countryCode: The country code for the phone number supplied
     * - returns: An observable including a boolean flag whether code has been validated or not
     */
    public func validate(code: String, phoneNumber: String, countryCode: String) -> Observable<Bool> {
        return Observable<Bool>.create { observer -> Disposable in
            let params: [AnyHashable: Any] = ["phoneNumber": phoneNumber, "countryCode": countryCode, "token": code]
            
            PFCloud.rx.callFunction(Functions.validatePhoneToken, withParameters: params).subscribe { event in
                switch event {
                case .next(let response):
                    guard let data = response as? [String: Any], let success = data["success"] as? Bool else {
                        observer.onNext(false)
                        return
                    }
                    print(data)
                    
                    // Returns true if no user is found, telling the view controller to present next screen
                    observer.onNext(success)
                case .completed:
                    observer.onCompleted()
                case .error(let error):
                    observer.onError(error)
                }
                }.disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    /**
     * Updates properties of the current user
     *
     * - parameter payload: An object with all data to be updated for the current user
     * - returns: An observable including a boolean flag whether the profile has been updated or not
     */
//    public func updateProfile(_ payload: ProfilePayload) -> Observable<Bool> {
//        guard let currentUser = User.current() else {
//            return Observable.just(false)
//        }
//        
//        currentUser.image = PFFile(name: "\(currentUser.objectId ?? "user_id")_avatar.jpg", data: payload.photoData!)
//        currentUser.firstName = payload.firstName
//        currentUser.lastName = payload.lastName
//        currentUser.birthDate = payload.birthdate
//        currentUser.address1 = payload.address1
//        currentUser.address2 = payload.address2
//        currentUser.city = payload.city
//        currentUser.state = payload.state
//        currentUser.country = payload.country
//        currentUser.phoneNumber = payload.phoneNumber
//        currentUser.countryCode = payload.countryCode
//        currentUser.emailDocuments = payload.email
//        currentUser.profileSetUp = NSNumber(booleanLiteral: true)
//        
//        return currentUser.rx.save()
//    }
    
    /**
     * Resets the installation badge number to zero
     */
    public func resetBadgeNumber() {
        guard let installation = Installation.current() else { return }
        
        installation.badge = 0
        installation.saveEventually { success, error in
            print("Updated badge number: \(success)")
            print("Badge update error: \(error?.localizedDescription ?? "n/a")")
        }
    }
    
    /**
     * Removes the user from the current installation so that this user doesn't receive
     * push notifications in this device after logging out
     */
    private func unlinkUserFromInstallation() {
        let installation = Installation.current()
        installation?.user = nil
        installation?.saveEventually()
    }
    
}
