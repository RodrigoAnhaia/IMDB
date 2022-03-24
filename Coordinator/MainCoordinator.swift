//
//  MainCoordinator.swift
//  IMDB
//
//  Created by Rodrigo de Anhaia on 23/03/22.
//

import UIKit

/// The coordinator responsable for the navigation in this app.
class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MovieListViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showDetails(of movie: Movie, api: MovieAPI) {
//        let vc = MoviesDetailsViewController.instantiate()
//        vc.movie = movie
//        vc.genresText = api.getGeneresText(of: movie)
//        navigationController.pushViewController(vc, animated: true)
    }
    
    
}
