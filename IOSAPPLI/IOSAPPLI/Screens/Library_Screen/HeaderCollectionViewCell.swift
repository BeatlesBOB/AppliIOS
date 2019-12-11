//
//  HeaderCollectionViewCell.swift
//  IOSAPPLI
//
//  Created by Natha Allard on 09/12/2019.
//  Copyright © 2019 Natha Allard. All rights reserved.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell,UITextFieldDelegate,UIGestureRecognizerDelegate{

    @IBOutlet weak var searchbar: UITextField!
    @IBOutlet weak var yearFilterView: FilterView!
	@IBOutlet weak var likeFilterView: FilterView!
	@IBOutlet weak var typeFilterView: FilterView!
	@IBOutlet weak var statusFilterView: FilterView!
	
	var parentView: UIView?
    var isHeightCalculated: Bool = false
    var delegate: FilterProtocol?
	
    override func awakeFromNib() {
        super.awakeFromNib()
    }
	
	func configure() {
		yearFilterView.configure(.year)
		yearFilterView.parentView = parentView
		yearFilterView.delegate = delegate
		
		likeFilterView.configure(.like)
		likeFilterView.parentView = parentView
		likeFilterView.delegate = delegate
		
		typeFilterView.configure(.type)
		typeFilterView.parentView = parentView
		typeFilterView.delegate = delegate
		
		statusFilterView.configure(.status)
		statusFilterView.parentView = parentView
		statusFilterView.delegate = delegate

        searchbar.delegate = self
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let valuetext = searchbar.text
        delegate?.updateSearchText(value: valuetext!)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchbar.resignFirstResponder()
    }

}
