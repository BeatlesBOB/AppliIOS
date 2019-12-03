//
//  APIModels.swift
//  IOSAPPLI
//
//  Created by Kirill Nikolnikov on 03/12/2019.
//  Copyright © 2019 Natha Allard. All rights reserved.
//

import Foundation

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
    let vote_average:Double
    
    init(json : [String:Any]){
        poster_path = json["poster_path"] as! String
        adult = json["adult"] as! Bool
        overview = json["overview"] as! String
        release_date = json["release_date"] as! String
        genre_ids = json["genre_ids"] as! [Int]
        id = json["id"] as! Int
        original_title = json["original_title"] as! String
        original_language =  json["original_language"] as! String
        title = json["title"] as! String
        backdrop_path = json["backdrop_path"] as! String
        popularity = json["popularity"] as! Double
        vote_count =  json["vote_count"] as! Double
        video =  json["video"] as! Bool
        vote_average = json["vote_average"] as! Double
    }
}

struct GetResponse: Decodable{
    let page:Int
    let total_results:Int
    let total_pages:Int
    let results: [Movie]
    
    init(json: [String:Any]){
        page = json["page"] as! Int
        total_results = json["page"] as! Int
        total_pages = json["page"] as! Int
        var temp:[Movie] = []
        for item in json["results"] as! [[String:Any]] {
            temp.append(Movie(json: item))
        }
        results = temp
    }
}
