//
//  ViewController.swift
//  IOSAPPLI
//
//  Created by Natha Allard on 26/11/2019.
//  Copyright © 2019 Natha Allard. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, Delegate, UICollectionViewDelegateFlowLayout {
    
    func callback(movies: Any) {
        self.movies = (movies as! LatestMovies).results!
        
        DispatchQueue.main.async {
            self.collectionview.reloadData()
        }
        
    }
    
    
    private let api:APIDelegate = APIDelegate()
    private var movies: [Movie] = []

    
    @IBOutlet weak var collectionview: UICollectionView!
    
    //MARK - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        api.delegate = self
        api.getLatestMovies()
        collectionview.delegate = self
        collectionview.dataSource = self

        collectionview.register(UINib(nibName: "HeaderCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "HeaderCollectionViewCell")
        collectionview.register(UINib(nibName: "CardMovieCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "CardMovieCollectionViewCell")
        
        
    }
    
    

    func numberOfSections(in collectionView: UICollectionView) -> Int   {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        if indexPath.section == 0 {
            return CGSize(width: screenWidth, height: 500)
            //return CGSize(width: screenWidth, height: 200)
            
        }
        return CGSize(width: screenWidth/2 -  5 , height: 300)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let headerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCollectionViewCell", for: indexPath) as! HeaderCollectionViewCell
            return headerCell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardMovieCollectionViewCell", for: indexPath) as! CardMovieCollectionViewCell
        
            let currentMovie = movies[indexPath.row]
            cell.displayContent(filmimage: currentMovie.poster_path!, titre: currentMovie.title!, vote: currentMovie.vote_average!)
                return cell
            }
        }
    }
