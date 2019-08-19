//
//  ListingCreationCoordinator.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-04-08.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import UIKit
import Photos
import AVFoundation

protocol ListingCreationCoordinatorDelegate: class {
    func didCloseListingCreation(creationCoordinator: ListingCreationCoordinator)
}

class ListingCreationCoordinator: RootViewCoordinator {
    // MARK: - Properties
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    weak var delegate: ListingCreationCoordinatorDelegate?
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController(navigationBarClass: PWNavigationBar.self, toolbarClass: nil)
        navigationController.navigationBar.tintColor = .white
        
        if #available(iOS 11.0, *) {
            navigationController.navigationBar.prefersLargeTitles = true
        }
        
        return navigationController
    }()
    
    // MARK: - Functions
    
    func start() {
        guard let listingsController = controller(for: .creation, from: .creation) as? ListingCreationController else { return }
        listingsController.delegate = self
        
        self.navigationController.viewControllers = [listingsController]
    }
    
}

extension ListingCreationCoordinator: ListingCreationControllerDelegate {
    
    internal func didCancelListingCreation() {
        delegate?.didCloseListingCreation(creationCoordinator: self)
    }
    
    internal func didFinishSelectingItems() {
        for viewController in navigationController.viewControllers where viewController is ListingCreationController {
            navigationController.popToViewController(viewController, animated: true)
            break
        }
    }
    
    internal func didFinishListingCreation(_ listing: Listing?) {
        guard let tagsController = controller(for: .tags, from: .creation) as? TagsController else { return }
        tagsController.viewModel = TagsViewModel(listing: listing)
        
        self.navigationController.pushViewController(tagsController, animated: true)
    }
    
    internal func didSelectPicker(type: PickerType, extra: Any?, delegate: PickerControllerDelegate?) {
        guard let pickerController = controller(for: .picker, from: .creation) as? PickerController else { return }
        pickerController.viewModel = PickerViewModel(type: type, extra: extra)
        pickerController.delegate = delegate
        
        self.navigationController.pushViewController(pickerController, animated: true)
    }
    
    internal func didTapCamera(creationController: ListingCreationController) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
        
        AVCaptureDevice.requestAccess(for: .video) { success in
            DispatchQueue.main.async {
                guard success else {
                    creationController.alert(title: "Permissão negada".localized,
                                            message: "Precisamos de acesso à sua câmera. Por favor altere as suas configurações.".localized)
                    return
                }
                
                let picker = UIImagePickerController()
                picker.sourceType = UIImagePickerControllerSourceType.camera
                picker.delegate = creationController
                
                creationController.present(picker, animated: true, completion: nil)
            }
        }
    }
    
    internal func didTapPhotoGallery(creationController: ListingCreationController) {
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                guard status == .authorized else {
                    creationController.alert(title: "Permissão negada".localized,
                                             message: "Precisamos de acesso à sua galeria de fotos. Por favor altere as suas configurações.".localized)
                    return
                }
                
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.delegate = creationController
                picker.navigationBar.isTranslucent = false
                picker.navigationBar.barTintColor = .white
                picker.navigationBar.tintColor = .black
                picker.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black,
                                                            NSAttributedStringKey.font: Fonts.Circular.medium.size(16)]
                
                creationController.present(picker, animated: true, completion: nil)
            }
        }
    }
    
}
