// ViewController.swift
// Button_MemLeak_V2
//
// Created by ATS on 3/20/24
// Xcode 15.2
// Refactored by Claude on 3/22/24
//

/*
Abstract:
    A view controller manages a view hierarchy and the state information needed to keep those views up-to-date
    This version demonstrates creating a button using Auto Layout and constraints
References:
    Auto Layout Guide - Apple Developer Documentation
    https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/AutolayoutPG/
    https://developer.apple.com/documentation/uikit/nslayoutconstraint
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
        let vc = SecondVC()
        present(vc, animated: true)
    }
}

class SecondVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the background color of the view to red
        view.backgroundColor = .red
    }
    
    // Deinitializer to observe when SecondVC is deallocated
    deinit {
        print("SecondVC deinitializer called")
    }
}
