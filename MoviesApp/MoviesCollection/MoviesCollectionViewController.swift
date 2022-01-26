//
//  MoviesCollectionViewController.swift
//  MoviesApp
//
//  Created by Александр on 10.12.21.
//

import UIKit

private let reuseIdentifier = "Cell"

class MoviesCollectionViewController: UICollectionViewController {
    
    let itemsPerRow: CGFloat = 3
    let sectionInserts = UIEdgeInsets(top: 10, left: 10, bottom: 25, right: 10)
    
    var viewModel: MoviesCollectionViewModelProtocol! {
        didSet {
            viewModel.fetchMovies {
                self.collectionView.reloadData()
                self.activityIndicator?.stopAnimating()
            }
        }
    }
    
    private var activityIndicator: UIActivityIndicatorView?
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MoviesCollectionViewModel()
        activityIndicator = showActivityIndicator(in: view)
        setupNavigationBar()
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .black
        setupSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func showActivityIndicator(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        return activityIndicator
    }
    
    private func setupNavigationBar() {
        title = "Movies List"
        
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.backgroundColor = .black
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}

// MARK: UICollectionViewDataSource
extension MoviesCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        
        cell.viewModel = viewModel.cellViewMode(at: indexPath)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MoviesCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailMovieVC = FilmDetailsViewController()
        let detailsVM = viewModel.detailsViewModel(at: indexPath)
        detailMovieVC.viewModel = detailsVM
        navigationController?.pushViewController(detailMovieVC, animated: true)
    }
}

extension MoviesCollectionViewController: UICollectionViewDelegateFlowLayout {
    // Устанавливаю размер ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingWidth: CGFloat = sectionInserts.left * (itemsPerRow + 1)
        let availibleWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availibleWidth / itemsPerRow
        let heightPerItem = 1.8 * widthPerItem
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    //  Устанавливаю отступы для секции от границы коллекции
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        sectionInserts
    }
    
    // Устанавливаю растояние по линия
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sectionInserts.bottom
    }
    
    // устанавливаю растояние между элементами
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sectionInserts.left
    }
}

extension MoviesCollectionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        viewModel.filterContentForSearchText(searchText) { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func setupSearchController() {
        navigationItem.searchController = SearchController.shared.searchController
        SearchController.shared.searchController.searchResultsUpdater = self
        SearchController.shared.searchController.obscuresBackgroundDuringPresentation = false
        SearchController.shared.searchController.automaticallyShowsSearchResultsController = true
        SearchController.shared.searchController.searchBar.placeholder = "Search"
        definesPresentationContext = true
    }
}
