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
import LiferayScreens


public class ImageGalleryView_demo : ImageGalleryCollectionViewBase {

	let imageCellId = "imageCellId"

	// MARK: BaseListCollectionView

	public override func doConfigureCollectionView(collectionView: UICollectionView) {
		collectionView.backgroundColor = .blackColor()
	}

	public override func doRegisterCellNibs() {
		if let imageGalleryGridCellNib = NSBundle.nibInBundles(
			name: "ImageGalleryFanCell",
			currentClass: self.dynamicType) {

			collectionView?.registerNib(
				imageGalleryGridCellNib,
				forCellWithReuseIdentifier: imageCellId)
		}
	}

	public override func doCreateLayout() -> UICollectionViewLayout {
		return FanLayout()
	}

	override public func doFillLoadedCell(
		indexPath indexPath: NSIndexPath,
		          cell: UICollectionViewCell,
		          object:AnyObject) {

		guard let imageCell = cell as? ImageGalleryFanCell, entry = object as? ImageEntry else {
			return
		}

		if let image = entry.image {
			imageCell.image = image
		}
		else {
			imageCell.imageUrl = entry.imageUrl
		}
	}

	public override func doGetCellId(indexPath indexPath: NSIndexPath, object: AnyObject?) -> String {
		return imageCellId
	}

	public override func collectionView(
		collectionView: UICollectionView,
		didSelectItemAtIndexPath indexPath: NSIndexPath) {

		if collectionView.collectionViewLayout.isKindOfClass(SlideShowLayout.self) {
			collectionView.setCollectionViewLayout(FanLayout(), animated: true)
			collectionView.setContentOffset(CGPoint.zero, animated: true)
		}
		else {
			collectionView.setCollectionViewLayout(SlideShowLayout(), animated: true)
		}

	}

}