//
// RickAndMorty
// RMSettingsViewController.swift
//
// Created on 9/28/24
// Updated on 10/13/24
// Swift Version 6.0
//
// ATS Project
//   Tutor: Afraz Siddiqui - iOS Academy YouTube
//


import UIKit

// Controller to show various app options and settings
final class RMSettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Supports changes to background color, light mode or dark mode
        view.backgroundColor = .systemBackground
        title = "Settings"
    }
    
}
