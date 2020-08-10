//
//  MovieDetailViewController.swift
//  moviesApp
//
//  Created by Pedro Martinez on 8/8/20.
//  Copyright © 2020 Pedro Martinez. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var detailSpinner: UIActivityIndicatorView!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    var movie: Movie?
    let movieDetailManager = MovieDetailManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "HeaderLogo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        self.detailSpinner.hidesWhenStopped = true
        movieDetailManager.delegate = self
        titleLabel.text = movie?.title
        originalTitleLabel.text = movie?.originalTitle
        ratingLabel.text = movie?.rating
        dateLabel.text = movie?.date
        overviewLabel.text = movie?.overview
        if let movieSafe = self.movie {
            detailSpinner.startAnimating()
            movieDetailManager.fetchMovieDetail(movie: movieSafe)
        }
    }
    
    func updateExtraDetails(){
        taglineLabel.text = movie?.tagline
        genresLabel.text = movie?.genresString
        statusLabel.text = movie?.status
    }

}

extension MovieDetailViewController: MovieDetailManagerDelegate{
    func didUpdateMovieDetail(_ movieManager: MovieDetailManager, movie: Movie) {
        DispatchQueue.main.async {
            self.movie = movie
            self.detailSpinner.stopAnimating()
            self.updateExtraDetails()
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}
