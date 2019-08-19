//
//  ListingCreationController.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-04-08.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

protocol ListingCreationControllerDelegate: class {
    func didCancelListingCreation()
    func didSelectPicker(type: PickerType, extra: Any?, delegate: PickerControllerDelegate?)
    func didTapCamera(creationController: ListingCreationController)
    func didTapPhotoGallery(creationController: ListingCreationController)
    func didFinishSelectingItems()
    func didFinishListingCreation(_ listing: Listing?)
}

class ListingCreationController: UIViewController {
    @IBOutlet weak var closeButton: UIBarButtonItem!
//    @IBOutlet weak var photosCollectionView: UICollectionView!
    @IBOutlet weak var makesButton: UIButton!
    @IBOutlet weak var modelsButton: UIButton!
//    @IBOutlet weak var yearButton: UIButton!
//    @IBOutlet weak var priceButton: UIButton!
//    @IBOutlet weak var colorsButton: UIButton!
//    @IBOutlet weak var kilometersButton: UIButton!
//    @IBOutlet weak var transmissionsButton: UIButton!
//    @IBOutlet weak var fuelsButton: UIButton!
//    @IBOutlet weak var plateButton: UIButton!
//    @IBOutlet weak var categoryButton: UIButton!
//    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var saveButton: PWLoadingButton!
    
    weak var delegate: ListingCreationControllerDelegate?
    
    private let disposeBag = DisposeBag()
    private let viewModel = ListingCreationViewModel()
    private var photosDataSource: RxCollectionViewSectionedReloadDataSource<SectionModel<String, Data?>>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup UI elements
        setupUI()
        
        // Setup view model
        setupBindings()
        
        // Setup data source for photos
        setupPhotosDataSource()
    }
    
}

extension ListingCreationController {
    
    private func setupUI() {
        // Configure photos collection view
//        photosCollectionView.register(ListingCreationPhotoCell.self)
//        photosCollectionView.register(ListingCreationSelectPhotoCell.self)
//        photosCollectionView.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        
//        detailsTextView.textContainerInset = .zero
//        detailsTextView.textContainer.lineFragmentPadding = 0
        
        saveButton.type = .secondary
    }
    
    private func setupBindings() {
        // Bind to tap action of close button
        closeButton.rx.tap.bind {
            self.delegate?.didCancelListingCreation()
            }.disposed(by: disposeBag)
        
        makesButton.rx.tap.bind {
            self.delegate?.didSelectPicker(type: .makes, extra: nil, delegate: self)
            }.disposed(by: disposeBag)
        
        modelsButton.rx.tap.bind {
            guard let make = self.viewModel.selectedMake.value else {
                self.alert(title: "Marca não selecionada".localized,
                           message: "Por favor selecione uma marca.".localized)
                return
            }
            
            self.delegate?.didSelectPicker(type: .models, extra: make, delegate: self)
            }.disposed(by: disposeBag)
        
//        colorsButton.rx.tap.bind {
//            self.delegate?.didSelectPicker(type: .colors, extra: nil, delegate: self)
//            }.disposed(by: disposeBag)
        
//        fuelsButton.rx.tap.bind {
//            self.delegate?.didSelectPicker(type: .fuels, extra: nil, delegate: self)
//            }.disposed(by: disposeBag)
        
//        transmissionsButton.rx.tap.bind {
//            self.delegate?.didSelectPicker(type: .transmissions, extra: nil, delegate: self)
//            }.disposed(by: disposeBag)
        
//        yearButton.rx.tap.bind {
//            self.presentYearAlert()
//            }.disposed(by: disposeBag)
        
//        priceButton.rx.tap.bind {
//            self.presentPriceAlert()
//            }.disposed(by: disposeBag)
        
//        kilometersButton.rx.tap.bind {
//            self.presentKilometersAlert()
//            }.disposed(by: disposeBag)
        
//        plateButton.rx.tap.bind {
//            self.presentPlateAlert()
//            }.disposed(by: disposeBag)
        
//        categoryButton.rx.tap.bind {
//            self.delegate?.didSelectPicker(type: .categories, extra: nil, delegate: self)
//            }.disposed(by: disposeBag)
        
        // Bind view model changes
        viewModel.selectedMake
            .asDriver().map { $0?.name ?? "Selecione".localized }
            .drive(makesButton.rx.title()).disposed(by: disposeBag)
        viewModel.selectedModel
            .asDriver().map { $0?.name ?? "Selecione".localized }
            .drive(modelsButton.rx.title()).disposed(by: disposeBag)
//        viewModel.selectedFuel
//            .asDriver().map { $0?.name ?? "Selecione".localized }
//            .drive(fuelsButton.rx.title()).disposed(by: disposeBag)
//        viewModel.selectedColor
//            .asDriver().map { $0?.name ?? "Selecione".localized }
//            .drive(colorsButton.rx.title()).disposed(by: disposeBag)
//        viewModel.selectedTransmission
//            .asDriver().map { $0?.name ?? "Selecione".localized }
//            .drive(transmissionsButton.rx.title()).disposed(by: disposeBag)
//        viewModel.kilometers
//            .asDriver().map { $0?.description != nil ? String(format: "%@ km", $0!.description) : "Selecione".localized }
//            .drive(kilometersButton.rx.title()).disposed(by: disposeBag)
//        viewModel.plate
//            .asDriver().map { $0?.description ?? "Selecione".localized }
//            .drive(plateButton.rx.title()).disposed(by: disposeBag)
//        viewModel.year
//            .asDriver().map { $0?.description ?? "Selecione".localized }
//            .drive(yearButton.rx.title()).disposed(by: disposeBag)
//        viewModel.selectedCategory
//            .asDriver().map { $0?.name ?? "Selecione".localized }
//            .drive(categoryButton.rx.title()).disposed(by: disposeBag)
//        viewModel.price
//            .asDriver().map { price in
//                guard price != nil else { return "Selecione".localized }
//
//                let numberFormatter = NumberFormatter()
//                numberFormatter.numberStyle = .currency
//                numberFormatter.locale = Locale(identifier: "pt-BR")
//
//                return numberFormatter.string(from: NSNumber(value: price!)) ?? "Selecione".localized
//            }
//            .drive(priceButton.rx.title()).disposed(by: disposeBag)
        
        // Bind extra details text to view model
//        detailsTextView.rx.text.bind(to: viewModel.extraDetails).disposed(by: disposeBag)
        
        // Bind login button enabled state with view model
        viewModel.isValid.bind(to: saveButton.rx.isEnabled).disposed(by: disposeBag)
        
        // Subscribe to events on password validity changes
        viewModel.isValid.subscribe(onNext: { isValid in
            self.saveButton.type = isValid ? .primary : .disabled
        }).disposed(by: disposeBag)
        
        // Bind to isLoading to update button title
        viewModel.isLoading.asDriver().drive(saveButton.rx.isLoading).disposed(by: disposeBag)
        
        // Bind to save button tap action
        saveButton.rx.tap.bind {
            self.saveListing()
        }.disposed(by: disposeBag)
    }
    
    private func setupPhotosDataSource() {
        // Initialize data source
        photosDataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, Data?>>(configureCell: { (_, collectionView, indexPath, imageData) -> UICollectionViewCell in
            if indexPath.section == 0 {
                let cell: ListingCreationPhotoCell = collectionView.dequeueReusableCell(for: indexPath)
                
                cell.displayPhoto(from: imageData)
                
                return cell
            } else {
                let cell: ListingCreationSelectPhotoCell = collectionView.dequeueReusableCell(for: indexPath)
                
                return cell
            }
        })
        
        // Bind data source to table view
//        viewModel.photosSections
//            .asObservable()
//            .bind(to: photosCollectionView.rx.items(dataSource: photosDataSource))
//            .disposed(by: disposeBag)
        
        // Bind to item selection event
//        photosCollectionView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
//            if indexPath.section == 0 {
//                // Present action sheet to delete photo
//                self?.presentDeleteOption(indexPath: indexPath)
//            } else {
//                // Present action sheet to select new photo
//                self?.presentPhotoPicker()
//            }
//        }).disposed(by: disposeBag)
        
//        photosCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
 
    private func presentPhotoPicker() {
        print(#function)
        // Option to take picture
        let takePictureOption: (title: String, handler: () -> Void, style: UIAlertActionStyle) = ("Tirar foto".localized, {
            self.delegate?.didTapCamera(creationController: self)
        }, .default)
        
        // Option to open photo gallery
        let galleryOption: (title: String, handler: () -> Void, style: UIAlertActionStyle) = ("Galeria".localized, {
            self.delegate?.didTapPhotoGallery(creationController: self)
        }, .default)
        
        actionSheet(title: nil, options: [takePictureOption, galleryOption])
    }
    
    private func presentDeleteOption(indexPath: IndexPath) {
        print(#function)
        // Option to remove photo
        let removePhotoOption: (title: String, handler: () -> Void, style: UIAlertActionStyle) = ("Remover foto".localized, {
            self.viewModel.removePhoto(at: indexPath)
        }, .destructive)
        
        actionSheet(title: nil, options: [removePhotoOption])
    }
    
}

extension ListingCreationController {
    
    private func presentPriceAlert() {
        alertTextField(title: "Preço".localized,
                       message: "Informe o valor do veículo.\nExemplo: para R$34.990,00, informe 34990".localized,
                       placeholder: "Preço",
                       keyboardType: .numberPad,
                       isSecure: false) { price in
                        guard let priceInt = Int(price) else { return }
                        
                        self.viewModel.updateValue(priceInt, for: .price)
        }
    }
    
    private func presentKilometersAlert() {
        alertTextField(title: "Quilometragem".localized,
                       message: "Informe a quantidade de quilômetros já percorridos pelo veículo.".localized,
                       placeholder: "Quilometragem",
                       keyboardType: .numberPad,
                       isSecure: false) { kilometers in
                        guard let kilometersInt = Int(kilometers) else { return }
                        
                        self.viewModel.updateValue(kilometersInt, for: .kilometers)
        }
    }
    
    private func presentPlateAlert() {
        alertTextField(title: "Final da placa".localized,
                       message: "Informe o último número da placa do veículo.".localized,
                       placeholder: "Final da placa",
                       keyboardType: .numberPad,
                       isSecure: false) { plate in
                        guard let plateInt = Int(plate) else { return }
                        
                        self.viewModel.updateValue(plateInt, for: .plate)
        }
    }
    
    private func presentYearAlert() {
        alertTextField(title: "Ano de fabricação".localized,
                       message: "Informe o ano de fabricação do veículo.".localized,
                       placeholder: "Ano",
                       keyboardType: .numberPad,
                       isSecure: false) { year in
                        guard let yearInt = Int(year) else { return }
                        
                        self.viewModel.updateValue(yearInt, for: .year)
        }
    }
    
    private func saveListing() {
        delegate?.didFinishListingCreation(nil)
//        self.viewModel.save().subscribe(onNext: { success in
//            print("SAVED!")
//            guard success else {
//                // FIXME show alert
//                return
//            }
//
//            self.delegate?.didFinishListingCreation()
//        }, onError: { error in
//            self.alert(title: "Não foi possível criar seu anúncio", message: error.localizedDescription)
//        }).disposed(by: disposeBag)
    }
    
}

extension ListingCreationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    internal func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        guard let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            picker.dismiss(animated: true) {
                self.alert(title: "Tente novamente".localized,
                           message: "A imagem não pôde ser processada no momento.".localized)
            }
            return
        }
        
        if let pictureData = UIImageJPEGRepresentation(pickedImage, 0.6) {
            viewModel.addPhotoData(pictureData)
        }
        
//        photosCollectionView.scrollToItem(at: IndexPath(item: 0, section: 1),
//                                          at: .right,
//                                          animated: true)
        
        picker.dismiss(animated: true)
    }
    
}

extension ListingCreationController: UICollectionViewDelegateFlowLayout {
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return viewModel.sizeForHeader(at: section)
    }
    
}

extension ListingCreationController: PickerControllerDelegate {
    
    internal func didSelect(item: Any, type: PickerType) {
        viewModel.updateValue(item, for: type)
        delegate?.didFinishSelectingItems()
    }
    
}
