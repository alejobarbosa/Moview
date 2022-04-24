//
//  ViewController.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 21/04/22.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViewControllers()
        overrideUserInterfaceStyle = .dark
    }
    
    ///Method to set the viewcontrollers to the tabbar
    private func setUpViewControllers(){
        let home = HomeConfiguration.setup()
        home.tabBarItem = UITabBarItem(title: Constants.Titles.homeVC,
                                       image: UIImage(named: Constants.Images.icHomeWhite),
                                       tag: 0)
        let favorites = FavoritesConfiguration.setup()
        
        favorites.tabBarItem = UITabBarItem(title: Constants.Titles.favoritesVC,
                                            image: UIImage(named: Constants.Images.icFavWhite),
                                            tag: 0)
        let info = InfoViewController()
        info.tabBarItem = UITabBarItem(title: Constants.Titles.infoVC,
                                       image: UIImage(named: Constants.Images.icInfoWhite),
                                       tag: 0)
        let views = [home, favorites, info]
        self.viewControllers = views
    }


}

