//
//  ViewController.swift
//  IOSAPPLI
//
//  Created by Natha Allard on 26/11/2019.
//  Copyright © 2019 Natha Allard. All rights reserved.
//

import UIKit

struct Movie: Decodable{
    let poster_path:String
    let adult:Bool
    let overview:String
    let release_date:String
    let genre_ids:[Int]
    let id:Int
    let original_title:String
    let original_language:String
    let title:String
    let backdrop_path:String
    let popularity:Double
    let vote_count:Double
    let video:Bool
    let vote_average:Bool
}

class ViewController: UIViewController {

    //MARK - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let session = URLSession.shared.dataTask(with: URL(string: "https://api.themoviedb.org/3/search/movie?api_key=8d86b8e5fd78601cc8bcf5191cd88788&query=Jack+Reacher")!){
            (data,response,error) in
            print(String(data: data!, encoding: .utf8)!)
        }
        session.resume()
    }


}

