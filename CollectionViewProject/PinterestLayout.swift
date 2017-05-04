//
//  PinterestLayout.swift
//  CollectionViewProject
//
//  Created by Next on 01/05/17.
//  Copyright © 2017 Next. All rights reserved.
//

import UIKit

protocol PinterestLayoutDelegate {
    
    func collectionView(collectionView:UICollectionView,heightForItemAtIndexPath indexPath:IndexPath)->CGFloat
}

class PinterestLayout: UICollectionViewLayout
{
    var delegate:PinterestLayoutDelegate!
    var numberOfColumns = 1
    var xInset:CGFloat = 0
    var yInset:CGFloat = 0
    
    var xCellSpacing:CGFloat = 0
    var yCellSpacing:CGFloat = 0
    
    private var cache = [UICollectionViewLayoutAttributes]()
    private var contentHeight:CGFloat = 0
    private var width:CGFloat{
        get{
            return collectionView!.bounds.width
        }
    }
    
    override var collectionViewContentSize: CGSize{
        return CGSize(width:width,height:contentHeight)
    }
    
    override func prepare() {
        if cache.isEmpty{
            
            let totalXSpacing:CGFloat = CGFloat(numberOfColumns - 1)*xCellSpacing
            let totalYSpacing:CGFloat = CGFloat(((collectionView?.numberOfItems(inSection: 0))!/numberOfColumns))*yCellSpacing
            let columnWidth = (width - 2*xInset - totalXSpacing)/CGFloat(numberOfColumns)
            
            var xOffsets = [CGFloat]()
            
            for column in 0..<numberOfColumns{
                print(xInset + xCellSpacing + CGFloat(column)*columnWidth)
                if column == 0{
                    xOffsets.append(xInset + CGFloat(column)*columnWidth)
                }else{
                    xOffsets.append(xInset + xCellSpacing*CGFloat(column) + CGFloat(column)*columnWidth)
                }
            }
            
            var yOffsets = [CGFloat].init(repeating: yInset, count: numberOfColumns)
            
            var column = 0
            for item in 0..<(collectionView?.numberOfItems(inSection: 0))!{
                
                let indexpath = IndexPath.init(item: item, section: 0)
                let height = delegate.collectionView(collectionView: collectionView!, heightForItemAtIndexPath: indexpath)
                let frame = CGRect.init(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: height)
                let attributes = UICollectionViewLayoutAttributes.init(forCellWith: indexpath)
                attributes.frame = frame
                cache.append(attributes)
                contentHeight = max(contentHeight, frame.maxY) + 2*yInset + totalYSpacing
                if indexpath.row <= numberOfColumns - 1{
                    yOffsets[column] = yOffsets[column] + height
                }else{
                    yOffsets[column] = yOffsets[column] + height + yCellSpacing
                }

                column = column >= (numberOfColumns - 1) ? 0 : column+1
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]?
    {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache{
            if attributes.frame.intersects(rect){
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
        
    }
    
    
    
}
