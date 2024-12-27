//
// SockDrawer
// ContentView.swift
//
// Created on 12/26/24
// Swift Version 6.0
//
// ATS Project
// Tutor: Google Gemini 2.0
//


import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            SockDataInputView()
                .tabItem {
                    Label("Sock Data", systemImage: "list.dash")
                }
            SolutionView()
                .tabItem {
                    Label("Solution", systemImage: "checkmark.circle")
                }
            DiophantineExplanationView()
                .tabItem {
                    Label("Diophantine", systemImage: "function")
                }
            AboutView()
                .tabItem {
                    Label("About", systemImage: "info.circle")
                }
        }
    }
}
