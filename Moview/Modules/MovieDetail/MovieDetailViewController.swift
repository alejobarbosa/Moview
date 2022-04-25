//
//  MovieDetailViewController.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 23/04/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol IMovieDetailViewController: AnyObject {
	var router: IMovieDetailRouter? { get set }
    func showError(message: String)
    func showData()
    func showTrailer()
    func hideProgress()
}

class MovieDetailViewController: BaseViewController {
    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var viewFav: UIView!
    @IBOutlet weak var imgFav: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblOriginalTitle: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblDateText: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblGenresText: UILabel!
    @IBOutlet weak var lblGenres: UILabel!
    @IBOutlet weak var lblDurationText: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblTagline: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var viewTrailer: UIView!
    @IBOutlet weak var lblTrailerText: UILabel!
    @IBOutlet weak var heightViewTrailer: NSLayoutConstraint!
    @IBOutlet weak var viewIMDb: UIView!
    @IBOutlet weak var lblWatchOnText: UILabel!
    
	var interactor: IMovieDetailInteractor?
	var router: IMovieDetailRouter?
    private var trailerKey = ""

	override func viewDidLoad() {
        super.viewDidLoad()
        self.embedInScroll(self.viewContent, height: 900)
        self.viewFav.layer.cornerRadius = 20
        self.setFirstData()
        self.showActivityIndicator(show: true)
        self.interactor?.getMovieDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        overrideUserInterfaceStyle = .dark
        self.navigationController?.navigationBar.barTintColor = .black
    }

    ///Method to load principal data until service detail response
    private func setFirstData(){
        guard let interactor = self.interactor else {
            return
        }
        if let posterPaht = interactor.movie.posterPath {
            let urlString = ServicesConstants.URL().getImageBaseURL() + posterPaht
            self.imgPoster.loadFromURL(urlString)
        }
        self.imgFav.image = interactor.isFavorite ?? false ?
                                    UIImage(named: Constants.Images.icFavRed) :
                                    UIImage(named: Constants.Images.icFavBlack)
        self.lblTitle.text = interactor.movie.title
        self.lblRating.text = interactor.movie.voteAverage?.description
    }
    
    @IBAction func onTrailerClick(_ sender: Any) {
        print("Click Tailer")
        let urlString = ServicesConstants.URL().getYoutubeBaseURL() + self.trailerKey
        self.router?.openLink(urlString)
    }
    
    @IBAction func onIMDbClick(_ sender: Any) {
        print("Click IMDb")
        let urlString = ServicesConstants.URL().getIMDbBaseURL() + (self.interactor?.movieDetail?.imdbID ?? "")
        self.router?.openLink(urlString)
    }
    
}

extension MovieDetailViewController: IMovieDetailViewController {
    func showError(message: String){
        self.showActivityIndicator(show: false)
        self.showErrorView(message: message)
    }
    
    func showData(){
        guard let movieDetail = self.interactor?.movieDetail else { return }
        self.lblTitle.text = movieDetail.title
        self.lblOriginalTitle.text = movieDetail.originalTitle ?? "" + MovieDetailModel.Texts.originalTitle
        self.lblRating.text = movieDetail.voteAverage?.description
        let dateText = (movieDetail.releaseDate?.isEmpty ?? true) ? "" : MovieDetailModel.Texts.date
        self.lblDateText.text = dateText
        self.lblDate.text = movieDetail.releaseDate
        if let genres = movieDetail.genres {
            let genresText = genres.isEmpty ? "" : MovieDetailModel.Texts.genres
            self.lblGenresText.text = genresText
            let genresArrStr = genres.map({$0.name})
            self.lblGenres.text = genresArrStr.joined(separator: ", ")
        }
        if let duration = movieDetail.runtime{
            self.lblDurationText.text = MovieDetailModel.Texts.duration
            let hours = Int(duration / 60)
            let min = Int(duration % 60)
            self.lblDuration.text = "\(hours)\("h ")\(min)\("m")"
        }
        self.lblTagline.text = movieDetail.tagline
        self.lblOverview.text = movieDetail.overview
        if let imdb = movieDetail.imdbID {
            self.viewIMDb.isHidden = imdb.isEmpty
            self.lblWatchOnText.text = imdb.isEmpty ? "" : MovieDetailModel.Texts.watchOn
            self.view.layoutSubviews()
        }
    }
    
    func showTrailer(){
        self.showActivityIndicator(show: false)
        guard let trailer = self.interactor?.trailer else { return }
        self.viewTrailer.isHidden = false
        self.heightViewTrailer.constant = 70
        self.view.layoutSubviews()
        self.lblTrailerText.text = MovieDetailModel.Texts.watchTrailer
        self.trailerKey = trailer.key ?? ""
    }
    
    func hideProgress(){
        self.showActivityIndicator(show: false)
    }
}
