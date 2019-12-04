//
//  ViewController.swift
//  IOSAPPLI
//
//  Created by Natha Allard on 26/11/2019.
//  Copyright © 2019 Natha Allard. All rights reserved.
//

import UIKit



class ViewController: UIViewController,Delegate {
    func callback(movies: Any) {
        if(movies is GetResponse){
            print("yes")
        }else{
            print(movies)
        }
    }
    
    
    private let api:APIDelegate = APIDelegate()

    //MARK - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        api.delegate = self
        api.fetchLatestMovies()
//        api.searchMovie(name: "transformers")
//        api.getMovieDetails(id: 335988)
    }


}

