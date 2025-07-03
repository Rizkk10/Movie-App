//
//  MovieDetailsVC.swift
//  Movie app
//
//  Created by Mohamed Rizk on 02/07/2025.
//

import UIKit
import Combine
import Kingfisher

class MovieDetailsVC: UIViewController {
    
    @IBOutlet weak var uiMoviePoster: UIImageView!
    @IBOutlet weak var uiMovieTitle: UILabel!
    @IBOutlet weak var uiMovieRate: UILabel!
    @IBOutlet weak var uiFavoriteButton: UIButton!
    @IBOutlet weak var uiReleaseDate: UILabel!
    @IBOutlet weak var uiOrginalLanguage: UILabel!
    @IBOutlet weak var uiMovieOverview: UILabel!
    
    private let viewModel: MovieDetailsViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        bindViewModel()
        configureUI()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    private func bindViewModel() {
        viewModel.$movie
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.configureUI()
            }
            .store(in: &cancellables)
    }
    
    private func configureUI() {
        let movie = viewModel.movie
        
        uiMovieTitle.text = movie.title
        uiMovieRate.text = "Rating: \(movie.voteAverage)"
        uiReleaseDate.text = "Release Date: \(movie.releaseDate)"
        uiOrginalLanguage.text = "Language: \(movie.originalLanguage.uppercased())"
        uiMovieOverview.text = movie.overview
        
        if let imageData = movie.posterImage, let image = UIImage(data: imageData) {
            uiMoviePoster.image = image
        } else if let path = movie.posterPath {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
            uiMoviePoster.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
        } else {
            uiMoviePoster.image = UIImage(systemName: "photo")
        }
        
        let imageName = movie.isFavorite == true ? "heart.fill" : "heart"
        uiFavoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
        uiFavoriteButton.tintColor = .systemRed
    }
    
    @IBAction func favoriteButtonAction(_ sender: Any) {
        viewModel.toggleFavorite()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension MovieDetailsVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
