//
//  MoviesCollectionViewModelProtocol.swift
//  MoviesApp
//
//  Created by Александр on 31.12.21.
//

import Foundation

protocol MoviesCollectionViewModelProtocol {
    var isFiltering: Bool { get }
    var viewModelDidChange: ((MoviesCollectionViewModelProtocol) -> Void)? { get set }
    func fetchMovies(completion: @escaping() -> Void)
    func filterContentForSearchText(_ searchText: String, completion: @escaping() -> Void)
    func numberOfItems() -> Int
    func getFilmAt(_ indexPath: IndexPath) -> Film?
    func cellViewMode(at indexPath: IndexPath) -> MoviesCellViewModelProtocol
    func detailsViewModel(at indexPath: IndexPath) -> FilmDetailsViewModelProtocol
}

class MoviesCollectionViewModel: MoviesCollectionViewModelProtocol {
    
    private var movies: Movies?
    private var filteredFilms: [Film] = []
    
    var isFiltering: Bool {
        SearchController.shared.searchController.isActive && !SearchController.shared.searchBarIsEmpty
    }
    
    var viewModelDidChange: ((MoviesCollectionViewModelProtocol) -> Void)?
    
    func fetchMovies(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchMoviesInfo { [unowned self] result in
            switch result {
            case .success(let movie):
                self.movies = movie
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfItems() -> Int {
        isFiltering ? filteredFilms.count : movies?.movies.count ?? 0
    }
    
    func filterContentForSearchText(_ searchText: String, completion: @escaping() -> Void) {
        filteredFilms = movies?.movies.filter { film in
            (film.titleEn ?? film.title).lowercased().contains(searchText.lowercased())
        } ?? []
        completion()
    }
    
    func getFilmAt(_ indexPath: IndexPath) -> Film? {
        isFiltering ? filteredFilms[indexPath.item] : movies?.movies[indexPath.item]
    }
    
    func cellViewMode(at indexPath: IndexPath) -> MoviesCellViewModelProtocol {
        let film = getFilmAt(indexPath)
        return MoviesCellViewModel(film: film)
    }
    
    func detailsViewModel(at indexPath: IndexPath) -> FilmDetailsViewModelProtocol {
        let film = getFilmAt(indexPath)
        return FilmDetailsViewModel(film: film!)
    }
}
