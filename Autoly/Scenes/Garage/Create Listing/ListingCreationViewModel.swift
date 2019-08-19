//
//  ListingCreationViewModel.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-04-10.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

protocol ListingCreationViewModelType {
    var photosSections: Variable<[SectionModel<String, Data?>]> { get }
    var selectedMake: Variable<Make?> { get }
    var selectedModel: Variable<Model?> { get }
    var selectedColor: Variable<Color?> { get }
    var year: Variable<Int?> { get }
    var price: Variable<Int?> { get }
    var kilometers: Variable<Int?> { get }
    var selectedTransmission: Variable<Transmission?> { get }
    var selectedFuel: Variable<Fuel?> { get }
    var plate: Variable<Int?> { get }
    var selectedCategory: Variable<VehicleCategory?> { get }
    var extraDetails: Variable<String?> { get }
    var isLoading: Variable<Bool> { get }
    var isValid: Observable<Bool> { get }
    
    func addPhotoData(_ photoData: Data)
    func removePhoto(at indexPath: IndexPath)
    func updateValue(_ value: Any, for type: PickerType)
    func sizeForHeader(at section: Int) -> CGSize
    func save() -> Observable<Bool>
}

class ListingCreationViewModel: ListingCreationViewModelType {
    var photosSections = Variable<[SectionModel<String, Data?>]>([])
    var selectedMake = Variable<Make?>(nil)
    var selectedModel = Variable<Model?>(nil)
    var selectedColor = Variable<Color?>(nil)
    var year = Variable<Int?>(nil)
    var price = Variable<Int?>(nil)
    var kilometers = Variable<Int?>(nil)
    var selectedTransmission = Variable<Transmission?>(nil)
    var selectedFuel = Variable<Fuel?>(nil)
    var plate = Variable<Int?>(nil)
    var selectedCategory = Variable<VehicleCategory?>(nil)
    var extraDetails = Variable<String?>(nil)
    var isLoading = Variable<Bool>(false)
    
    var isValid: Observable<Bool> {
        return Observable.combineLatest(selectedMake.asObservable(),
                                        selectedModel.asObservable(),
                                        year.asObservable(),
                                        price.asObservable()) { make, model, year, price in
                                            return true
                                            // FIXME
                                            (make != nil) &&
                                            (model != nil) &&
                                            (year != nil) &&
                                            (price != nil)
        }
    }
    
    private let listingsService = ListingsService()
    private var photos: [Data] = [] {
        didSet {
            self.updateDataSource()
        }
    }
    
    init() {
        self.updateDataSource()
    }
    
    internal func addPhotoData(_ photoData: Data) {
        photos.append(photoData)
    }
    
    internal func removePhoto(at indexPath: IndexPath) {
        photos.remove(at: indexPath.row)
    }
    
    internal func updateValue(_ value: Any, for type: PickerType) {
        switch type {
        case .makes:
            self.selectedMake.value = value as? Make
        case .models:
            self.selectedModel.value = value as? Model
        case .colors:
            self.selectedColor.value = value as? Color
        case .fuels:
            self.selectedFuel.value = value as? Fuel
        case .transmissions:
            self.selectedTransmission.value = value as? Transmission
        case .kilometers:
            self.kilometers.value = value as? Int
        case .plate:
            self.plate.value = value as? Int
        case .price:
            self.price.value = value as? Int
        case .year:
            self.year.value = value as? Int
        case .categories:
            self.selectedCategory.value = value as? VehicleCategory
        }
    }
    
    internal func sizeForHeader(at section: Int) -> CGSize {
        guard section == 1 else { return .zero }
        
        return photos.count > 0 ? CGSize(width: 12, height: 0) : .zero
    }
    
    internal func save() -> Observable<Bool> {
        var payload = ListingPayload()
        payload.photos = self.photos
        payload.make = self.selectedMake.value
        payload.model = self.selectedModel.value
        payload.price = self.price.value
        payload.color = self.selectedColor.value
        payload.kilometers = self.kilometers.value
        payload.transmission = self.selectedTransmission.value
        payload.fuel = self.selectedFuel.value
        payload.plate = self.plate.value
        payload.details = self.extraDetails.value
        payload.year = self.year.value
        payload.category = self.selectedCategory.value
        
        return Observable<Bool>
            .just(false)
            .do { self.isLoading.value = true }
            .flatMapLatest { _ -> Observable<Bool> in
                self.listingsService.createListing(payload)
            }
            .do { self.isLoading.value = false }
    }
    
}

extension ListingCreationViewModel {
    
    private func updateDataSource() {
        photosSections.value = [SectionModel(model: "", items: photos),
                                SectionModel(model: "", items: [nil])]
    }
    
}
