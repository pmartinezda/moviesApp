//
//  MovieManager.swift
//  moviesApp
//
//  Created by Pedro Martinez on 8/8/20.
//  Copyright © 2020 Pedro Martinez. All rights reserved.
//

import Foundation

protocol HomeMoviesManagerDelegate{
    func didUpdateMovies(_ movieManager: MoviesManager, movies: [Movie])
    func didFailWithError(error: Error)
}


class MoviesManager{
    let homeCurrentPage = 1
    var totalPages = 1
    var moviesArray = [Movie]()

    var delegate: HomeMoviesManagerDelegate?
    
    func fetchHomeMovies(){
        let urlString = "\(ConstHelper.apiURL)movie/popular?page=\(homeCurrentPage)&api_key=\(ConstHelper.apiKey)"
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
                    if let movieParsedData = self.parseJson(moviesData: safeData) {
                        var moviesArray = [Movie]()
                        for movieData in movieParsedData.results {
                            let movie = Movie(id: movieData.id, title: movieData.title, originalTitle: movieData.original_title, forAdults: movieData.adult, posterPath: movieData.poster_path, voteAverage: movieData.vote_average, overview: movieData.overview, releaseDate: movieData.release_date)
                            self.moviesArray.append(movie)
                        }
                        self.delegate?.didUpdateMovies(self, movies: moviesArray)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJson(moviesData: Data)->MoviesData?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(MoviesData.self, from: moviesData)
            return decodedData
        }
        catch{
            print(error)
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
