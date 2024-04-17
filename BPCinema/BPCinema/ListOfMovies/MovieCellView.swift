//
//  MovieCellView.swift
//  BPCinema
//
//  Created by Anita Stashevskaya on 19.03.2024.
//

import UIKit
import PinLayout

final class MovieCellView: UITableViewCell {
    var viewModel: MovieViewModel = MovieViewModel(title: "", overview: "", imageURL: URL(string: "")) {
        didSet {
            movieName.text = viewModel.title
            movieDescription.text = viewModel.overview
            movieImageView.kf.setImage(with: viewModel.imageURL)
        }
    }
    private let padding: CGFloat = 10
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
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    private func layout() {
        movieImageView.pin.topLeft(padding).height(180).width(110).bottom(padding)
        movieName.pin.after(of: movieImageView, aligned: .top).right().marginHorizontal(padding).sizeToFit(.width)

        movieDescription.pin.after(of: movieImageView).below(of: movieName).horizontally().margin(padding).sizeToFit(.width)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        // 1) Set the contentView's width to the specified size parameter
        contentView.pin.width(size.width)
        contentView.pin.height(size.height)
        // 2) Layout the contentView's controls
        layout()
        let cellHeight = (movieDescription.frame.maxY + movieName.frame.maxY) > movieImageView.frame.maxY ? (movieDescription.frame.maxY + movieName.frame.maxY) : movieImageView.frame.maxY
        // 3) Returns a size that contains all controls
        return CGSize(width: contentView.frame.width, height: cellHeight)
    }
}
