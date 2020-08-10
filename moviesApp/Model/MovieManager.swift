//
//  MovieManager.swift
//  moviesApp
//
//  Created by Pedro Martinez on 8/8/20.
//  Copyright © 2020 Pedro Martinez. All rights reserved.
//

import Foundation

protocol MovieManagerDelegate{
    
}


struct HomeMoviesManager{
    let homeCurrentPage = 1;
    var moviesArray: [Movie]
    let movieAPIURL = "https://api.themoviedb.org/3/movie/"
    let APIKEY = "cdaf0450ad8ae0442032f995082c44d7"
    
    func fetchHomeMovies(){
        print("fetchHomeMovies")
        let urlString = "\(movieAPIURL)popular?page=\(homeCurrentPage)&api_key=\(APIKEY)"
        makeRequest(urlString: urlString)
    }
    
    func makeRequest(urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, urlResponse, error) in
                if error != nil{
                    print(error)
                }
                if let safeData = data {
                    self.parseJson(moviesData: safeData)
                }
            }
            task.resume()
        }
    }
    
    func parseJson(moviesData: Data){
        let decoder = JSONDecoder()
        do{
            print("parseJson")
            let decodedData = try decoder.decode(MoviesData.self, from: moviesData)
            
            print(decodedData)
        }
        catch{
            print("error json")
            print(error)
        }
    }
}
