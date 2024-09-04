//
// NotesAppV1
// Note+Extension.swift
//
// Created on 8/31/24
// Swift Version 5.0
//
// ATS Project
// Tutor: Anthropic's AI Claude
//

/**
 Abstract:
 This file defines an extension to the Note entity in the NotesAppV1 application.
 It provides a method for setting sample data on a Note instance, which can be
 useful for testing, previewing, and initializing default values. This extension
 enhances the functionality of the Note entity without modifying its original implementation.
 */

import Foundation
import CoreData

extension Note {
    /**
     Sets sample data for the Note entity.
     
     This method populates the Note instance with predefined sample values.
     It's useful for creating mock data for testing, SwiftUI previews, or
     initializing new notes with default values.
     
     The sample data includes:
     - A new UUID for the id
     - A title of "Sample Note"
     - Content reading "This is a sample note content."
     - The current date and time for createdAt
     */
    func setSampleData() {
        id = UUID()
        title = "Sample Note"
        content = "This is a sample note content."
        createdAt = Date()
    }
}
