//
//  TitleLabel.swift
//  GitSearch
//
//  Created by Isaac Akalanne on 03/05/2020.
//  Copyright © 2020 Believe And Succeed Apps. All rights reserved.
//

import UIKit

class TitleLabel : UILabel {
    
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
        self.backgroundColor = UIColor.systemBlue
    }
    
}
