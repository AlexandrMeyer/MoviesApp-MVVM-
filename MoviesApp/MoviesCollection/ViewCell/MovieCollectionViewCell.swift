//
//  MovieCollectionViewCell.swift
//  MoviesApp
//
//  Created by Александр on 11.12.21.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    let posterImage: MovieImageView = {
        let imageView = MovieImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 4
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(white: 0.7, alpha: 1)
        return label
    }()
    
    var viewModel: MoviesCellViewModelProtocol! {
        didSet {
            descriptionLabel.text = viewModel.descriptionLabel
            guard let stringURL = viewModel.posterImage else { return }
            posterImage.fetchImage(from: stringURL)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImage)
        contentView.addSubview(descriptionLabel)
        setImageConstraints()
        setlabelConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setImageConstraints() {
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50)
        ])
    }
    
    private func setlabelConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }
}
