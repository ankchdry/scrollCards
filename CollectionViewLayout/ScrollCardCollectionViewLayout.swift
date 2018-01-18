
//
//  ScrollCardCollectionViewLayout.swift
//  scrollCards
//
//  Created by Ankit  Chaudhary on 31/12/17.
//  Copyright © 2017 Ankit  Chaudhary. All rights reserved.
//

import UIKit

class ScrollCardCollectionViewLayout: UICollectionViewFlowLayout {
    
    let standardItemAlpha: CGFloat = 0.5
    let standardItemScale: CGFloat = 0.6
    @IBInspectable open var sideItemShift: CGFloat = 0.0
    
    override func prepare() {
        super.prepare()
        if collectionView?.decelerationRate != UIScrollViewDecelerationRateFast {
            collectionView?.decelerationRate = UIScrollViewDecelerationRateFast
        }
        self.scrollDirection = .horizontal
        self.minimumLineSpacing = -(self.itemSize.width * 0.10)
    }


    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        var newAttributes:[UICollectionViewLayoutAttributes] = []
        for itemAttributes in attributes! {
            let itemAttributesCopy = itemAttributes.copy() as! UICollectionViewLayoutAttributes
            changeLayoutAttributes(attributes: itemAttributesCopy)
            newAttributes.append(itemAttributesCopy)
        }
        return newAttributes
    }

    func changeLayoutAttributes(attributes:UICollectionViewLayoutAttributes)  {

        let collectionHorizontalCenter = (collectionView?.frame.size.width)! / 2
        let xOffset = collectionView?.contentOffset.x
        let normalizedHorizontalCenter = attributes.center.x - xOffset!

        let maxDistance = self.itemSize.width + self.minimumLineSpacing
        let distance = min(abs(collectionHorizontalCenter - normalizedHorizontalCenter), maxDistance)

        let ratio = (maxDistance - distance)/maxDistance

        let alpha = ratio * (1 - self.standardItemAlpha) + self.standardItemAlpha
        let scale = ratio * (1 - self.standardItemScale) + self.standardItemScale
        let shift = (1 - ratio) * self.sideItemShift

        attributes.alpha = alpha
        attributes.zIndex = (Int(alpha * 10))
        attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        
        attributes.center.x = attributes.center.x +  shift
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView , !collectionView.isPagingEnabled,
            
            let layoutAttributes = self.layoutAttributesForElements(in: collectionView.bounds)
            else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset) }
        
        
        let midSide =  collectionView.bounds.size.width / 2.0
        let proposedContentOffsetCenterOrigin =  proposedContentOffset.x + midSide
        
        var targetContentOffset: CGPoint
        
        let closest = layoutAttributes.sorted { abs($0.center.x - proposedContentOffsetCenterOrigin) < abs($1.center.x - proposedContentOffsetCenterOrigin) }.first ?? UICollectionViewLayoutAttributes()
        targetContentOffset = CGPoint(x: floor(closest.center.x - midSide), y: proposedContentOffset.y)
        return targetContentOffset
    }
}
