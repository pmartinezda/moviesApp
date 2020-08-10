//
//  MovieDetailManager.swift
//  moviesApp
//
//  Created by Pedro Martinez on 8/8/20.
//  Copyright © 2020 Pedro Martinez. All rights reserved.
//

import Foundation

protocol MovieDetailManagerDelegate{
    func didUpdateMovieDetail(_ movieManager: MovieDetailManager, movie: Movie)
    func didFailWithError(error: Error)
}

class MovieDetailManager{
    var delegate: MovieDetailManagerDelegate?
    var movie: Movie?
    
    func fetchMovieDetail(movie: Movie){
        self.movie = movie
        let urlString = "\(ConstHelper.apiURL)movie/\(movie.id)?api_key=\(ConstHelper.apiKey)"
        makeRequest(urlString: urlString)
    }
    
    func makeRequest(urlString: String){
            if let url = URL(string: urlString){
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { (data, urlResponse, error) in
                    if error != nil{
                        print(error!)
                    }
                    if let safeData = data {
                        if let movieParsedData = self.parseJson(movieDetailData: safeData) {
                            for genre in movieParsedData.genres {
                                self.movie?.genres.append(genre.name)
                            }
                            self.movie?.homePage = movieParsedData.homepage
                            self.movie?.status = movieParsedData.status
                            self.movie?.tagline = movieParsedData.tagline
                            
                            self.delegate?.didUpdateMovieDetail(self, movie: (self.movie!))
                        }
                    }
                }
                task.resume()
            }
        }
    
    func parseJson(movieDetailData: Data)->MovieDataDetail?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(MovieDataDetail.self, from: movieDetailData)
            return decodedData
        }
        catch{
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
