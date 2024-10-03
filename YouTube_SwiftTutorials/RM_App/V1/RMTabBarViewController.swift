//
// RickAndMorty
// RMTabBarViewController.swift
//
// Created on 9/28/24
// Updated on 10/2/24
// Swift Version 6.0
//
// ATS Project
//   Tutor: Afraz Siddiqui - iOS Academy YouTube
//


import UIKit

final class RMTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setupTabs()
    }

    private func setupTabs() {
        let characterVC = RMCharacterViewController()
        let episodeVC = RMEpisodeViewController()
        let locationVC = RMLocationViewController()
        let settingsVC = RMSettingsViewController()
        
        characterVC.title = "Characters"
        episodeVC.title = "Episodes"
        locationVC.title = "Locations"
        settingsVC.title = "Settings"
        
        let nav1 = UINavigationController(rootViewController: characterVC)
        let nav2 = UINavigationController(rootViewController: episodeVC)
        let nav3 = UINavigationController(rootViewController: locationVC)
        let nav4 = UINavigationController(rootViewController: settingsVC)
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: true)
    }
    
}

