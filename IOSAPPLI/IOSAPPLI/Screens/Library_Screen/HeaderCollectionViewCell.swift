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
        //Exhibit A - We need to cache our calculation to prevent a crash.
        if !isHeightCalculated {
            setNeedsLayout()
            layoutIfNeeded()
            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
            var newFrame = layoutAttributes.frame
            newFrame.size.width = CGFloat(ceilf(Float(size.width)))
            layoutAttributes.frame = newFrame
            isHeightCalculated = true
        }
        return layoutAttributes
    }
}
