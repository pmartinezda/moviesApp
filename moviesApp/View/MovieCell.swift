//
//  MovieCell.swift
//  moviesApp
//
//  Created by Pedro Martinez on 8/8/20.
//  Copyright © 2020 Pedro Martinez. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var movie: Movie?
    let imageCache = ImageCache()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fetchPoster(){
        print("fetchposter")
        if movie != nil {
            if let url = URL(string: movie!.posterURL){
                let item = Item(image: ImageCache.publicCache.placeholderImage, url: url )

                ImageCache.publicCache.load(url: item.url as NSURL, item: item) { (fetchedItem, image) in
                    print("llego imagen2")
                    if let img = fetchedItem.image {
                        DispatchQueue.main.async {
                            self.posterImageView.image = image
                            print("llego imagen")
                        }
                    }
                }
            }
        }
    }
}
