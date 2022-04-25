//
//  MovieCell.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 23/04/22.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var viewContnent: UIView!
    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet weak var imgFav: UIImageView!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    static let height:CGFloat = 200
    var movie: Movie!
    var movieCD: MovieCD!
    var callbackFavClick: ((Movie) -> ())!
    var callbackFavCDClick: ((MovieCD) -> ())!
    var isFav = false
    var isFromCoreData = false

    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewContnent.layer.cornerRadius = 10
        self.imgPoster.layer.cornerRadius = 10
    }
    
    func setData(movie: Movie){
        self.movie = movie
        if let posterPaht = movie.posterPath {
            let urlString = ServicesConstants.URL().getImageBaseURL() + posterPaht
            self.imgPoster.loadFromURL(urlString)
        }
        self.lblTitle.text = movie.title
        self.isFav = movie.isFav
        self.imgFav.image = movie.isFav ? UIImage(named: Constants.Images.icFavRed) :
                                            UIImage(named: Constants.Images.icFavBlack)
        self.lblRating.text = movie.voteAverage?.description
        self.lblDate.text = movie.releaseDate
        self.lblDescription.text = movie.overview
    }
    
    func setDataFavorite(movieCD: MovieCD){
        self.isFromCoreData = true
        self.movieCD = movieCD
        if let posterPaht = movieCD.posterPath {
            let urlString = ServicesConstants.URL().getImageBaseURL() + posterPaht
            self.imgPoster.loadFromURL(urlString)
        }
        self.lblTitle.text = movieCD.title
        self.imgFav.image = UIImage(named: Constants.Images.icFavRed)
        self.lblRating.text = movieCD.voteAverage.description
        self.lblDate.text = movieCD.releaseDate
        self.lblDescription.text = movieCD.overview
    }
    
    @IBAction func onFavClick(_ sender: Any) {
        if self.isFromCoreData {
            self.callbackFavCDClick(self.movieCD)
        } else {
            self.isFav = self.isFav ? false : true
            self.movie.isFav = self.isFav
            self.imgFav.image = self.isFav ? UIImage(named: Constants.Images.icFavRed) :
                                                UIImage(named: Constants.Images.icFavBlack)
            self.callbackFavClick(self.movie)
        }
    }
    
    
}
