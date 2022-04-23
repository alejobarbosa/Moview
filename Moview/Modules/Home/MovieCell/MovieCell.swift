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
    var callbackFavClick: ((Movie) -> ())!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewContnent.layer.cornerRadius = 10
        self.imgPoster.layer.cornerRadius = 10
    }
    
    func setData(movie: Movie, isFav: Bool){
        self.movie = movie
        if let posterPaht = movie.posterPath {
            let urlString = ServicesConstants.URL().getImageBaseURL() + posterPaht
            self.imgPoster.loadFromURL(urlString)
        }
        self.lblTitle.text = movie.title
        self.imgFav.image = isFav ? UIImage(named: "ic_fav_red") : UIImage(named: "ic_fav_black")
        self.lblRating.text = movie.voteAverage?.description
        self.lblDate.text = movie.releaseDate
        self.lblDescription.text = movie.overview
    }
    
    @IBAction func onFavClick(_ sender: Any) {
        self.callbackFavClick(self.movie)
    }
    
    
}
