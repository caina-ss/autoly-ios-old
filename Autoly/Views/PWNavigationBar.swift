//
//  PWNavigationBar.swift
//  Autoly
//
//  Created by Cainã Souza on 2018-02-20.
//  Copyright © 2018 PapelWeb. All rights reserved.
//

import UIKit

class PWNavigationBar: UINavigationBar {
    private var backImg = #imageLiteral(resourceName: "LeftArrow")
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        UINavigationBar.appearance().tintColor = UIColor.black
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [PWNavigationBar.self]).setBackButtonTitlePositionAdjustment(UIOffsetMake(-1000, 0), for: .default)
        
        self.titleTextAttributes = [
            NSAttributedStringKey.font: Fonts.Circular.bold.size(UIFont.systemFontSize),
            NSAttributedStringKey.foregroundColor: UIColor.black
        ]
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.backIndicatorImage = backImg
        self.backIndicatorTransitionMaskImage = backImg
    }
    
}
