//
//  FMovieCellView.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 03.04.2024.
//

import Foundation
import UIKit
import Kingfisher

final class FMovieCellView: UITableViewCell {
    private let movieImageView: UIImageView = {
        let imageV = UIImageView()
        imageV.contentMode = .scaleAspectFill
        imageV.clipsToBounds = true
        imageV.layer.cornerRadius = 10
        imageV.translatesAutoresizingMaskIntoConstraints = false
        return imageV
    }()
    
    private let movieName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 23, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(movieImageView)
        addSubview(movieName)
        addSubview(movieDescription)
        
        
        NSLayoutConstraint.activate([
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            movieImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            movieImageView.heightAnchor.constraint(equalToConstant: 180),
            movieImageView.widthAnchor.constraint(equalToConstant: 110),
            movieImageView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -12),
            
            movieName.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 18),
            movieName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11),
            movieName.topAnchor.constraint(equalTo: movieImageView.topAnchor, constant: 5),
            
            movieDescription.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 20),
            movieDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11),
            movieDescription.topAnchor.constraint(equalTo: movieName.bottomAnchor, constant: 8),
            movieDescription.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -12),
        ])
    }
    
    func configure(model: FavouriteMovieViewModel) {
        movieImageView.kf.setImage(with: model.imageURL)
        movieName.text = model.title
        movieDescription.text = model.overview
    }
}
