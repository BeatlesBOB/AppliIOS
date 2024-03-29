//
//  ViewController.swift
//  IOSAPPLI
//
//  Created by Natha Allard on 26/11/2019.
//  Copyright © 2019 Natha Allard. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, Delegate, UICollectionViewDelegateFlowLayout, FilterProtocol, UITextFieldDelegate {
    
    func callback(movies: Any) {
        switch movies.self {
        case is YearMovies:
            self.movies = (movies as! YearMovies).results!
        case is LatestMovies:
            self.movies = (movies as! LatestMovies).results!
        case is GenresMovies:
            self.movies = (movies as! GenresMovies).results!
        case is SearchMovies:
            self.movies = (movies as! SearchMovies).results!
        default:
            break
        }
        
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
        return CGSize(width: 195 -  5 , height: 268)
        
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
            cell.displayContent(filmimage: currentMovie.poster_path ?? "", titre: currentMovie.title ?? "", vote: currentMovie.vote_average ?? 0)
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

        if ((type == .year) && (value == "1999"))
        {
             api.getYearMovies(year: 1999)
        }
        
        if ((type == .year) && (value == "2019"))
        {
             api.getYearMovies(year: 2019)
        }
        
        if ((type == .year) && (value == "1997"))
        {
            api.getYearMovies(year: 1997)
        }
        
        if ((type == .year) && (value == "1995"))
        {
            api.getYearMovies(year: 1995)
        }
        
        if((type == .type) && (value == "Action"))
        {
            api.getGenreMovies(genres:[28])
        }
        
        if((type == .type) && (value == "Adventure"))
        {
            api.getGenreMovies(genres:[12])
        }
        
        if((type == .type) && (value == "Animation"))
        {
            api.getGenreMovies(genres:[16])
        }
        
        if((type == .type) && (value == "Comedy"))
        {
            api.getGenreMovies(genres:[35])
        }
        
        
		print("On vient de filtrer le select \(type.rawValue) avec la valeur \(value)")
	}
    func updateSearchText(value: String){
        
        if(value.count != 0)
        {
            api.searchMovie(name: value)
        }else{
            api.getLatestMovies()
        }
       
    }
    
   
}
