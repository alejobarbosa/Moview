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
    
    ///Method to set the viewc ontrollers to the tabbar
    private func setUpViewControllers(){
        let home = HomeConfiguration.setup()
        home.tabBarItem = UITabBarItem(title: Constants.Titles.homeVC,
                                       image: UIImage(named: Constants.Images.icHomeWhite),
                                       tag: 0)
        let favorites = FavoritesConfiguration.setup()
        
        favorites.tabBarItem = UITabBarItem(title: Constants.Titles.favoritesVC,
                                            image: UIImage(named: Constants.Images.icFavWhite),
                                            tag: 1)
        let info = InfoViewController()
        info.tabBarItem = UITabBarItem(title: Constants.Titles.infoVC,
                                       image: UIImage(named: Constants.Images.icInfoWhite),
                                       tag: 2)
        let views = [home, favorites, info]
        self.viewControllers = views
    }
    
    
    ///Scroll to the top of table view
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let viewControllers = self.viewControllers else { return }
        if self.selectedViewController is HomeViewController && item.tag == 0 {
            for vc in viewControllers where vc is HomeViewController{
                (vc as! HomeViewController).scrollTop()
            }
        } else if self.selectedViewController is FavoritesViewController && item.tag == 1 {
            for vc in viewControllers where vc is FavoritesViewController{
//                (vc as! FavoritesViewController).scrollTop()
            }
        }
    }


}

