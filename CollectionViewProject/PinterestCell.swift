//
//  PinterestCell.swift
//  CollectionViewProject
//
//  Created by Next on 05/05/17.
//  Copyright © 2017 Next. All rights reserved.
//

import UIKit

class PinterestCell: UICollectionViewCell {
    
    
    @IBOutlet weak var mImageView: UIImageView!
    
    
    @IBOutlet weak var mCaptionLabel: UILabel!
    @IBOutlet weak var mImageViewHeightConstraint: NSLayoutConstraint!
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let attributes = layoutAttributes as! PinterestLayoutAttributes
        mImageViewHeightConstraint.constant = attributes.photoHeight
    }
}
