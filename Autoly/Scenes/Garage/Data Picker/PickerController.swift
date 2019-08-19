//
//  PickerController.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-04-09.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import UIKit
import RxSwift

protocol PickerControllerDelegate: class {
    func didSelect(item: Any, type: PickerType)
}

class PickerController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: MaterialActivityIndicatorView!
    
    weak var delegate: PickerControllerDelegate?
    
    private let disposeBag = DisposeBag()
    
    var viewModel: PickerViewModelType?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure UI elements
        setupUI()
        
        // Configure view model
        setupBindings()
    }
    
}

// MARK: Private

extension PickerController {
    
    private func setupUI() {
        // Setup table view
        tableView.register(SingleLabelCell.self)
    }
    
    private func setupBindings() {
        // Bind to isLoading to update button title
        viewModel?.isLoading.map { !$0 }.drive(loadingView.rx.isHidden).disposed(by: disposeBag)
        viewModel?.isLoading.drive(activityIndicator.rx.isAnimating).disposed(by: disposeBag)
        
        // Bind data source to table view
        viewModel?.items.asObservable().bind(to: tableView.rx.items(cellIdentifier: SingleLabelCell.defaultReuseIdentifier,
                                                                   cellType: SingleLabelCell.self)) { [unowned self] row, element, cell in
            self.viewModel?.populate(cell: cell, item: element)
            }.disposed(by: disposeBag)
        
        // Bind to table view item selection
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            // Redirect to proper screen
            guard let item = self?.viewModel?.item(for: indexPath),
                let type = self?.viewModel?.selectedItemType
                else { return }
            
            self?.delegate?.didSelect(item: item, type: type)
        }).disposed(by: disposeBag)
    }
    
}
