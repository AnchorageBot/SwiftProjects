//
// RickAndMorty
// RMEndpoint.swift
//
// Created on 10/13/24
// Swift Version 6.0
//
// ATS Project
//   Tutor: Afraz Siddiqui - iOS Academy YouTube
//

// Paths to get data

import Foundation

// Represents unique API endpoint
//@frozen enum RMEndpoint: String {
    enum RMEndpoint: String {
    // Endpoint to get character info
    case characters
    // Endpoint to get episode info
    case episodes
    // Endpoint to get location info
    case locations
    // Endpoint to get season info
    case seasons
}
