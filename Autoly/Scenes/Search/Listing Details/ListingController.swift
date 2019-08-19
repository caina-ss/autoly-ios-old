//
//  ListingController.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-04-03.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

class ListingController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    @IBOutlet weak var detailsStackView: UIStackView!
    
    private let disposeBag = DisposeBag()
    
    var viewModel: ListingViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure UI elements
        setupUI()
        
        // Configure view model
        setupBindings()
    }
    
}

extension ListingController {
    
    private func setupUI() {
        // Setup scroll view
        var bottomInset: CGFloat = 24.0
        if #available(iOS 11.0, *) {
            bottomInset += view.safeAreaInsets.bottom
        }
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0)
        
        // Setup collection view
        galleryCollectionView.register(PhotoCell.self)
        
        // Setup navigation bar
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
        
        // Setup details content
        setupListingContent()
    }
    
    private func setupBindings() {
        // Bind data source to table view
        viewModel?.photos.asObservable().bind(to: galleryCollectionView.rx.items(cellIdentifier: PhotoCell.defaultReuseIdentifier, cellType: PhotoCell.self)) { row, element, cell in
//            self.viewModel.populate(cell: cell, listing: element)
            }.disposed(by: disposeBag)
        
        galleryCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    private func setupListingContent() {
        guard let listing = viewModel?.listing else { return }
        
        // Setup details
        if let overview = listing.overview {
            detailsStackView.addArrangedSubview(createDetailsStackView(title: nil,
                                                                       details: overview,
                                                                       alignment: .center))
        }
        if let color = listing.color {
            detailsStackView.addArrangedSubview(createDetailsStackView(title: "Cor".localized,
                                                                       details: color.name))
        }
        if let kilometers = listing.kilometers {
            detailsStackView.addArrangedSubview(createDetailsStackView(title: "Quilometragem".localized,
                                                                       details: kilometers.description))
        }
        if let transmission = listing.transmission {
            detailsStackView.addArrangedSubview(createDetailsStackView(title: "Transmissão".localized,
                                                                       details: transmission.name))
        }
        if let fuel = listing.fuel {
            detailsStackView.addArrangedSubview(createDetailsStackView(title: "Combustível".localized,
                                                                       details: fuel.name))
        }
        if let plate = listing.plate {
            detailsStackView.addArrangedSubview(createDetailsStackView(title: "Placa final".localized,
                                                                       details: plate))
        }
    }
    
    private func createDetailsStackView(title: String?, details: String?, alignment: NSTextAlignment = .left) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        
        if title != nil {
            let titleLabel = UILabel()
            titleLabel.font = Fonts.Circular.bold.size(17)
            titleLabel.numberOfLines = 0
            titleLabel.lineBreakMode = .byWordWrapping
            titleLabel.textColor = .black
            titleLabel.text = title
            titleLabel.textAlignment = alignment
            
            stackView.addArrangedSubview(titleLabel)
        }
        
        if details != nil {
            let detailsLabel = UILabel()
            detailsLabel.font = Fonts.Circular.book.size(17)
            detailsLabel.numberOfLines = 0
            detailsLabel.lineBreakMode = .byWordWrapping
            detailsLabel.textColor = .black
            detailsLabel.text = details
            detailsLabel.textAlignment = alignment
            
            stackView.addArrangedSubview(detailsLabel)
        }
        
        return stackView
        
    }
    
}

extension ListingController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let side = galleryCollectionView.frame.width
        
        return CGSize(width: side, height: side)
    }
    
}
