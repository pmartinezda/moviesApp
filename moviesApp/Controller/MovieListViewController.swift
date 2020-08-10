//
//  ViewController.swift
//  moviesApp
//
//  Created by Pedro Martinez on 8/8/20.
//  Copyright © 2020 Pedro Martinez. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet weak var moviesTableView: UITableView!
    
//    var moviesArray = [Movie]()
    var moviesManager = MoviesManager()
    var movieSelected: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let logo = UIImage(named: "HeaderLogo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        
        moviesManager.delegate = self
        moviesManager.fetchHomeMovies()
        
        moviesTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMovieDetail"{
            let destinationVC = segue.destination as! MovieDetailViewController
            destinationVC.movie = movieSelected
        }
    }


}


extension MovieListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesManager.moviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
            let movieSelected = moviesManager.moviesArray[indexPath.row]
            cell.movie = movieSelected
            cell.titleLabel.text = movieSelected.title
            cell.originalTitleLabel.text = movieSelected.originalTitle
            cell.overviewLabel.text = movieSelected.overview
            cell.dateLabel.text = movieSelected.date ?? ""
            cell.ratingLabel.text = movieSelected.rating
            cell.fetchPoster()
            cell.selectionStyle = .none
            return cell
    }
}

extension MovieListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieSelected = moviesManager.moviesArray[indexPath.row]
        self.performSegue(withIdentifier: "goToMovieDetail", sender: self)
    }
}


extension MovieListViewController:HomeMoviesManagerDelegate{
    func didUpdateMovies(_ movieManager: MoviesManager, movies: [Movie]) {
        DispatchQueue.main.async {
            self.moviesTableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
