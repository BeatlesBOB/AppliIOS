//
//  APIModels.swift
//  IOSAPPLI
//
//  Created by Kirill Nikolnikov on 03/12/2019.
//  Copyright © 2019 Natha Allard. All rights reserved.
//

import Foundation

struct Movie: Decodable{
    let poster_path:String?
    let adult:Bool?
    let overview:String?
    let release_date:String?
    let genre_ids:[Int]?
    let id:Int?
    let original_title:String?
    let original_language:String?
    let title:String?
    let backdrop_path:String?
    let popularity:Double?
    let vote_count:Double?
    let video:Bool?
    let vote_average:Double?
    
    init(json : [String:Any]){
        poster_path = json["poster_path"] as? String ?? ""
        adult = json["adult"] as? Bool ?? false
        overview = json["overview"] as? String ?? ""
        release_date = json["release_date"] as? String ?? ""
        genre_ids = json["genre_ids"] as? [Int] ?? []
        id = json["id"] as? Int ?? 0
        original_title = json["original_title"] as? String ?? ""
        original_language =  json["original_language"] as? String ?? ""
        title = json["title"] as? String ?? ""
        backdrop_path = json["backdrop_path"] as? String ?? ""
        popularity = json["popularity"] as? Double ?? 0
        vote_count =  json["vote_count"] as? Double ?? 0
        video =  json["video"] as? Bool ?? false
        vote_average = json["vote_average"] as? Double ?? 0
    }
}

struct LatestMovies:Decodable{
    let results:[Movie]?
    let page:Int?
    let total_pages:Int?
    let total_results:Int?
    let dates:Range?
}

struct Range:Decodable{
    let maximum:String?
    let minimum:String?
}

struct GetResponse: Decodable{
    let page:Int?
    let total_results:Int?
    let total_pages:Int?
    let results: [Movie]?
    
    init(json: [String:Any]){
        page = json["page"] as? Int
        total_results = json["total_results"] as? Int
        total_pages = json["total_pages"] as? Int
        var temp:[Movie] = []
        for item in json["results"] as! [[String:Any]] {
            temp.append(Movie(json: item))
        }
        results = temp
    }
}

struct MovieDetails: Codable {
    let adult: Bool?
    let backdropPath: String?
    let belongsToCollection: CollectionM?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let imdbID, originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate: String?
    let revenue, runtime: Int?
    let spokenLanguages: [SpokenLanguage]?
    let status, tagline, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
}

// MARK: - Collection
struct CollectionM: Codable{
    let id:Int?
    let name: String?
    let poster_path: String?
    let backdrop_path :String?
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int
    let logoPath: String?
    let name, originCountry: String
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166_1, name: String
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let iso639_1, name: String
}
