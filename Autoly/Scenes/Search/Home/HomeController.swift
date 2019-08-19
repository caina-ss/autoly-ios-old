//
//  HomeController.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-02-22.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift

protocol HomeControllerDelegate: class {
    func didTapAllProximity(homeController: HomeController)
}

class HomeController: UIViewController {
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var suggestionsCollectionView: UICollectionView!
    @IBOutlet weak var suggestionsActivityIndicator: UIActivityIndicatorView!
    
    private let disposeBag = DisposeBag()
    private let viewModel = HomeViewModel()
    
    weak var delegate: HomeControllerDelegate?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure UI elements
        setupUI()
        
        // Configure view model (bindings)
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Setup navigation bar
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Setup navigation bar
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: Actions
    
    @IBAction func tapAllProximity(button: UIButton) {
        delegate?.didTapAllProximity(homeController: self)
    }
    
}

extension HomeController {
    
    private func setupUI() {
        // Setup categories collection view
        categoriesCollectionView.register(VehicleCategoryCell.self)
        categoriesCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        // Setup suggestions collection view
        suggestionsCollectionView.register(VehicleSuggestionCell.self)
        suggestionsCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    private func setupViewModel() {
        // Bind activity indicator to view model
        viewModel.isLoadingListings.asDriver().drive(suggestionsActivityIndicator.rx.isAnimating).disposed(by: disposeBag)
        viewModel.isLoadingListings.asDriver().map { !$0 }.drive(suggestionsActivityIndicator.rx.isHidden).disposed(by: disposeBag)
        
        // Bind categories data source to collection view
        viewModel.categories.asObservable().bind(to: categoriesCollectionView.rx.items) { collectionView, row, element in
            let cell: VehicleCategoryCell = collectionView.dequeueReusableCell(for: IndexPath(item: row, section: 0))
            
//            cell.iconView.image = element.icon
            
            return cell
            }.disposed(by: disposeBag)
        
        // Bind categories data source to collection view
        viewModel.closestListings.asObservable().bind(to: suggestionsCollectionView.rx.items) { collectionView, row, element in
            let cell: VehicleSuggestionCell = collectionView.dequeueReusableCell(for: IndexPath(item: row, section: 0))
            
            self.viewModel.populate(cell: cell, listing: element)
            
            return cell
            }.disposed(by: disposeBag)
        
        // Request list of categories
        viewModel.fetchCategories()
        
        // Request list of suggestions
        viewModel.fetchListingsByProximity()
    }
    
}

extension HomeController: UICollectionViewDelegateFlowLayout {

    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(#function)
        if collectionView == suggestionsCollectionView {
            return CGSize(width: 140, height: 140)
        }
        
        return CGSize(width: collectionView.frame.height,
                      height: collectionView.frame.height)
    }
    
}
