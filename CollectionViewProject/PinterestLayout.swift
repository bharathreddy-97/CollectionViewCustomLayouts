//
//  PinterestLayout.swift
//  CollectionViewProject
//
//  Created by Next on 01/05/17.
//  Copyright © 2017 Next. All rights reserved.
//

import UIKit

protocol PinterestLayoutDelegate {
    
    func collectionView(collectionView:UICollectionView,heightForPhotoAtIndexPath indexPath:IndexPath, withWidth width:CGFloat)->CGFloat
    func collectionView(collectionView:UICollectionView,heightForAnnotationAtIndexPath indexPath:IndexPath, withWidth width:CGFloat)->CGFloat
}

class PinterestLayoutAttributes:UICollectionViewLayoutAttributes
{
    var photoHeight:CGFloat = 0
    
    override func copy(with zone: NSZone? = nil) -> Any
    {
        let copy = super.copy(with: zone) as! PinterestLayoutAttributes
        copy.photoHeight = photoHeight
        return copy
    }
    override func isEqual(_ object: Any?) -> Bool
    {
        if let attributes = object as? PinterestLayoutAttributes
        {
            if attributes.photoHeight == photoHeight
            {
                return super.isEqual(object)
            }
        }
        return false
    }
}
class PinterestLayout: UICollectionViewLayout
{
    var delegate:PinterestLayoutDelegate!
    var numberOfColumns = 1
    var xInset:CGFloat = 0
    var yInset:CGFloat = 0
    
    var xCellSpacing:CGFloat = 0
    var yCellSpacing:CGFloat = 0
    
    private var cache = [PinterestLayoutAttributes]()
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
                
                let photoHeight = delegate.collectionView(collectionView: collectionView!, heightForPhotoAtIndexPath: indexpath, withWidth: (width/CGFloat(numberOfColumns)) - 2*xInset)
                let annotationHeight = delegate.collectionView(collectionView: collectionView!, heightForAnnotationAtIndexPath: indexpath, withWidth: (width/CGFloat(numberOfColumns)) - 2*xInset)
                let height = yInset*2+photoHeight+annotationHeight
                let frame = CGRect.init(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: height)
                let attributes = PinterestLayoutAttributes.init(forCellWith: indexpath)
                attributes.photoHeight = photoHeight
                attributes.frame = frame
                cache.append(attributes)
                contentHeight = max(contentHeight, frame.maxY)
                yOffsets[column] = yOffsets[column] + height + yCellSpacing
                column = column >= (numberOfColumns - 1) ? 0 : column+1
            }
        }
    }
    
    override class var layoutAttributesClass:AnyClass
    {
        return PinterestLayoutAttributes.self
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
