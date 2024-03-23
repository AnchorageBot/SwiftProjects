// ViewController.swift
// Button_MemLeak_V2
//
// Created by ATS on 3/20/24
// Xcode 15.2
// Commented by Claude on 3/22/2024
//
/*
Abstract:
    A view controller manages a view hierarchy and the state information needed to keep those views up-to-date
    This version has a deliberate memory leak that we are going to observe & debug
References:
    Memory Leaks in iOS: Find, Diagnose, & Fix (2022) - iOS Academy
    https://youtu.be/b2AgibUg47k?si=9jQEygRl1zKh5d7s
    https://developer.apple.com/tutorials/app-dev-training/managing-content-views/
    https://developer.apple.com/documentation/uikit/view_controllers/displaying_and_managing_views_with_a_view_controller
    https://developer.apple.com/documentation/uikit/view_controllers/managing_content_in_your_app_s_windows/
    https://developer.apple.com/documentation/uikit/uicollectionviewcell/1620133-contentview/
*/

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a UIButton instance
        let button = UIButton()
        
        // Set the button's title for the normal state
        button.setTitle("Tap Me", for: .normal)
        
        // Set the button's frame to a specific size and position
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        
        // Center the button within the view
        button.center = view.center
        
        // Add a target action for the button when it's tapped
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        // Add the button as a subview of the view controller's view
        view.addSubview(button)
    }
    
    // Selector method called when the button is tapped
    @objc private func didTapButton() {
        // Create an instance of SecondVC
        let vc = SecondVC()
        
        // Present the SecondVC modally with animation
        present(vc, animated: true)
    }
}

class MyView: UIView {
    // A reference to a UIViewController
    let vc: UIViewController
    
    // Initializer that takes a UIViewController as a parameter
    init(vc: UIViewController) {
        self.vc = vc
        super.init(frame: .zero)
    }
    
    // Required initializer for NSCoder
    required init?(coder: NSCoder) {
        fatalError()
    }
}

class SecondVC: UIViewController {
    // An optional reference to a MyView instance
    var myView: MyView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the background color of the view to red
        view.backgroundColor = .red
        
        // Create an instance of MyView and assign it to myView
        myView = MyView(vc: self)
    }
}
