//
//  ListOfMoviesView.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 18.03.2024.
//

import Foundation
import UIKit
import PinLayout

final class ListOfMoviesViewController: UIViewController {
    var presenter: ListOfMoviesPresenterProtocol? {
        didSet {
            guard var presenter else { return }
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
        configureSubviews()
    }
    
    private func configureSubviews() {
        setupView()
    }
    
    private func setupView() {
        view.addSubview(moviesTableView)
        
        moviesTableView.pin.all()

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

extension ListOfMoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: MovieCellView.self),
            for: indexPath) as? MovieCellView else {
            fatalError()
        }
        cell.viewModel = viewModel.movies[indexPath.row]
        return cell
    }
}

extension ListOfMoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.input.movieSelected?(indexPath.row)
    }
}
