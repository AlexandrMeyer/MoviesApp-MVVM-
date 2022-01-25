//
//  DetailMovieViewModelProtocol.swift
//  MoviesApp
//
//  Created by Александр on 11.12.21.
//

import Foundation

protocol DetailMovieViewModelProtocol {
    var title: String { get }
    var kinopoiskRating: String? { get }
    var imdbRating: String? { get }
    var directors: String? { get }
    var year: String? { get }
    var description: String? { get }
    var actors: String? { get }
    var posterData: Data? { get }
    init(film: Film)
    
    func addToWatchlistButtonTapped()
}

class FilmDetailViewModel: DetailMovieViewModelProtocol {
    
    
    var title: String {
        film.titleEn ?? film.title
    }
    
    var kinopoiskRating: String? {
        "Kinopoisk: \(film.kinopoiskRating ?? "")"
    }
    
    var imdbRating: String? {
        "IMDB: \(film.imdbRating ?? "")"
    }
    
    var directors: String? {
        "Director: \(film.directors?.first ?? "")"
    }
    
    var year: String? {
        guard let year = film.year else { return "" }
        return String(year)
    }
    
    var description: String? {
        film.description ?? ""
    }
    
    var actors: String? {
        "Actors: \(film.actors.map{ $0.joined(separator: ", ") } ?? "")"
    }
    
    var posterData: Data? {
        ImageManager.shared.fetchImageData(from: film.poster)
    }
    
    private let film: Film
    
    required init(film: Film) {
        self.film = film
    }
    
    func addToWatchlistButtonTapped() {
        StorageManager.shared.save(film)
    }
}
