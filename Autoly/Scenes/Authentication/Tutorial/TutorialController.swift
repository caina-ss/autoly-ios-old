//
//  TutorialController.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-05-22.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import UIKit
import RxSwift

protocol TutorialControllerDelegate: class {
    func didCancelAuthentication(tutorialController: TutorialController)
    func didSelectLogin(tutorialController: TutorialController)
    func didSelectSignup(tutorialController: TutorialController)
}

class TutorialController: UIViewController {
    @IBOutlet weak var signupButton: PWLoadingButton!
    @IBOutlet weak var loginButton: UIButton!
    
    weak var delegate: TutorialControllerDelegate?
    var isCloseButtonHidden = true
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupViewModel()
    }
    
}

extension TutorialController {
    
    private func setupUI() {
        if !isCloseButtonHidden {
            let closeButton = UIBarButtonItem(barButtonSystemItem: .stop, target: nil, action: nil)
            closeButton.tintColor = .black
            closeButton.rx.tap.bind { [weak self] in
                self?.delegate?.didCancelAuthentication(tutorialController: self!)
            }.disposed(by: disposeBag)
        }
    }
    
    private func setupViewModel() {
        signupButton.rx.tap.bind { [weak self] in
            self?.delegate?.didSelectSignup(tutorialController: self!)
            }.disposed(by: disposeBag)
        
        loginButton.rx.tap.bind { [weak self] in
            self?.delegate?.didSelectLogin(tutorialController: self!)
            }.disposed(by: disposeBag)
    }
    
}
