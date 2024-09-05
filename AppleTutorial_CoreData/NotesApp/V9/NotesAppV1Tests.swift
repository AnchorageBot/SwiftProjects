//
// NotesAppV1
// NotesAppV1Tests.swift
//
// Created on 9/3/24
// Swift Version 5.0
//
// ATS Project
// Tutor: Anthropic's AI Claude
//

// Abstract:
// This file contains unit tests for the NotesAppV1 application. It covers various aspects of the app's functionality,
// including persistence operations, model validations, and view model behaviors. The tests ensure the correct
// creation, deletion, and validation of notes, as well as the proper functioning of the AddNoteViewModel.

import XCTest
import CoreData
@testable import NotesAppV1

/// Test case class for NotesAppV1
class NotesAppV1Tests: XCTestCase {

    // MARK: - Properties

    /// The persistence controller used for testing
    var persistenceController: PersistenceController!
    
    /// The managed object context used for testing
    var managedContext: NSManagedObjectContext!

    // MARK: - Setup and Teardown

    /// Set up the test environment before each test
    override func setUpWithError() throws {
        try super.setUpWithError()
        // Initialize a persistence controller with an in-memory store
        persistenceController = PersistenceController(inMemory: true)
        managedContext = persistenceController.container.viewContext
    }

    /// Clean up the test environment after each test
    override func tearDownWithError() throws {
        persistenceController = nil
        managedContext = nil
        try super.tearDownWithError()
    }

    // MARK: - Persistence Tests

    /// Test the creation of a new note
    func testCreateNote() throws {
        // Create a new note
        let newNote = Note(context: managedContext)
        newNote.id = UUID()
        newNote.title = "Test Note"
        newNote.content = "This is a test note"
        newNote.createdAt = Date()

        // Attempt to save the context
        XCTAssertNoThrow(try managedContext.save(), "Saving the context should not throw an error")

        // Fetch the saved note
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        let results = try managedContext.fetch(fetchRequest)

        // Verify the note was saved correctly
        XCTAssertEqual(results.count, 1, "There should be one note in the context")
        XCTAssertEqual(results.first?.title, "Test Note", "The note title should match")
    }

    /// Test the deletion of a note
    func testDeleteNote() throws {
        // First, create a note
        let newNote = Note(context: managedContext)
        newNote.id = UUID()
        newNote.title = "Test Note"
        newNote.content = "This is a test note"
        newNote.createdAt = Date()

        try managedContext.save()

        // Now delete the note
        managedContext.delete(newNote)
        try managedContext.save()

        // Verify the note was deleted
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        let results = try managedContext.fetch(fetchRequest)

        XCTAssertEqual(results.count, 0, "There should be no notes in the context after deletion")
    }

    // MARK: - Model Tests

    /// Test the properties of the Note model
    func testNoteProperties() {
        let note = Note(context: managedContext)
        let testUUID = UUID()
        let testDate = Date()

        // Set note properties
        note.id = testUUID
        note.title = "Test Title"
        note.content = "Test Content"
        note.createdAt = testDate

        // Verify note properties
        XCTAssertEqual(note.id, testUUID, "Note ID should match the assigned UUID")
        XCTAssertEqual(note.title, "Test Title", "Note title should match the assigned title")
        XCTAssertEqual(note.content, "Test Content", "Note content should match the assigned content")
        XCTAssertEqual(note.createdAt, testDate, "Note creation date should match the assigned date")
    }

    // MARK: - ViewModel Tests

    /// Test the AddNoteViewModel's functionality
    func testAddNoteViewModel() {
        let viewModel = AddNoteViewModel(context: managedContext)
        
        // Set note properties in the view model
        viewModel.title = "Test Note"
        viewModel.content = "This is a test note"
        
        // Attempt to save the note
        XCTAssertNoThrow(try viewModel.saveNote(), "Saving a note should not throw an error")
        
        // Verify the note was saved
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        let results = try? managedContext.fetch(fetchRequest)
        
        XCTAssertEqual(results?.count, 1, "There should be one note in the context")
        XCTAssertEqual(results?.first?.title, "Test Note", "The note title should match")
    }

    // MARK: - Validation Tests

    /// Test the validation of note titles
    func testNoteTitleValidation() {
        let viewModel = AddNoteViewModel(context: managedContext)
        
        // Test with empty title
        viewModel.title = ""
        viewModel.content = "This is a test note"
        
        XCTAssertFalse(viewModel.isValidNote, "A note with an empty title should not be valid")
        
        // Test with non-empty title
        viewModel.title = "Test Note"
        
        XCTAssertTrue(viewModel.isValidNote, "A note with a non-empty title should be valid")
    }

    /// Test the validation of note content length
    func testNoteContentLength() {
        let viewModel = AddNoteViewModel(context: managedContext)
        
        viewModel.title = "Test Note"
        // Test with content exceeding maximum length
        viewModel.content = String(repeating: "a", count: 10001)  // Assuming max length is 10000
        
        XCTAssertFalse(viewModel.isValidNote, "A note with content exceeding the maximum length should not be valid")
        
        // Test with content within maximum length
        viewModel.content = String(repeating: "a", count: 9999)
        
        XCTAssertTrue(viewModel.isValidNote, "A note with content within the maximum length should be valid")
    }
}

