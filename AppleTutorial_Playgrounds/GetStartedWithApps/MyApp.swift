import SwiftUI
import Guide

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            IntroView()
            FriendDetailView()
            BluDetailView()
            HopperDetailView()
        }
    }
}
