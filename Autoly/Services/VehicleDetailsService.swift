//
//  VehicleDetailsService.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-04-09.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import Foundation
import RxSwift

class VehicleDetailsService {
    
    public func fetchMakes() -> Observable<[Make]> {
        let query = Make.query()!
        query.order(byAscending: Make.Properties.name)
        
        return query.rx.findObjects().map { $0 as? [Make] ?? [] }
    }
    
    public func fetchModels(for make: Make) -> Observable<[Model]> {
        let query = Model.query()!
        query.whereKey(Model.Properties.make, equalTo: make)
        
        return query.rx.findObjects().map { $0 as? [Model] ?? [] }
    }
    
    public func fetchColors() -> Observable<[Color]> {
        let query = Color.query()!
        query.order(byAscending: Color.Properties.name)
        
        return query.rx.findObjects().map { $0 as? [Color] ?? [] }
    }
    
    public func fetchFuels() -> Observable<[Fuel]> {
        let query = Fuel.query()!
        query.order(byAscending: Fuel.Properties.name)
        
        return query.rx.findObjects().map { $0 as? [Fuel] ?? [] }
    }
    
    public func fetchTransmissions() -> Observable<[Transmission]> {
        let query = Transmission.query()!
        query.order(byAscending: Transmission.Properties.name)
        
        return query.rx.findObjects().map { $0 as? [Transmission] ?? [] }
    }
    
    public func fetchCategories() -> Observable<[VehicleCategory]> {
        let query = VehicleCategory.query()!
        query.order(byAscending: VehicleCategory.Properties.name)
        
        return query.rx.findObjects().map { $0 as? [VehicleCategory] ?? [] }
    }
    
    public func fetchTags() -> Observable<[Tag]> {
        let query = Tag.query()!
        query.order(byAscending: Tag.Properties.name)
        
        return query.rx.findObjects().map { $0 as? [Tag] ?? [] }
    }
    
}
