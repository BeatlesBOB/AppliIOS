//
//  ViewController.swift
//  IOSAPPLI
//
//  Created by Natha Allard on 26/11/2019.
//  Copyright © 2019 Natha Allard. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let api:APIDelegate = APIDelegate()

    let movies: [Movie] = []
    @IBOutlet weak var collectionview: UICollectionView!
    
    //MARK - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardMovieCollectionViewCell", for: indexPath) as! CardMovieCollectionViewCell
        
        let currentMovie = movies[indexPath.row]
        cell.displayContent(filmimage: currentMovie.poster_path, titre: currentMovie.title, vote: currentMovie.vote_average)
            return cell
        }
    }
