//
//  RoundedCornerView.swift
//  CollectionViewProject
//
//  Created by Next on 05/05/17.
//  Copyright © 2017 Next. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedCornerView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBInspectable
    var cornerRadius:CGFloat = 0
    {
        willSet(value)
        {
            self.layer.cornerRadius = value
            self.clipsToBounds = true
        }
    }

}
