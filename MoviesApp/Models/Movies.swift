//
//  Movies.swift
//  MoviesApp
//
//  Created by Александр on 11.12.21.
//

import Foundation

struct Movies: Codable {
    let movies: [Film]
}

struct Film: Codable {
    let title: String
    let titleEn: String?
    let description: String?
    let poster: String?
    let year: Int?
    let directors: [String]?
    let actors: [String]?
    let countries: [String]?
    let genres: [String]?
    let kinopoiskRating: String?
    let imdbRating: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case titleEn = "title_alternative"
        case description
        case poster
        case year
        case actors
        case directors
        case countries
        case genres
        case kinopoiskRating = "rating_kinopoisk"
        case imdbRating = "rating_imdb"
    }
}
