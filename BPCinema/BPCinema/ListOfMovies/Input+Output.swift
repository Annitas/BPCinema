//
//  Input+Output.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 16.04.2024.
//

struct Output {
    var viewModel: MovieListViewModel = .init(movies: [])
}
struct Input {
    var movieSelected: ((Int) -> ())?
}
