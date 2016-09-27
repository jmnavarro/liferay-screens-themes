//
//  ImageGalleryFanCell.swift
//  LiferayScreens
//
//  Created by Victor Galán on 21/09/16.
//  Copyright © 2016 Liferay. All rights reserved.
//

import UIKit
import LiferayScreens
import Kingfisher

public class ImageGalleryFanCell: UICollectionViewCell {

	@IBOutlet private weak var previewImage: UIImageView!

	private var placeholderImage: UIImage?

	private var startAnchorPoint: CGPoint?

	public var imageUrl: String  {
		get {
			return ""
		}
		set {
			previewImage.lr_setImageWithURL(
				NSURL(string: newValue)!,
				placeholderImage:  placeholderImage,
				optionsInfo: [.BackgroundDecode])
		}
	}

	public var image: UIImage {
		get {
			return UIImage()
		}
		set {
			previewImage.image = newValue
		}
	}

	public override func awakeFromNib() {
		super.awakeFromNib()
		startAnchorPoint = self.layer.anchorPoint

		previewImage.clipsToBounds = true
		previewImage.kf_showIndicatorWhenLoading = true
		previewImage.layer.allowsEdgeAntialiasing = true

		placeholderImage = NSBundle.imageInBundles(
			name: "default-placeholder-image",
			currentClass: self.dynamicType)

		layer.cornerRadius = 10
		layer.borderWidth = 1
		layer.borderColor = UIColor.blackColor().CGColor

		backgroundColor = .whiteColor()
	}

	public override func prepareForReuse() {
		super.prepareForReuse()

		previewImage.image = placeholderImage
	}

	override public func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
	  	super.applyLayoutAttributes(layoutAttributes)

		guard let circularlayoutAttributes = layoutAttributes as? FanCollectionViewLayoutAttributes
		else {
			self.center.y = layoutAttributes.center.y
			self.layer.anchorPoint = startAnchorPoint!
			return

		}
		self.layer.anchorPoint = circularlayoutAttributes.anchorPoint
		self.center.y += (circularlayoutAttributes.anchorPoint.y - 0.5) *
				CGRectGetHeight(self.bounds)
	}
}
