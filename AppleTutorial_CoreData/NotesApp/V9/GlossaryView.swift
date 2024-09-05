//
// NotesAppV1
// GlossaryView.swift
//
// Created on 9/3/24
// Updated on 9/3/24
// Swift Version 5.0
//
// ATS Project
// Tutor: Anthropic's AI Claude
//

/**
Abstract:
This file contains the GlossaryView structure, which implements a scrollable
and expandable list of SwiftUI key concepts and terms. It serves as an in-app
reference guide for users of the NotesAppV1 application. The view uses a
combination of List, ForEach, and DisclosureGroup to create an interactive
and informative glossary interface. It now includes a "Done" button for dismissal.
*/

import SwiftUI

/// A structure representing a glossary term
struct GlossaryTerm: Identifiable {
    let id = UUID()
    let term: String
    let definition: String
    let link: String
}

/// GlossaryView: A view that displays a list of SwiftUI key concepts and terms
struct GlossaryView: View {
    // MARK: - Properties
    
    /// Environment variable to dismiss the view
    @Environment(\.presentationMode) var presentationMode
    
    /// Array of GlossaryTerm objects containing the glossary data
    private let glossaryTerms: [GlossaryTerm] = [
        GlossaryTerm(term: "@Environment", definition: "A property wrapper type for accessing values from the view's environment.", link: "https://developer.apple.com/documentation/swiftui/environment"),
        GlossaryTerm(term: "@FetchRequest", definition: "A property wrapper type that retrieves entities from a Core Data store.", link: "https://developer.apple.com/documentation/swiftui/fetchrequest"),
        // Add more terms here...
    ]
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            List {
                ForEach(glossaryTerms) { term in
                    DisclosureGroup(
                        content: {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(term.definition)
                                    .font(.body)
                                
                                Link("Learn More", destination: URL(string: term.link)!)
                                    .font(.caption)
                            }
                            .padding(.vertical, 8)
                        },
                        label: {
                            Text(term.term)
                                .font(.headline)
                        }
                    )
                }
            }
            .navigationTitle("SwiftUI Glossary")
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

// MARK: - Preview

struct GlossaryView_Previews: PreviewProvider {
    static var previews: some View {
        GlossaryView()
    }
}
