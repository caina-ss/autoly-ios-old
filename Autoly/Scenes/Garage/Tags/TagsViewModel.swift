//
//  TagsViewModel.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-04-17.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol TagsViewModelType {
    var tags: Variable<[Tag]> { get }
    var hasSelectedTags: Driver<Bool> { get }
    var isLoading: Driver<Bool> { get }
    
    func fetchTags()
    func populateTag(cell: TagCellType, at row: Int)
    func updateSelectionForTag(at indexPath: IndexPath)
}

class TagsViewModel: TagsViewModelType {
    var tags = Variable<[Tag]>([])
    var isLoading: Driver<Bool>
    var hasSelectedTags: Driver<Bool>
    
    private let vehicleDetailsService = VehicleDetailsService()
    private let isLoadingVariable = Variable(false)
    private let hasSelectedTagsVariable = Variable(false)
    private let disposeBag = DisposeBag()
    private var listing: Listing?
    private var selectedTags: [Tag] = []
    
    init(listing: Listing?) {
        self.listing = listing
        self.isLoading = isLoadingVariable.asDriver()
        self.hasSelectedTags = hasSelectedTagsVariable.asDriver()
    }
    
    internal func fetchTags() {
        isLoadingVariable.value = true
        
        vehicleDetailsService.fetchTags().subscribe(onNext: { tags in
            print(tags)
            self.tags.value = tags
            self.isLoadingVariable.value = false
        }, onError: { error in
            print(error.localizedDescription)
            
            self.tags.value = []
            self.isLoadingVariable.value = false
        }).disposed(by: disposeBag)
    }
    
    internal func populateTag(cell: TagCellType, at row: Int) {
        let tag = self.tags.value[row]
        
        cell.display(name: tag.name)
    }
    
    internal func updateSelectionForTag(at indexPath: IndexPath) {
        let tag = tags.value[indexPath.row]
        
        if let index = selectedTags.index(of: tag) {
            selectedTags.remove(at: index)
        } else {
            selectedTags.append(tag)
        }
        
        hasSelectedTagsVariable.value = selectedTags.count > 0
    }
    
}
