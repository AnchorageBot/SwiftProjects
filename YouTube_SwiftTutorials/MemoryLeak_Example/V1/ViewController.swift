//
//  ViewController.swift
//  Button_MemLeak_V1
//
//  Created by ATS on 3/20/24
//  Xcode 15.2
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
        let button = UIButton()
        button.setTitle("Tap Me", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.center = view.center
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        view.addSubview(button)
    }

    @objc private func didTapButton() {
        let vc = SecondVC()
        present(vc, animated: true)
    }
}

class MyView: UIView {
    let vc: UIViewController
    init(vc: UIViewController) {
        self.vc = vc
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

class SecondVC: UIViewController {
    var myView: MyView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        myView = MyView(vc: self)
    }
}
