//
//  MovieCell.swift
//  Movie app
//
//  Created by Mohamed Rizk on 01/07/2025.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell {

    @IBOutlet weak var uiContentView: UIStackView!
    @IBOutlet weak var uiMoviePoster: UIImageView!
    @IBOutlet weak var uiMovieTitle: UILabel!
    @IBOutlet weak var uiMovieRate: UILabel!
    @IBOutlet weak var uiMovieDate: UILabel!
    @IBOutlet weak var uiFavoriteButton: UIButton!
    
    var onFavoriteTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        uiContentView.layer.cornerRadius = 8
        uiMoviePoster.layer.cornerRadius = 8
    }
    
    func configure(with movie: Movie) {
        uiMovieTitle.text = movie.title
        uiMovieRate.text = "⭐️ \(movie.voteAverage)"
        uiMovieDate.text = movie.releaseDate

        if let imageData = movie.posterImage, let image = UIImage(data: imageData) {
            uiMoviePoster.image = image
        } else if let posterPath = movie.posterPath {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
            uiMoviePoster.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
        } else {
            uiMoviePoster.image = UIImage(systemName: "photo")
        }

        let imageName = movie.isFavorite == true ? "heart.fill" : "heart"
        uiFavoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
        uiFavoriteButton.tintColor = .systemRed
    }

    @IBAction func favoriteButtonAction(_ sender: Any) {
        onFavoriteTapped?()
    }
    
}
