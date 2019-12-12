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
    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var filmImageView: UIImageView!
    
    @IBOutlet weak var titreLabel: UILabel!
    @IBOutlet weak var realLabel: UILabel!
    
    var isHeightCalculated: Bool = false
    var toggleHeart = 1
    var toggleTicket = 1
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func displayContent(filmimage: String, titre: String, vote: double_t){

        let url = URL(string: "https://image.tmdb.org/t/p/w200"+filmimage)

        do {
            let data = try Data(contentsOf: url!)
            self.filmImageView.image = UIImage(data: data)
            
        }catch let err {
            print(" Error : \(err.localizedDescription)")
        }

        titreLabel.text = titre
        realLabel.text = String(describing: vote)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(gesture:)))

        // add it to the image view;
        heartImageView.addGestureRecognizer(tapGesture)
        // make sure imageView can be interacted with by user
        heartImageView.isUserInteractionEnabled = true
        
        
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped2(gesture:)))

               // add it to the image view;
               ticketImageView.addGestureRecognizer(tapGesture2)
               // make sure imageView can be interacted with by user
               ticketImageView.isUserInteractionEnabled = true
        
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
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        

        if (gesture.view as? UIImageView) != nil {
            if toggleHeart == 1 {
                toggleHeart = 2
                heartImageView.image=UIImage(named: "Fichier 19.png")
            } else {
                toggleHeart = 1
                heartImageView.image=UIImage(named: "Fichier 28.png")
            }
            
        }
    }
    
    @objc func imageTapped2(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        

        if (gesture.view as? UIImageView) != nil {
            if toggleTicket == 1 {
                toggleTicket = 2
                ticketImageView.image=UIImage(named: "Fichier 23.png")
            } else if toggleTicket == 2{
                toggleTicket = 3
                ticketImageView.image=UIImage(named: "Fichier 24.png")
            }else if toggleTicket == 3{
                toggleTicket = 4
                ticketImageView.image=UIImage(named: "Fichier 25.png")
            }else{
                toggleTicket = 1
                ticketImageView.image=UIImage(named: "Fichier 21.png")
            }
            
        }
    }
    
    

}
