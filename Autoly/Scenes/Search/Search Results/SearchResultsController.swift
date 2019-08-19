//
//  SearchResultsController.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-02-15.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift

protocol SearchResultsControllerDelegate: class {
    func didSelect(listing: Listing)
}

class SearchResultsController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: SearchResultsControllerDelegate?
    
    private let disposeBag = DisposeBag()
    private let viewModel = SearchResultsViewModel()
    
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
        
        // Request list of listings
        viewModel.fetchListingsByProximity()
    }

}

extension SearchResultsController {
    
    private func setupUI() {
        // Setup table view
        tableView.register(SearchVehicleCell.self)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 250
    }
    
    private func setupViewModel() {
        // Bind data source to table view
        viewModel.listings.asObservable().bind(to: tableView.rx.items(cellIdentifier: SearchVehicleCell.defaultReuseIdentifier, cellType: SearchVehicleCell.self)) { row, element, cell in
            self.viewModel.populate(cell: cell, listing: element)
        }.disposed(by: disposeBag)
        
        // Bind to table view item selection
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            // Redirect to proper screen
            self?.viewModel.didSelectListing(at: indexPath, delegate: self?.delegate)
        }).disposed(by: disposeBag)
    }
    
}
