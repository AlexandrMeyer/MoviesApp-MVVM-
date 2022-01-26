//
//  MoviesCellViewModel.swift
//  MoviesApp
//
//  Created by Александр on 25/01/2022.
//

import Foundation

protocol MoviesCellViewModelProtocol {
    var posterData: Data? { get }
    var descriptionLabel: String { get }
    init(film: Film?)
}

class MoviesCellViewModel: MoviesCellViewModelProtocol {
    
    var posterData: Data? {
        ImageManager.shared.fetchImageData(from: film?.poster)
    }
    
    var descriptionLabel: String {
               """
        \(film?.titleEn ?? "\(film?.title ?? "")")
        \(film?.year ?? 0) \(film?.genres?.first ?? "")
        """
        
    }
    
    private let film: Film?
    
    required init(film: Film?) {
        self.film = film
    }
}
