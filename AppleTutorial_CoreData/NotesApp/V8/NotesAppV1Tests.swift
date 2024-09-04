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

import XCTest
import CoreData
@testable import NotesAppV1

class NotesAppV1Tests: XCTestCase {

    var persistenceController: PersistenceController!
    var managedContext: NSManagedObjectContext!

    override func setUpWithError() throws {
        try super.setUpWithError()
        persistenceController = PersistenceController(inMemory: true)
        managedContext = persistenceController.container.viewContext
    }

    override func tearDownWithError() throws {
        persistenceController = nil
        managedContext = nil
        try super.tearDownWithError()
    }

    // MARK: - Persistence Tests

    func testCreateNote() throws {
        let newNote = Note(context: managedContext)
        newNote.id = UUID()
        newNote.title = "Test Note"
        newNote.content = "This is a test note"
        newNote.createdAt = Date()

        XCTAssertNoThrow(try managedContext.save(), "Saving the context should not throw an error")

        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        let results = try managedContext.fetch(fetchRequest)

        XCTAssertEqual(results.count, 1, "There should be one note in the context")
        XCTAssertEqual(results.first?.title, "Test Note", "The note title should match")
    }

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

        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        let results = try managedContext.fetch(fetchRequest)

        XCTAssertEqual(results.count, 0, "There should be no notes in the context after deletion")
    }

    // MARK: - Model Tests

    func testNoteProperties() {
        let note = Note(context: managedContext)
        let testUUID = UUID()
        let testDate = Date()

        note.id = testUUID
        note.title = "Test Title"
        note.content = "Test Content"
        note.createdAt = testDate

        XCTAssertEqual(note.id, testUUID, "Note ID should match the assigned UUID")
        XCTAssertEqual(note.title, "Test Title", "Note title should match the assigned title")
        XCTAssertEqual(note.content, "Test Content", "Note content should match the assigned content")
        XCTAssertEqual(note.createdAt, testDate, "Note creation date should match the assigned date")
    }

    // MARK: - ViewModel Tests

    func testAddNoteViewModel() {
        let viewModel = AddNoteViewModel(context: managedContext)
        
        viewModel.title = "Test Note"
        viewModel.content = "This is a test note"
        
        XCTAssertNoThrow(try viewModel.saveNote(), "Saving a note should not throw an error")
        
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        let results = try? managedContext.fetch(fetchRequest)
        
        XCTAssertEqual(results?.count, 1, "There should be one note in the context")
        XCTAssertEqual(results?.first?.title, "Test Note", "The note title should match")
    }

    // MARK: - Validation Tests

    func testNoteTitleValidation() {
        let viewModel = AddNoteViewModel(context: managedContext)
        
        viewModel.title = ""
        viewModel.content = "This is a test note"
        
        XCTAssertFalse(viewModel.isValidNote, "A note with an empty title should not be valid")
        
        viewModel.title = "Test Note"
        
        XCTAssertTrue(viewModel.isValidNote, "A note with a non-empty title should be valid")
    }

    func testNoteContentLength() {
        let viewModel = AddNoteViewModel(context: managedContext)
        
        viewModel.title = "Test Note"
        viewModel.content = String(repeating: "a", count: 10001)  // Assuming max length is 10000
        
        XCTAssertFalse(viewModel.isValidNote, "A note with content exceeding the maximum length should not be valid")
        
        viewModel.content = String(repeating: "a", count: 9999)
        
        XCTAssertTrue(viewModel.isValidNote, "A note with content within the maximum length should be valid")
    }
}
