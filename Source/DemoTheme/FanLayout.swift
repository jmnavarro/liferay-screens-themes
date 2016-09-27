/**
* Copyright (c) 2000-present Liferay, Inc. All rights reserved.
*
* This library is free software; you can redistribute it and/or modify it under
* the terms of the GNU Lesser General Public License as published by the Free
* Software Foundation; either version 2.1 of the License, or (at your option)
* any later version.
*
* This library is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
* FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
* details.
*/

import UIKit

public class FanCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {

	var anchorPoint = CGPoint(x: 0.5, y: 0.5)
	var angle: CGFloat = 0 {
		didSet {
			zIndex = Int(angle * 1000000)
			transform = CGAffineTransformMakeRotation(angle)
		}
	}

	override public func copyWithZone(zone: NSZone) -> AnyObject {
		let copiedAttributes: FanCollectionViewLayoutAttributes =
			super.copyWithZone(zone) as! FanCollectionViewLayoutAttributes
		copiedAttributes.anchorPoint = self.anchorPoint
		copiedAttributes.angle = self.angle
		return copiedAttributes
	}
}

public class FanLayout: UICollectionViewLayout {

	var attributesList = [FanCollectionViewLayoutAttributes]()

	let itemSize = CGSize(width: 133, height: 173)

	var radius: CGFloat = 500 {
		didSet {
			invalidateLayout()
		}
	}

	var angleAtExtreme: CGFloat {
		return collectionView!.numberOfItemsInSection(0) > 0 ?
			-CGFloat(collectionView!.numberOfItemsInSection(0) - 1) * anglePerItem : 0
	}
	var angle: CGFloat {
		return angleAtExtreme * collectionView!.contentOffset.x / (collectionViewContentSize().width
			- CGRectGetWidth(collectionView!.bounds))
	}

	var anglePerItem: CGFloat {
		return atan(itemSize.width / radius)
	}

	override public func collectionViewContentSize() -> CGSize {
		if (collectionView?.numberOfSections() == 0) {
			return CGSize.zero
		}
		return CGSize(
				width: CGFloat(collectionView!.numberOfItemsInSection(0) * Int(itemSize.width)),
				height: CGRectGetWidth(collectionView!.bounds))
	}

	override public class func layoutAttributesClass() -> AnyClass {
		return FanCollectionViewLayoutAttributes.self
	}

	override public func prepareLayout() {
		super.prepareLayout()

		let anchorPointY = ((itemSize.height / 2.0) + radius) / itemSize.height
		let centerX = collectionView!.contentOffset.x +
				(CGRectGetWidth(collectionView!.bounds) / 2.0)

		if (collectionView?.numberOfSections() != 0) {

			let theta = atan2(CGRectGetWidth(collectionView!.bounds)/2.0, radius +
					(itemSize.height/2.0) - (CGRectGetHeight(collectionView!.bounds)/2.0))

			var startIndex = 0
			var endIndex = collectionView!.numberOfItemsInSection(0) - 1

			if (angle < -theta) {
				startIndex = Int(floor((-theta - angle)/anglePerItem))
			}

			endIndex = min(endIndex, Int(ceil((theta - angle)/anglePerItem)))

			if (endIndex < startIndex) {
				endIndex = 0
				startIndex = 0
			}

			if endIndex == 0 {
				return
			}

			attributesList = (startIndex...endIndex).map { (i)
				-> FanCollectionViewLayoutAttributes in
				print(endIndex)

				let attributes = FanCollectionViewLayoutAttributes(
						forCellWithIndexPath: NSIndexPath(forItem: i,
						inSection: 0))

				attributes.size = self.itemSize
				attributes.center = CGPoint(x: centerX, y: CGRectGetMidY(self.collectionView!.bounds))
				attributes.angle = self.angle + (self.anglePerItem * CGFloat(i))
				attributes.anchorPoint = CGPoint(x: 0.5, y: anchorPointY)

				return attributes
			}
		}
	}

	override public func layoutAttributesForElementsInRect(rect: CGRect)
			-> [UICollectionViewLayoutAttributes]? {
			
		return attributesList
	}

	override public func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath)
		-> UICollectionViewLayoutAttributes {

			if (attributesList.count > indexPath.row) {
				return attributesList[indexPath.row]
			}

			return attributesList.first!
		}

	override public func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
		return true
	}
}
