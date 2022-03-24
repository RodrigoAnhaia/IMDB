//
//  ViewController.swift
//  IMDB
//
//  Created by Rodrigo de Anhaia on 15/03/22.
//

import UIKit

class MovieListViewController: UITableViewController, UISearchResultsUpdating, Storyboarded {
    
    var coordinator: Coordinator?
    var movieAPI = MovieAPI()
    let search = UISearchController()
    
    enum MovieListType: CaseIterable {
        case popularHeader, popular, playingHeader, playing
    }
    
    let sections = MovieListType.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Movies"
        ///Search
        search.searchResultsUpdater = self
        navigationItem.searchController = search
        
        ///Refresh
        self.refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh.")
        refreshControl?.addTarget(self, action: #selector(refresher), for: .valueChanged)
        
        movieAPI.requestPopularMovies {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        movieAPI.requestNowPlayingMovies {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if search.isActive {
            return 1
        } else {
            return sections.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if search.isActive {
            return movieAPI.searchMovies.count
        } else {
            
            let currentSection = sections[section]
            
            switch currentSection {
            case .popularHeader:
                return 1
            case .popular:
                return movieAPI.popularMovies.count < 3 ? movieAPI.popularMovies.count : 3
            case .playingHeader:
                return 1
            case .playing:
                return movieAPI.nowPlayingMovies.count
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentSection = sections[indexPath.section]
        
        if search.isActive {
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieListCell.id, for: indexPath) as! MovieListCell
            
            let movie = movieAPI.searchMovies[indexPath.row]
            
            cell.movie = movie
            cell.reload()
            
            return cell
        } else {
            
            switch currentSection {
            case .popularHeader:
                let cell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.id, for: indexPath) as! HeaderCell
                
                cell.title = "Popular Movies"
                cell.reload()
                
                return cell
                
            case .playingHeader:
                let cell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.id, for: indexPath) as! HeaderCell
                
                cell.title = "Now Playing"
                cell.reload()
                
                return cell
            case .popular:
                let cell = tableView.dequeueReusableCell(withIdentifier: MovieListCell.id, for: indexPath) as! MovieListCell
                
                let movie = movieAPI.popularMovies[indexPath.row]
                
                cell.movie = movie
                cell.reload()
                
                return cell
                
            case .playing:
                let cell = tableView.dequeueReusableCell(withIdentifier: MovieListCell.id, for: indexPath) as! MovieListCell
                
                let movie = movieAPI.nowPlayingMovies[indexPath.row]
                
                cell.movie = movie
                cell.reload()
                
                return cell
                
                
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if search.isActive {
            coordinator?.showDetails(of: movieAPI.searchMovies[indexPath.row], api: movieAPI)
            
        } else {
            
            let section = sections[indexPath.section]
            
            switch section {
            case .popular:
                coordinator?.showDetails(of: movieAPI.popularMovies[indexPath.row], api: movieAPI)
            case .playing:
                coordinator?.showDetails(of: movieAPI.nowPlayingMovies[indexPath.row], api: movieAPI)
            default:
                return
            }
        }
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= 10 {
            movieAPI.requestNowPlayingMovies {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchString = search.searchBar.text else { return }
        
        movieAPI.searchMovie(searchText: searchString) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    // MARK: @objc refresh
    @objc func refresher() {
        movieAPI.reload {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        refreshControl?.endRefreshing()
    }
}
