//
//  MovieDetailsViewController.swift
//  IMDB
//
//  Created by Rodrigo de Anhaia on 24/03/22.
//

import UIKit

class MovieDetailsViewController: UIViewController, Storyboarded {
    
    var movie: Movie?
    var genresText: String?
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieGenres: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        poster.layer.cornerRadius = 10
        self.title = "Details"
        
        navigationItem.largeTitleDisplayMode = .never
        
        poster.imageFromServerURL("https://image.tmdb.org/t/p/w200\(movie?.posterPath ?? "")", placeHolder: UIImage())
        movieTitle.text = movie?.title
        movieGenres.text = genresText
        movieOverview.text = movie?.overview
        movieRating.text = "\(movie?.voteAverage ?? 0)"
    }
}
