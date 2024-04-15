//
//  ListOfMoviesView.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 18.03.2024.
//

import Foundation
import UIKit
import PinLayout

struct MovieListViewModel {
    let movies: [MovieViewModel]
}

final class ListOfMoviesViewController: UIViewController {
    var presenter: ListOfMoviesPresenter? {
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
    
    let tableView: UITableView = .init()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        configureSubviews()
    }
    
    private func configureSubviews() {
        setupView()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        // Установка цвета фона для UITabBar
//        tabBarController?.tabBar.barTintColor = .systemBackground
//    }

    
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
