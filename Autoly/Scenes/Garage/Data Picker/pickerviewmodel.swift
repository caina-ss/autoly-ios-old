//
//  PickerViewModel.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-04-09.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol PickerViewModelType {
    var items: Variable<[Any]> { get }
    var isLoading: Driver<Bool> { get }
    var selectedItemType: PickerType { get }
    
    func populate(cell: SingleLabelCellType, item: Any)
    func item(for indexPath: IndexPath) -> Any
}

public enum PickerType {
    case makes, models, colors, transmissions, fuels, kilometers, plate, price, year, categories
}

class PickerViewModel: PickerViewModelType {
    let items = Variable<[Any]>([])
    let isLoading: Driver<Bool>
    
    var selectedItemType: PickerType {
        return self.type
    }
    
    private let isLoadingVariable = Variable(false)
    private let disposeBag = DisposeBag()
    private var type: PickerType
    private lazy var vehicleDetailsService: VehicleDetailsService = {
        return VehicleDetailsService()
    }()
    
    init(type: PickerType, extra: Any? = nil) {
        self.type = type
        self.isLoading = isLoadingVariable.asDriver()
        
        switch type {
        case .makes:
            fetchMakes()
        case .models:
            fetchModelsFor(make: extra as? Make)
        case .colors:
            fetchColors()
        case .fuels:
            fetchFuels()
        case .transmissions:
            fetchTransmissions()
        case .categories:
            fetchVehicleCategories()
        default:
            break
        }
    }
    
    internal func populate(cell: SingleLabelCellType, item: Any) {
        switch self.type {
        case .makes:
            guard let make = item as? Make else { return }
            cell.display(text: make.name)
        case .models:
            guard let model = item as? Model else { return }
            cell.display(text: model.name)
        case .colors:
            guard let color = item as? Color else { return }
            cell.display(text: color.name)
        case .fuels:
            guard let fuel = item as? Fuel else { return }
            cell.display(text: fuel.name)
        case .transmissions:
            guard let transmission = item as? Transmission else { return }
            cell.display(text: transmission.name)
        case .categories:
            guard let category = item as? VehicleCategory else { return }
            cell.display(text: category.name)
        default:
            break
        }
    }
    
    internal func item(for indexPath: IndexPath) -> Any {
        return items.value[indexPath.row]
    }
    
}

// MARK: Private

extension PickerViewModel {
    
    private func fetchMakes() {
        isLoadingVariable.value = true
        
        vehicleDetailsService.fetchMakes().subscribe(onNext: { makes in
            print(makes)
            self.items.value = makes
            self.isLoadingVariable.value = false
        }, onError: { error in
            print(error.localizedDescription)
            
            self.items.value = []
            self.isLoadingVariable.value = false
        }).disposed(by: disposeBag)
    }
    
    private func fetchModelsFor(make: Make?) {
        guard make != nil else { return }
        
        isLoadingVariable.value = true
        
        vehicleDetailsService.fetchModels(for: make!).subscribe(onNext: { makes in
            print(makes)
            self.items.value = makes
            self.isLoadingVariable.value = false
        }, onError: { error in
            print(error.localizedDescription)
            
            self.items.value = []
            self.isLoadingVariable.value = false
        }).disposed(by: disposeBag)
    }
    
    private func fetchColors() {
        isLoadingVariable.value = true
        
        vehicleDetailsService.fetchColors().subscribe(onNext: { makes in
            print(makes)
            self.items.value = makes
            self.isLoadingVariable.value = false
        }, onError: { error in
            print(error.localizedDescription)
            
            self.items.value = []
            self.isLoadingVariable.value = false
        }).disposed(by: disposeBag)
    }
    
    private func fetchFuels() {
        isLoadingVariable.value = true
        
        vehicleDetailsService.fetchFuels().subscribe(onNext: { makes in
            print(makes)
            self.items.value = makes
            self.isLoadingVariable.value = false
        }, onError: { error in
            print(error.localizedDescription)
            
            self.items.value = []
            self.isLoadingVariable.value = false
        }).disposed(by: disposeBag)
    }
    
    private func fetchTransmissions() {
        isLoadingVariable.value = true
        
        vehicleDetailsService.fetchTransmissions().subscribe(onNext: { makes in
            print(makes)
            self.items.value = makes
            self.isLoadingVariable.value = false
        }, onError: { error in
            print(error.localizedDescription)
            
            self.items.value = []
            self.isLoadingVariable.value = false
        }).disposed(by: disposeBag)
    }
    
    private func fetchVehicleCategories() {
        isLoadingVariable.value = true
        
        vehicleDetailsService.fetchCategories().subscribe(onNext: { categories in
            print(categories)
            self.items.value = categories
            self.isLoadingVariable.value = false
        }, onError: { error in
            print(error.localizedDescription)
            
            self.items.value = []
            self.isLoadingVariable.value = false
        }).disposed(by: disposeBag)
    }
    
}
