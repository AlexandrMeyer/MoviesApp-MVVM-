//
//  WatchlistCellViewModel.swift
//  MoviesApp
//
//  Created by Александр on 25/01/2022.
//

import Foundation

protocol WatchlistCellViewModelProtocol {
    var title: String? { get }
    var description: String? { get }
    var image: Data? { get }
    init(saveMovie: SaveMovie?)
}

class WatchlistCellViewModel: WatchlistCellViewModelProtocol {
    let saveMovie: SaveMovie?
    
    var title: String? {
        saveMovie?.title
    }
    
    var description: String? {
        "Kinopoisk: \(saveMovie?.kinopoiskRating ?? "") IMDB: \(saveMovie?.imdbRating ?? "")"
    }
    
    var image: Data? {
        ImageManager.shared.fetchImageData(from: saveMovie?.poster)
    }
    
    required init(saveMovie: SaveMovie?) {
        self.saveMovie = saveMovie
    }
}
