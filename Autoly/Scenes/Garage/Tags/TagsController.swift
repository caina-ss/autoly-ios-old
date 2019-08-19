//
//  TagsController.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-04-17.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class TagsController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: MaterialActivityIndicatorView!
    @IBOutlet weak var saveButton: PWLoadingButton!
    @IBOutlet weak var saveButtonBottomConstraint: NSLayoutConstraint!
    
    private let disposeBag = DisposeBag()
    
    var viewModel: TagsViewModelType?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure UI elements
        configureUI()
        
        // Configure view model
        configureViewModel()
        
        // Retrieve tags from the backend
        fetchTags()
    }
    
}

extension TagsController {
    
    private func configureUI() {
        // Configure navigation bar
        navigationItem.hidesBackButton = true
        
        // Configure collection view
        collectionView.register(TagCell.self)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.allowsMultipleSelection = true
        
        let tagsFlowLayout = collectionView?.collectionViewLayout as? TagsCollectionViewFlowLayout
        tagsFlowLayout?.horizontalAlignment = .left
        tagsFlowLayout?.verticalAlignment = .top
        tagsFlowLayout?.minimumLineSpacing = 0
        tagsFlowLayout?.minimumInteritemSpacing = 0
        tagsFlowLayout?.estimatedItemSize = .init(width: 150, height: 55)
    }
    
    private func configureViewModel() {
        // Bind to isLoading to update button title
        viewModel?.isLoading.map { !$0 }.drive(loadingView.rx.isHidden).disposed(by: disposeBag)
        viewModel?.isLoading.drive(activityIndicator.rx.isAnimating).disposed(by: disposeBag)
        
        // Bind categories data source to collection view
        viewModel?.tags.asObservable().bind(to: collectionView.rx.items) { [unowned self] collectionView, row, element in
            let cell: TagCell = collectionView.dequeueReusableCell(for: IndexPath(item: row, section: 0))
            
            self.viewModel?.populateTag(cell: cell, at: row)
            
            return cell
        }.disposed(by: disposeBag)
        
        // Bind to collection view item selection
        collectionView.rx.itemSelected.subscribe(onNext: { [unowned self] indexPath in
            // Update selected tags
            self.viewModel?.updateSelectionForTag(at: indexPath)
        }).disposed(by: disposeBag)
        
        collectionView.rx.itemDeselected.subscribe(onNext: { [unowned self] indexPath in
            // Update selected tags
            self.viewModel?.updateSelectionForTag(at: indexPath)
        }).disposed(by: disposeBag)
        
        // Bind to selected tags flag
        viewModel?.hasSelectedTags.asObservable().subscribe(onNext: { [unowned self] shouldShowSaveButton in
            // Animated position of the button
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.saveButtonBottomConstraint.constant = shouldShowSaveButton ? 22 : -100
                self.view.layoutIfNeeded()
            })
        }).disposed(by: disposeBag)
    }
    
    private func fetchTags() {
        viewModel?.fetchTags()
    }
    
}
