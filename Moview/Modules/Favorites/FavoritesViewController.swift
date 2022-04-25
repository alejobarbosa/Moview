//
//  FavoritesViewController.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 21/04/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol IFavoritesViewController: AnyObject {
	var router: IFavoritesRouter? { get set }
    func reloadTableView()
}

class FavoritesViewController: BaseViewController {
    
    @IBOutlet weak var tableViewMovies: UITableView!
	var interactor: IFavoritesInteractor?
	var router: IFavoritesRouter?

	override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.interactor?.fetchFavorites()
        self.tableViewMovies.reloadData()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setUpViews(){
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

extension FavoritesViewController: IFavoritesViewController {
	
    func reloadTableView(){
        self.tableViewMovies.reloadData()
    }
    
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = (self.interactor?.movies.count ?? 0)
        self.tableViewMovies.isScrollEnabled = count > 0
        return count == 0 ? 1 : count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (self.interactor?.movies.isEmpty ?? true) {
            if let cell = tableView.dequeueReusableCell(withIdentifier: EmptyCell.identifier,
                                                        for: indexPath) as? EmptyCell {
                cell.isUserInteractionEnabled = false
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier,
                                                        for: indexPath) as? MovieCell,
               let movies = interactor?.movies {
                cell.setDataFavorite(movieCD: movies[indexPath.row])
                cell.callbackFavCDClick = { movie in
                    self.interactor?.removeFavorite(id: Int(movie.id))
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
            self.router?.navigateToDetail(movieCD: movie)
        }
    }
    
}
