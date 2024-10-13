//
// RickAndMorty
// RMTabBarViewController.swift
//
// Created on 9/28/24
// Updated on 10/13/24
// Swift Version 6.0
//
// ATS Project
//   Tutor: Afraz Siddiqui - iOS Academy YouTube
//


import UIKit

final class RMTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .blue
        setupTabs()
    }

    private func setupTabs() {
        let charactersVC = RMCharacterViewController()
        let episodesVC = RMEpisodeViewController()
        let locationsVC = RMLocationViewController()
        let settingsVC = RMSettingsViewController()
        
        charactersVC.navigationItem.largeTitleDisplayMode = .automatic
        episodesVC.navigationItem.largeTitleDisplayMode = .automatic
        locationsVC.navigationItem.largeTitleDisplayMode = .automatic
        settingsVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1 = UINavigationController(rootViewController: charactersVC)
        let nav2 = UINavigationController(rootViewController: episodesVC)
        let nav3 = UINavigationController(rootViewController: locationsVC)
        let nav4 = UINavigationController(rootViewController: settingsVC)

        // Image data references SF Symbols library        
        nav1.tabBarItem = UITabBarItem(title: "Characters",
                                       //image: UIImage(systemName: "􀉩"),
                                       image: UIImage(systemName: "person"),
                                       tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Episodes",
                                       //image: UIImage(systemName: "􀎲"),
                                       image: UIImage(systemName: "tv"),
                                       tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Locations",
                                       //image: UIImage(systemName: "􀆪"),
                                       image: UIImage(systemName: "globe"),
                                       tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "Settings",
                                       //image: UIImage(systemName: "􀍟"),
                                       image: UIImage(systemName: "gear"),
                                       tag: 4)
        
        for nav in [nav1, nav2, nav3, nav4] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: true)
        
    }
    
}

