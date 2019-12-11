//
//  ViewController.swift
//  IOSAPPLI
//
//  Created by Natha Allard on 26/11/2019.
//  Copyright © 2019 Natha Allard. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, Delegate, UICollectionViewDelegateFlowLayout, FilterProtocol {
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        
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
        
		let totalWidth = collectionView.frame.width
		
        if indexPath.section == 0 {
            return CGSize(width: totalWidth, height: 385)
            
        }
        return CGSize(width: totalWidth/2 -  5 , height: 300)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let headerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCollectionViewCell", for: indexPath) as! HeaderCollectionViewCell
			headerCell.parentView = self.collectionview
			headerCell.configure()
			headerCell.delegate = self
            return headerCell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardMovieCollectionViewCell", for: indexPath) as! CardMovieCollectionViewCell
            let currentMovie = movies[indexPath.row]
            cell.displayContent(filmimage: currentMovie.poster_path!, titre: currentMovie.title!, vote: currentMovie.vote_average!)
                return cell
		}
	}
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.section != 0){
            let detailVC = UIStoryboard(name: "DetailsScreen", bundle: nil).instantiateViewController(identifier: "DetailsScreen") as! DetailsScreen
            detailVC.movieId = movies[indexPath.row].id
            showDetailViewController(detailVC, sender: self)
        }
    }

	
	// MARK: - FilterProtocol
	func selectFilter(type: FilterType, value: String) {
		// TODO: Ici on va filter les résultats en fonction du filtre appliqué
		print("On vient de filtrer le select \(type.rawValue) avec la valeur \(value)")
	}
}
