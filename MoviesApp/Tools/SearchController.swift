//
//  SearchController.swift
//  MoviesApp
//
//  Created by Александр on 25/01/2022.
//

import UIKit

class SearchController {
    
    static let shared = SearchController()
    
    private init() {}
    
    let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return searchController
    }()
    
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
}
