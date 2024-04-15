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
    var presenter: ListOfFavouriteMoviesPresenter? {
        didSet {
            guard let presenter else { return }
            viewModel = presenter.output.viewModel
            presenter.outputChanged = { [weak self] in
                self?.viewModel = presenter.output.viewModel
            }
        }
    }
    
    var viewModel: MovieListViewModel = MovieListViewModel(movies: []) {
        didSet {
            moviesTableView.reloadData()
        }
    }
    
    private var moviesTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.estimatedRowHeight = 120
        tv.rowHeight = UITableView.automaticDimension
        tv.register(MovieCellView.self, forCellReuseIdentifier: "MovieCellView")
        return tv
    }()
    
    private lazy var spinner: CustomSpinner = {
        let spinner = CustomSpinner(squareLength: 100)
        return spinner
    }()
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.showSpinner()
    }
    
    private func setupView() {
        view.addSubview(moviesTableView)
        view.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            moviesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            moviesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
    }
    
    private func showSpinner() {
        spinner.startAnimation(delay: 0.04, replicates: 20)
        spinner.isHidden = false
    }
    
    private func hideSpinner() {
        spinner.stopAnimation()
        spinner.isHidden = true
    }
}

extension ListOfFavouriteMoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "MovieCellView",
            for: indexPath) as? MovieCellView else {
            fatalError()
        }
        cell.viewModel = viewModel.movies[indexPath.row]
        return cell
    }
}

extension ListOfFavouriteMoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.input.movieSelected?(indexPath.row)
    }
}
