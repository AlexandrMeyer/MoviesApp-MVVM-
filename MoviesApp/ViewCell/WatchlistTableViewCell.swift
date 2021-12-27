//
//  WatchlistTableViewCell.swift
//  MoviesApp
//
//  Created by Александр on 19.12.21.
//

import UIKit

class WatchlistTableViewCell: UITableViewCell {
    
    let movieImage: MovieImageView = {
        let imageView = MovieImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 18)
        titleLabel.textColor = .white
        return titleLabel
    }()
    
    let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = .white
        return descriptionLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubViews(movieImage, titleLabel, descriptionLabel)
        setImageConstraints()
        setTitleLabelConstraints()
        setDescriptionLabelConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubViews(_ subViews: UIView...) {
        subViews.forEach { subView in
            contentView.addSubview(subView)
        }
    }
    
    private func setImageConstraints() {
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            movieImage.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 108),
            movieImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    private func setTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 55),
            titleLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
        ])
    }
    
    private func setDescriptionLabelConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
        ])
    }
    
    func configure(with movie: SaveMovie?) {
        titleLabel.text = movie?.title
        descriptionLabel.text = "Kinopoisk: \(movie?.kinopoiskRating ?? "") IMDB: \(movie?.imdbRating ?? "")"
        guard let stringURL = movie?.poster else { return }
        movieImage.fetchImage(from: stringURL)
    }
}


