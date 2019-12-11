//
//  Details.swift
//  IOSAPPLI
//
//  Created by Kirill Nikolnikov on 09/12/2019.
//  Copyright © 2019 Natha Allard. All rights reserved.
//

import UIKit

class DetailsScreen: UIViewController,Delegate{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var vote: UITextField!
    @IBOutlet weak var descriptionText: UITextView!
    
    
    private let api:APIDelegate = APIDelegate()
    
    
    
    
    override func viewDidLoad() {
        api.delegate = self
        let blur = UIBlurEffect(style:.dark)
        let visual = UIVisualEffectView(effect:blur)
        visual.alpha = 0.5
        api.getLatestMovies()
        visual.frame = imageView.bounds
        imageView.addSubview(visual)
    }
    
    func callback(movies:Any){
        let session = URLSession.shared.dataTask(with: URL(string:"https://image.tmdb.org/t/p/original"+((movies as! LatestMovies).results?.randomElement()?.backdrop_path!)!)!)
        {
            (data,response,error) in
            DispatchQueue.main.async{
            self.imageView.image = UIImage(data:data!)
               
                self.vote.text = (movies as! LatestMovies).results?.first?.vote_average!.description
            self.imageView.image?.withTintColor(UIColor.red)
            }}
        session.resume()
        self.textField.text = (movies as! LatestMovies).results?.randomElement()!.original_title
        self.descriptionText.text = (movies as! LatestMovies).results?.randomElement()!.overview
    }
}
