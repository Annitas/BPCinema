//
//  DetailView.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 19.03.2024.
//

import Foundation
import UIKit
import Kingfisher

final class DetailMovieViewController: UIViewController {
    private let presenter: DetailPresentable
    
    private let movieImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let movieName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart.circle.fill"), for: .normal)
        button.tintColor = .label
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(presenter: DetailPresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        favoriteButton.addTarget(self, action: #selector(addToFavourites(_:)), for: .touchUpInside)
        setupView()
        presenter.onViewAppear()
    }
    @objc func addToFavourites(_ sender: UIButton) {
        Task {
            await addToFavouritesAsync()
        }
    }
    
    private func addToFavouritesAsync() async {
        await presenter.addToFavourites(withID: presenter.movieID)
    }
    
    private func setupView() {
        view.addSubview(movieImageView)
        view.addSubview(movieName)
        view.addSubview(movieDescription)
        view.addSubview(favoriteButton)
        
        NSLayoutConstraint.activate([
            movieImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            movieImageView.heightAnchor.constraint(equalToConstant: 200),
            movieImageView.widthAnchor.constraint(equalToConstant: 350),
            
            favoriteButton.topAnchor.constraint(equalTo: movieName.topAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: -10),
            
            movieName.leadingAnchor.constraint(equalTo: movieImageView.leadingAnchor),
            movieName.trailingAnchor.constraint(equalTo: movieImageView.trailingAnchor),
            movieName.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 10),
            
            movieDescription.topAnchor.constraint(equalTo: movieName.bottomAnchor, constant: 10),
            movieDescription.leadingAnchor.constraint(equalTo: movieImageView.leadingAnchor),
            movieDescription.trailingAnchor.constraint(equalTo: movieImageView.trailingAnchor),
        ])
    }
}

extension DetailMovieViewController: DetailPresenterUI {
    func updateUI(viewModel: DetailMovieViewModel) {
        movieImageView.kf.setImage(with: viewModel.backdropPath)
        movieName.text = viewModel.title
        movieDescription.text = viewModel.overview
    }
}
