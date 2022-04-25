//
//  HomeViewController.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 21/04/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol IHomeViewController: AnyObject {
	var router: IHomeRouter? { get set }
    func showError(message: String)
    func showData()
}

class HomeViewController: BaseViewController {
    
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
        self.interactor?.getPopularMovies()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setUpViews(){
        self.tableViewMovies.delegate = self
        self.tableViewMovies.dataSource = self
        self.tableViewMovies.register(MovieCell.nib,
                                        forCellReuseIdentifier: MovieCell.identifier)
        self.tableViewMovies.separatorStyle = .none
    }
}

extension HomeViewController: IHomeViewController {
    func showError(message: String){
        self.showActivityIndicator(show: false)
        self.showErrorView(message: message)
    }
    
    func showData(){
        if (self.interactor?.isNewCall ?? true) {
            self.tableViewMovies.setContentOffset(.init(), animated:true)
        }
        self.showActivityIndicator(show: false)
        self.tableViewMovies.reloadData()
    }
    
    func hideProgress(){
        self.showActivityIndicator(show: false)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.interactor?.movies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MovieCell.height
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
