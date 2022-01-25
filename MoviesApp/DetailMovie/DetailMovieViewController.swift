//
//  DetailMovieViewController.swift
//  MoviesApp
//
//  Created by Александр on 10.12.21.
//

import UIKit

class DetailMovieViewController: UIViewController {
    
    lazy var detailImage: MovieImageView = {
        let imageView = MovieImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var addToWatchlistButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Add To Watchlist", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(addToWatchlist), for: .touchUpInside)
        return button
    }()
    
    lazy var titleLabel = setupLabels(ofSize: 20)
    lazy var descriptionLabel = setupLabels(ofSize: 14, numberOfLines: 3)
    lazy var yearLabel = setupLabels(ofSize: 14)
    lazy var actorsLabel = setupLabels(ofSize: 14, numberOfLines: 2)
    lazy var directorLabel = setupLabels(ofSize: 14)
    lazy var kinopoiskRatingLabel = setupLabels(ofSize: 14)
    lazy var imdbRatingLabel = setupLabels(ofSize: 14)
    
    var film: Film!
    var viewModel: DetailMovieViewModelProtocol! {
        didSet {
            titleLabel.text = viewModel.title
            descriptionLabel.text = viewModel.description
            yearLabel.text = viewModel.year
            actorsLabel.text = viewModel.actors
            directorLabel.text = viewModel.directors
            kinopoiskRatingLabel.text = viewModel.kinopoiskRating
            imdbRatingLabel.text = viewModel.imdbRating
            guard let imageData = viewModel.posterData else {
                detailImage.image = UIImage(systemName: "photo")
                return
            }
            detailImage.image = UIImage(data: imageData)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationItem.largeTitleDisplayMode = .never
        
        viewModel = FilmDetailViewModel(film: film)
        
        setupNavigationBar()
        setupSubViews(
            detailImage,
            addToWatchlistButton,
            titleLabel,
            descriptionLabel,
            directorLabel,
            actorsLabel,
            yearLabel,
            kinopoiskRatingLabel,
            imdbRatingLabel
        )
        setDetailImageConstraints()
        setTitleLableConstraints()
        setAddToWatchlistButtonConstraints()
        setDescriptionLabelConstraints()
        setYearLabelConstraints()
        setActorLabelConstraints()
        setDirectorLabelConstraints()
        setKinopoiskRatingLableConstraints()
        setIMDBRatingLableConstraints()
    }
    
    private func setupSubViews(_ subViews: UIView...) {
        subViews.forEach { subView in
            view.addSubview(subView)
        }
    }
    
    private func setupNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.backgroundColor = .black
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    @objc private func addToWatchlist() {
        viewModel.addToWatchlistButtonTapped()
        present(AlertController.shared.showAlert(with: viewModel.title), animated: true, completion: nil)
    }
}

extension DetailMovieViewController {
    private func setupLabels(ofSize: CGFloat, numberOfLines: Int? = 2) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: ofSize)
        label.textColor = .white
        label.numberOfLines = numberOfLines!
        return label
    }
    
    private func setupButton(title: String, color: UIColor, action: Selector) -> UIButton {
        let button = UIButton()
        button.backgroundColor = color
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    
    private func setDetailImageConstraints() {
        NSLayoutConstraint.activate([
            detailImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            detailImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            detailImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            detailImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height / 2)
        ])
    }
    
    private func setTitleLableConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: detailImage.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
    
    private func setKinopoiskRatingLableConstraints() {
        NSLayoutConstraint.activate([
            kinopoiskRatingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            kinopoiskRatingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        ])
    }
    
    private func setIMDBRatingLableConstraints() {
        NSLayoutConstraint.activate([
            imdbRatingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            imdbRatingLabel.leadingAnchor.constraint(equalTo: kinopoiskRatingLabel.trailingAnchor, constant: 10)
        ])
    }
    
    private func setYearLabelConstraints() {
        NSLayoutConstraint.activate([
            yearLabel.topAnchor.constraint(equalTo: kinopoiskRatingLabel.bottomAnchor, constant: 10),
            yearLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            yearLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
    
    private func setDirectorLabelConstraints() {
        NSLayoutConstraint.activate([
            directorLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 10),
            directorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            directorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
    
    private func setActorLabelConstraints() {
        NSLayoutConstraint.activate([
            actorsLabel.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: 10),
            actorsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            actorsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
    
    private func setDescriptionLabelConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: actorsLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
    
    private func setAddToWatchlistButtonConstraints() {
        NSLayoutConstraint.activate([
            addToWatchlistButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(addToWatchlistButton.frame.height + 10)),
            addToWatchlistButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addToWatchlistButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
