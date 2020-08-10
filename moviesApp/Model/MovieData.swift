//
//  MovieData.swift
//  moviesApp
//
//  Created by Pedro Martinez on 8/8/20.
//  Copyright © 2020 Pedro Martinez. All rights reserved.
//

import Foundation

struct MoviesData:Codable{
    let results:[MovieData]
    let total_pages: Int
}

struct MovieData:Codable{
    let id: Int
    let title: String
    let original_title: String
    let adult: Bool
    let poster_path: String
    let vote_average: Float
    let overview: String
    let release_date: String
}

struct MovieDataDetail:Codable{
    let genres: [Genre]
    let homepage: String
    let status: String
    let tagline: String
}


struct Genre:Codable{
    let name: String
}

struct ProductionCompanies:Codable{
    let name: String
    let origin_country: String
    let logo_path: String
}

