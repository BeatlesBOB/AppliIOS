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
    @IBOutlet weak var coeurImageView: UIImageView!
    @IBOutlet weak var filmImageView: UIImageView!
    
    @IBOutlet weak var titreLabel: UILabel!
    @IBOutlet weak var realLabel: UILabel!
    
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
        realLabel.text = vote.description
        
    }

}
