//
//  MaterialActivityIndicator.swift
//  MaterialActivityIndicator
//
//  Created by Jans Pavlovs on 02/13/2018.
//  Copyright (c) 2018 Jans Pavlovs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public class MaterialActivityIndicatorView: UIView {
    @IBInspectable
    public var color: UIColor = .red {
        didSet {
            indicator.strokeColor = color.cgColor
        }
    }
    
    @IBInspectable
    public var lineWidth: CGFloat = 3.0 {
        didSet {
            indicator.lineWidth = lineWidth
            setNeedsLayout()
        }
    }
    
    private let indicator = CAShapeLayer()
    private let animator = MaterialActivityIndicatorAnimator()
    
    private var isAnimating = false
    
    convenience init() {
        self.init(frame: .zero)
        self.setup()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        indicator.strokeColor = color.cgColor
        indicator.fillColor = nil
        indicator.lineWidth = lineWidth
        indicator.strokeStart = 0.0
        indicator.strokeEnd = 0.0
        layer.addSublayer(indicator)
    }
}

extension MaterialActivityIndicatorView {
    
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: 24, height: 24)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        indicator.frame = bounds
        
        let diameter = bounds.size.min - indicator.lineWidth
        let path = UIBezierPath(center: bounds.center, radius: diameter / 2)
        indicator.path = path.cgPath
    }
    
}

extension MaterialActivityIndicatorView {
    
    public func startAnimating() {
        guard !isAnimating else { return }
        
        animator.addAnimation(to: indicator)
        isAnimating = true
    }
    
    public func stopAnimating() {
        guard isAnimating else { return }
        
        animator.removeAnimation(from: indicator)
        isAnimating = false
    }
    
}

extension Reactive where Base: MaterialActivityIndicatorView {
    
    /// Bindable sink for `startAnimating()`, `stopAnimating()` methods.
    public var isAnimating: Binder<Bool> {
        return Binder(self.base) { activityIndicator, active in
            if active {
                activityIndicator.startAnimating()
            } else {
                activityIndicator.stopAnimating()
            }
        }
    }
    
}
