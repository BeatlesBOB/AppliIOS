//
//  APIDelegate.swift
//  IOSAPPLI
//
//  Created by Kirill Nikolnikov on 26/11/2019.
//  Copyright © 2019 Natha Allard. All rights reserved.
//

let APIURL = "https://api.themoviedb.org/3/"
let APIKEY = "api_key=8d86b8e5fd78601cc8bcf5191cd88788"

import Foundation

class APIDelegate{
    var delegate:Delegate?
    
    func getLatestMovies()->Void{
        let session = URLSession.shared.dataTask(with: URL(string: APIURL+"movie/now_playing?region=fr&"+APIKEY)!)
        {
            (data,response,error) in
            do{
                let jsonData = try JSONDecoder().decode(LatestMovies.self,from:data!)
                self.delegate?.callback(movies:jsonData)
            }catch{
                print(error)
            }
        }
        session.resume()
    }
    
    func searchMovie(name:String){
        let session = URLSession.shared.dataTask(with: URL(string:"https://api.themoviedb.org/3/search/movie?query=transformers&"+APIKEY)!)
            {
                (data,response,error) in
                do{
                    let jsonData = try JSONDecoder().decode(GetResponse.self,from:data!)
                    self.delegate?.callback(movies: jsonData)
                }catch{
                    print(error)
                }
            }
            session.resume()
    }
    
    func getMovieDetails(id:Int){
        let session = URLSession.shared.dataTask(with: URL(string:APIURL+"movie/"+id.description+"?"+APIKEY)!)
                {
                    (data,response,error) in
                    do{
                        let jsonData = try JSONDecoder().decode(MovieDetails.self,from:data!)
                        self.delegate?.callback(movies:jsonData)
                    }catch{
                        print(error)
                    }
                }
                session.resume()
    }
    
    func getGenreMovies(genres:[Int]){
        var genresIds:String = ""
        genres.forEach { (item) in
            genresIds+=item.description+","
        }
        let session = URLSession.shared.dataTask(with: URL(string:APIURL+"discover/movie?sort_by=release_date.desc&release_date.lte=\(2019-12-25)&with_genres=\(genresIds)&\(APIKEY)")!)
        {
            (data,response,error) in
            do{
                let jsonData = try JSONDecoder().decode(GenresMovies.self,from:data!)
                self.delegate?.callback(movies:jsonData)
            }catch{
                print(error)
            }
        }
        session.resume()
    }
    
    func getYearMovies(year:Int){
        let session = URLSession.shared.dataTask(with: URL(string:APIURL+"discover/movie?sort_by=release_date.desc&year=\(year)&\(APIKEY)")!)
        {
            (data,response,error) in
            do{
                let jsonData = try JSONDecoder().decode(ArrayMovies.self,from:data!)
                self.delegate?.callback(movies:jsonData)
            }catch{
                print(error)
            }
        }
        session.resume()
    }
}

protocol Delegate {
    func callback(movies:Any)
}
