//
//  WatchlistViewModel.swift
//  MoviesApp
//
//  Created by Александр on 25/01/2022.
//

import Foundation

protocol WatchlistViewModelProtocol {
    func fetchMovies(completion: @escaping() -> Void)
    func numberOfRows() -> Int
    func sellViewModel(at indexPath: IndexPath) -> WatchlistCellViewModelProtocol
    func deleateSaveMovie(at indexPath: IndexPath)
}

class WatchlistViewModel: WatchlistViewModelProtocol {
    
    private var saveMovies: [SaveMovie] = []
    
    func fetchMovies(completion: @escaping () -> Void) {
        StorageManager.shared.fetchData { result in
            switch result {
            case .success(let movies):
                saveMovies = movies
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfRows() -> Int {
        saveMovies.count
    }
    
    func sellViewModel(at indexPath: IndexPath) -> WatchlistCellViewModelProtocol {
        let movie = saveMovies[indexPath.row]
        return WatchlistCellViewModel(saveMovie: movie)
    }
    
    func deleateSaveMovie(at indexPath: IndexPath) {
        let movie = saveMovies[indexPath.row]
        saveMovies.remove(at: indexPath.row)
        StorageManager.shared.delete(movie)
    }
}
