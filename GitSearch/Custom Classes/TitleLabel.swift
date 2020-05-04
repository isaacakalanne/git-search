//
//  TitleLabel.swift
//  GitSearch
//
//  Created by Isaac Akalanne on 03/05/2020.
//  Copyright © 2020 Believe And Succeed Apps. All rights reserved.
//

import UIKit

class TitleLabel : UILabel {
    
    let coloursArray:[UIColor] = [.systemBlue, .systemIndigo, .systemPink, .systemTeal, .systemOrange, .systemPurple]
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.formatLabel()

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.formatLabel()
    }
    
    func formatLabel() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.size.height / 2
        self.backgroundColor = getLabelBackgroundColour()
    }
    
    func getLabelBackgroundColour() -> UIColor {
        let colourIndex = calculateColourIndex()
        return coloursArray[colourIndex]
    }
    
    func calculateColourIndex() -> Int {
        let fullName = UserDefaults.standard.string(forKey: Constants.Keys.fullName)
        let nameLength = fullName?.count ?? 0
        return nameLength % coloursArray.count
    }
    
}
