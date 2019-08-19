//
//  PWLoadingButton.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-04-15.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum PWLoadingButtonType {
    case primary, secondary, disabled, destructive
}

class PWLoadingButton: PWShadowButton {
    private var gradientLayer: CAGradientLayer?
    fileprivate var cachedLabelText: String?
    
    var type: PWLoadingButtonType = .primary {
        didSet {
            setupView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer?.frame = bounds
    }
    
}

extension PWLoadingButton {
    
    private func setupView() {
        // Configure corner radius
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        
        // Configure background gradient view
        if gradientLayer == nil {
            gradientLayer = CAGradientLayer()
            gradientLayer!.locations = [0.0, 1.0]
            gradientLayer!.startPoint = CGPoint(x: 0, y: 1)
            gradientLayer!.endPoint = CGPoint(x: 1, y: 0)
        }
        
        layer.insertSublayer(gradientLayer!, at: 0)
        isUserInteractionEnabled = true
        
        // Now setup the proper colors
        if type == .primary {
            let color = UIColor(red: 24/255, green: 157/255, blue: 192/255, alpha: 1).cgColor
            
            gradientLayer!.colors = [color, color]
        } else if type == .disabled {
            let color = UIColor(red: 137/255, green: 144/255, blue: 150/255, alpha: 1).cgColor
            
            gradientLayer!.colors = [color, color]
            isUserInteractionEnabled = false
        } else if type == .secondary {
            let color = UIColor(red: 244/255, green: 246/255, blue: 248/255, alpha: 1).cgColor
            
            gradientLayer!.colors = [color, color]
        } else if type == .destructive {
            let color = UIColor(red: 242/255, green: 89/255, blue: 89/255, alpha: 1).cgColor
            
            gradientLayer!.colors = [color, color]
        }
        
        updateTitle(labelText ?? "")
        
        setNeedsDisplay()
    }
    
    private func updateTitle(_ title: String) {
        setTitle(title, for: .normal)
        setTitleColor(type == .secondary ? .black : .white, for: .normal)
    }
    
}

// MARK: Inspectable properties

extension PWLoadingButton {
    
    @IBInspectable var labelText: String? {
        set(text) {
            if cachedLabelText == nil {
                cachedLabelText = text
            }
            
            updateTitle(text ?? "")
        }
        get {
            return titleLabel?.text
        }
    }
    
}

// MARK: RxSwift

extension Reactive where Base: PWLoadingButton {
    
    var isLoading: Binder<Bool> {
        return Binder(self.base) { button, loading in
            if loading {
                button.labelText = "Carregando...".localized
                button.isUserInteractionEnabled = false
            } else {
                button.labelText = button.cachedLabelText
                button.isUserInteractionEnabled = true
            }
        }
    }
    
}
