//
//  HomeVC.swift
//  Movie app
//
//  Created by Mohamed Rizk on 01/07/2025.
//

import UIKit
import Combine

final class HomeVC: UIViewController {
    
    @IBOutlet weak var uiCollectionView: UICollectionView!
    
    private let viewModel: HomeViewModel
    private var cancellables = Set<AnyCancellable>()
    var onMovieSelected: ((Movie) -> Void)?
    private let refreshControl = UIRefreshControl()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMoviesInitial()
    }
    
    private func setupUI() {
        uiCollectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
        uiCollectionView.collectionViewLayout = makeLayout()
        uiCollectionView.dataSource = self
        uiCollectionView.delegate = self
        
        refreshControl.addTarget(self, action: #selector(refreshMovies), for: .valueChanged)
        uiCollectionView.refreshControl = refreshControl
    }
    
    private func bindViewModel() {
        viewModel.$movies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
                self?.uiCollectionView.reloadData()
            }
            .store(in: &cancellables)
    }

    @objc private func refreshMovies() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        view.isUserInteractionEnabled = false

        Task {
            defer {
                refreshControl.endRefreshing()
                view.isUserInteractionEnabled = true
            }

            do {
                try await viewModel.loadMovies()
            } catch {
                showAlert(message: error.localizedDescription)
            }
        }
    }
    
    private func loadMoviesInitial() {
        view.isUserInteractionEnabled = false
        Task {
            LoadingIndicator.shared.show(in: view)
            defer {
                LoadingIndicator.shared.hide()
                view.isUserInteractionEnabled = true
            }
            do {
                try await viewModel.loadMovies()
            } catch {
                showAlert(message: error.localizedDescription)
            }
        }
    }
    
    private func makeLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(150)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(150)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        section.interGroupSpacing = 16

        return UICollectionViewCompositionalLayout(section: section)
    }

}

extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = viewModel.movies[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.configure(with: movie)
        cell.onFavoriteTapped = { [weak self] in
            self?.viewModel.toggleFavorite(for: movie.id)
            UIView.performWithoutAnimation {
                collectionView.reloadItems(at: [indexPath])
            }
        }
        return cell
    }
}

extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = viewModel.movies[indexPath.item]
        onMovieSelected?(selectedMovie)
    }
}
