//
//  FilmDetailViewModelProtocol.swift
//  MoviesApp
//
//  Created by Александр on 11.12.21.
//

import Foundation

protocol FilmDetailViewModelProtocol {
    var filmName: String { get }
    init(film: Film)
}

class FilmDetailViewModel: FilmDetailViewModelProtocol {
    var filmName: String {
        film.title
    }
    
    private let film: Film
    
    required init(film: Film) {
        self.film = film
    }
}
