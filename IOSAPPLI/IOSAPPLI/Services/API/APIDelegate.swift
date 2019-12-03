//
//  APIDelegate.swift
//  IOSAPPLI
//
//  Created by Kirill Nikolnikov on 26/11/2019.
//  Copyright © 2019 Natha Allard. All rights reserved.
//

import Foundation

class APIDelegate{
    var delegate:Delegate?
    
    func fetchMovies()->Void{
        let session = URLSession.shared.dataTask(with: URL(string: "https://api.themoviedb.org/3/search/movie?api_key=8d86b8e5fd78601cc8bcf5191cd88788&query=Jack+Reacher")!)
        {
            (data,response,error) in
            do{
//                let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
                let jsonData = try JSONDecoder().decode(GetResponse.self,from: data!)
                print(jsonData.results[0].original_title)
                self.delegate?.callback()
                
            }catch{
                print("Erreur")
            }
        }
        session.resume()
        
    }
}

protocol Delegate {
    func callback()
}
