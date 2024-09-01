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

import Foundation
import CoreData

extension Note {
    func setSampleData() {
        id = UUID()
        title = "Sample Note"
        content = "This is a sample note content."
        createdAt = Date()
    }
}

extension Note: Identifiable {}
