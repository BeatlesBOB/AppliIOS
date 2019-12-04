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
    
    func fetchLatestMovies()->Void{
        let session = URLSession.shared.dataTask(with: URL(string: APIURL+"movie/now_playing?region=fr&"+APIKEY)!)
        {
            (data,response,error) in
            do{
//                let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
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
}

protocol Delegate {
    func callback(movies:Any)
}
