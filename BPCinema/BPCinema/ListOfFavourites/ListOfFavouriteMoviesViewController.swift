//
//  ListOfFavourites.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 29.03.2024.
//

import Foundation

import Foundation
import UIKit

final class ListOfFavouriteMoviesViewController: UIViewController {
    private let presenter: ListOfFavouriteMoviesPresentable
    
    private var moviesTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.estimatedRowHeight = 120
        tv.rowHeight = UITableView.automaticDimension
        tv.register(MovieCellView.self, forCellReuseIdentifier: "MovieCellView")
        return tv
    }()
    
    init(presenter: ListOfFavouriteMoviesPresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        setupView()
        presenter.onViewAppear()
    }
    
    private func setupView() {
        view.addSubview(moviesTableView)
        
        NSLayoutConstraint.activate([
            moviesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            moviesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
    }
}

extension ListOfFavouriteMoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "MovieCellView",
            for: indexPath) as? MovieCellView else {
            fatalError()
        }
        let model = presenter.viewModels[indexPath.row]
        cell.configure(model: model)
        return cell
    }
}

extension ListOfFavouriteMoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.onTapCell(atIndex: indexPath.row)
    }
}

extension ListOfFavouriteMoviesViewController: ListOfFavouriteMoviesUI {
    func update(movies: [MovieViewModel]) {
        DispatchQueue.main.async {
            self.moviesTableView.reloadData()
        }
    }
}
