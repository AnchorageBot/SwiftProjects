//
//  Reference: Learn Swift by Building Applications - Emil Atanasov
//
//  Made with Swift 5.7, Xcode 14.3.1, 7/27/2023
//
//  AppDelegate.swift
//  Test App
//
//  The delegate pattern is used to delegate some responsibilites to another class
//  Delegates the interaction between the app and the iOS
//
//  The AppDelegate is a place to respond to incoming notifications
//  The state of the app can be preserved and restored in here
//
//  Action item list can include
//  1. Register for remote notifications
//  2. Check launch parameters for the start of the app (deep link, push notification, etc)
//  3. Open a specific URL sent to the app
//  4. Handel notifications remote and local
//  5. Initiate background download
//  6. Remote protected data
//  7. Re-establish access to protected data
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}
