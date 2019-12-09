//
//  CardMovieCollectionViewCell.swift
//  IOSAPPLI
//
//  Created by Natha Allard on 04/12/2019.
//  Copyright © 2019 Natha Allard. All rights reserved.
//

import UIKit

class CardMovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ticketImageView: UIImageView!
    @IBOutlet weak var filmImageView: UIImageView!
    
    @IBOutlet weak var titreLabel: UILabel!
    @IBOutlet weak var realLabel: UILabel!
    
    var isHeightCalculated: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func displayContent(filmimage : String, titre : String, vote : double_t){

        if let url = NSURL(string : filmimage){
            if let data = NSData(contentsOf: url as URL){
                filmImageView.contentMode = UIView.ContentMode.scaleAspectFit
                filmImageView.image = UIImage(data: data as Data)
            }
        }
        titreLabel.text = titre
        realLabel.text = String(describing: vote)
        
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
