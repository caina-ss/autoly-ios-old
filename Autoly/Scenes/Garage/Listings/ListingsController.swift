//
//  ListingsController.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-04-08.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import UIKit
import RxSwift

protocol ListingsControllerDelegate: class {
    func didSelectListingCreation(from point: CGPoint, transitionColor: UIColor?)
}

class ListingsController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: MaterialActivityIndicatorView!
    @IBOutlet weak var newListingButton: UIButton!
    
    weak var delegate: ListingsControllerDelegate?
    
    private let disposeBag = DisposeBag()
    private let viewModel = ListingsViewModel()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure UI elements
        setupUI()
        
        // Configure view model bindings
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Request listings for the current user
        // whenever the view is gonna be visible
        viewModel.getListings()
    }
    
}

// MARK: Private

extension ListingsController {
    
    private func setupUI() {
        // Register custom cell
//        tableView.register(OfferCell.self)
        tableView.estimatedRowHeight = 140.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func setupBindings() {
        // Bind to isLoading to update button title
        viewModel.isLoading.asDriver().map { !$0 }.drive(loadingView.rx.isHidden).disposed(by: disposeBag)
        viewModel.isLoading.asDriver().drive(activityIndicator.rx.isAnimating).disposed(by: disposeBag)
    
        // Bind data source to table view
        viewModel.listings.asObservable().bind(to: tableView.rx.items(cellIdentifier: SearchVehicleCell.defaultReuseIdentifier, cellType: SearchVehicleCell.self)) { row, element, cell in
//            self.viewModel.populate(cell: cell, listing: element)
            }.disposed(by: disposeBag)
        
        // Bind new listing button tap action
        newListingButton.rx.tap.bind { [unowned self] _ in
            self.delegate?.didSelectListingCreation(from: self.newListingButton.center,
                                                    transitionColor: self.newListingButton.backgroundColor)
        }.disposed(by: disposeBag)
    }
    
}
