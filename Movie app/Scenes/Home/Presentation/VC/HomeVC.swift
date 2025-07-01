//
//  HomeVC.swift
//  Movie app
//
//  Created by Mohamed Rizk on 01/07/2025.
//

import UIKit
import Combine

final class HomeVC: UIViewController {
    
    private let viewModel: HomeViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        
        Task {
            await viewModel.loadMovies()
        }
    }
    
    private func bindViewModel() {
        viewModel.$movies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
                print("First movie:", movies.first?.title ?? "None")
            }
            .store(in: &cancellables)
    }
}
