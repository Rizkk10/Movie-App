//
//  MovieDetailsVC.swift
//  Movie app
//
//  Created by Mohamed Rizk on 02/07/2025.
//

import UIKit

class MovieDetailsVC: UIViewController {

    @IBOutlet weak var uiMoviePoster: UIImageView!
    @IBOutlet weak var uiMovieTitle: UILabel!
    @IBOutlet weak var uiMovieRate: UILabel!
    @IBOutlet weak var uiFavoriteButton: UIButton!
    @IBOutlet weak var uiReleaseDate: UILabel!
    @IBOutlet weak var uiVoteAverage: UILabel!
    @IBOutlet weak var uiOrginalLanguage: UILabel!
    @IBOutlet weak var uiMovieOverview: UILabel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func favoriteButtonAction(_ sender: Any) {
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
    }
    
}
