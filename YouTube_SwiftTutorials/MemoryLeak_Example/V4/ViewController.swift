// ViewController.swift
// Button_MemLeak_V4
//
// Created by ATS on 3/20/24
// Xcode 15.2
// Refactored by Claude on 3/23/24
//

/*
Abstract:
    A view controller manages a view hierarchy and the state information needed to keep those views up-to-date
    This version demonstrates navigation between view controllers using a button
References:
    View Controller Programming Guide for iOS - Apple Developer Documentation
    https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/
    https://developer.apple.com/documentation/uikit/uiviewcontroller
    https://developer.apple.com/documentation/uikit/uibutton
*/

import UIKit

class ViewController: UIViewController {
    // Declare the button as a property to keep a reference to it
    let button = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the button
        button.setTitle("Tap Me", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        // Add the button as a subview of the view controller's view
        view.addSubview(button)
        
        // Enable Auto Layout for the button
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and activate constraints for the button
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // Selector method called when the button is tapped
    @objc private func didTapButton() {
        let secondVC = SecondVC()
        present(secondVC, animated: true)
    }
}

class SecondVC: UIViewController {
    // Declare the button as a property to keep a reference to it
    let backButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the background color of the view to red
        view.backgroundColor = .red
        
        // Configure the back button
        backButton.setTitle("Go Back", for: .normal)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        // Add the back button as a subview of the view controller's view
        view.addSubview(backButton)
        
        // Enable Auto Layout for the back button
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and activate constraints for the back button
        NSLayoutConstraint.activate([
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 200),
            backButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // Selector method called when the back button is tapped
    @objc private func didTapBackButton() {
        dismiss(animated: true)
    }
}
