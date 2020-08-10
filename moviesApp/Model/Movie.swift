//
//  Movie.swift
//  moviesApp
//
//  Created by Pedro Martinez on 8/8/20.
//  Copyright © 2020 Pedro Martinez. All rights reserved.
//

import Foundation
import UIKit

struct Movie{
    let id: Int
    let title: String
    let originalTitle: String
    let forAdults: Bool
    let posterPath: String
    let voteAverage: Float
    let overview: String
    let releaseDate: String
    let posterImage = UIImage(imageLiteralResourceName: "PosterDefault")
    var genres = [String]()
    var homePage: String?
    var status: String?
    var tagline: String?

    
    var posterURL: String {
        get{
            return "\(ConstHelper.imagesURL)\(posterPath)?api_key=\(ConstHelper.apiKey)"
        }
    }
    
    var rating: String{
        get{
            let percentageValue = String(format: "%.0f", voteAverage*10)
            return "\(percentageValue)%"
        }
    }
    
    var date: String?{
        get{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let date = formatter.date(from: releaseDate)!
            
            let formatterShow = DateFormatter()
            formatterShow.dateFormat = "dd-MM-yyyy"
            
            return formatterShow.string(from: date)
        }
    }
    
    var genresString: String{
        get{
            return genres.joined(separator: ", ")
        }
    }
}
