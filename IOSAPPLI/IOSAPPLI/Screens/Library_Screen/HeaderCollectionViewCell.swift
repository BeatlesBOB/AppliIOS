//
//  HeaderCollectionViewCell.swift
//  IOSAPPLI
//
//  Created by Natha Allard on 09/12/2019.
//  Copyright © 2019 Natha Allard. All rights reserved.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {

    var isHeightCalculated: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
		layoutIfNeeded()
		let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
		var newFrame = layoutAttributes.frame
		// note: don't change the width
		newFrame.size.height = ceil(size.height)
		layoutAttributes.frame = newFrame
		return layoutAttributes
    }
}
