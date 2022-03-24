//
//  MovieListCell.swift
//  IMDB
//
//  Created by Rodrigo de Anhaia on 23/03/22.
//

import UIKit

class MovieListCell: UITableViewCell {
    static var id: String = "MovieCell"
    var movie: Movie?
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        poster.layer.cornerRadius = 10
    }
    
    /// Reload the movie cell content with the data into the movie varivable.
    func reload() {
        poster.imageFromServerURL("https://image.tmdb.org/t/p/w200\(movie!.posterPath)", placeHolder: UIImage())
        movieTitle.text = movie?.title
        movieOverview.text = movie?.overview
        movieRating.text = "\(movie?.voteAverage ?? 0)"
    }
}
