//
//  TabBarViewController.swift
//  MoviesApp
//
//  Created by Александр on 11.12.21.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .black
        tabBar.barTintColor = .black
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .gray
        
        let moviesCollectionViewController = MoviesCollectionViewController()
        let icon1 = UITabBarItem(title: "Movies List", image: UIImage(systemName: "list.and.film"), selectedImage: UIImage(systemName: "list.and.film"))
        moviesCollectionViewController.tabBarItem = icon1
        
        let watchlistViewController = WatchlistTableViewController()
        let icon2 = UITabBarItem(title: "Watchlist", image: UIImage(systemName: "film"), selectedImage: UIImage(systemName: "film"))
        watchlistViewController.tabBarItem = icon2
        
        let listNavigationController = UINavigationController()
        listNavigationController.viewControllers = [moviesCollectionViewController]
        
        let watchlistNavigationController = UINavigationController()
        watchlistNavigationController.viewControllers = [watchlistViewController]
        
        let controllers = [listNavigationController, watchlistNavigationController]
        
        viewControllers = controllers
    }
}
