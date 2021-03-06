//
//  HomeViewController.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 21/04/22.
//  Copyright (c) 2022 Luis Alejandro Barbosa Lee. All rights reserved.

import UIKit

protocol IHomeViewController: AnyObject {
	var router: IHomeRouter? { get set }
    func showError(message: String)
    func showData()
}

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tableViewMovies: UITableView!
    
	var interactor: IHomeInteractor?
	var router: IHomeRouter?

	override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showActivityIndicator(show: true)
        self.interactor?.isNewCall = true
        self.interactor?.getPopularMovies()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setUpViews(){
        self.lblTitle.text = HomeModel.Texts.titleLabel
        self.tableViewMovies.delegate = self
        self.tableViewMovies.dataSource = self
        self.tableViewMovies.register(MovieCell.nib,
                                        forCellReuseIdentifier: MovieCell.identifier)
        self.tableViewMovies.register(EmptyCell.nib,
                                        forCellReuseIdentifier: EmptyCell.identifier)
        self.tableViewMovies.separatorStyle = .none
    }
    
    func scrollTop(){
        self.tableViewMovies.setContentOffset(.init(), animated:true)
    }
}

extension HomeViewController: IHomeViewController {
    func showError(message: String){
        self.showActivityIndicator(show: false)
        self.showErrorView(message: message)
    }
    
    func showData(){
        self.showActivityIndicator(show: false)
        self.tableViewMovies.reloadData()
    }
    
    func hideProgress(){
        self.showActivityIndicator(show: false)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = (self.interactor?.movies.count ?? 0)
        self.tableViewMovies.isScrollEnabled = count > 0
        return count == 0 ? 1 : count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (self.interactor?.movies.isEmpty ?? true) {
            if let cell = tableView.dequeueReusableCell(withIdentifier: EmptyCell.identifier,
                                                        for: indexPath) as? EmptyCell {
                cell.setData(text: HomeModel.Texts.emptyCellDescription)
                cell.isUserInteractionEnabled = false
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier,
                                                        for: indexPath) as? MovieCell,
               let movies = interactor?.movies {
                cell.setData(movie: movies[indexPath.row])
                cell.callbackFavClick = { movie in
                    if movie.isFav {
                        self.interactor?.saveFavorite(movie: movie, index: indexPath.row)
                    } else {
                        self.interactor?.removeFavorite(id: movie.id ?? 0)
                    }
                }
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let count = (self.interactor?.movies.count ?? 0)
        return count == 0 ? UIScreen.main.bounds.height * 0.7 : MovieCell.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movie = self.interactor?.movies[indexPath.row] {
            self.router?.navigateToDetail(movie: movie)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            self.interactor?.getMoreMovies()
        }
    }
    
}
