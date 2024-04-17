//
//  MovieCellView.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 19.03.2024.
//

import Foundation
import UIKit
import Kingfisher

final class MovieCellView: UITableViewCell {
    var viewModel: MovieViewModel = MovieViewModel(title: "", overview: "", imageURL: URL(string: "")) {
        didSet {
            movieName.text = viewModel.title
            movieDescription.text = viewModel.overview
            movieImageView.kf.setImage(with: viewModel.imageURL)
        }
    }
    
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
        
//        movieImageView.pin
//                    .width(110)
//                    .height(180)
//                    .top(12)
//                    .left(12)
//                    .bottom(12)
//                
//                movieName.pin
//                    .after(of: movieImageView)
//                    .marginTop(5)
//                    .right(11)
//                    .marginLeft(18)
//                
//                movieDescription.pin
//                    .below(of: movieName)
//                    .right(11)
//                    .left(to: movieName.edge.left)
//                    .bottom(-12)
//                    .marginLeft(18)

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
}
