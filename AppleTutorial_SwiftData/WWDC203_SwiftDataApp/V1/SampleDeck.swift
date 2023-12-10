/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Sample cards to use during development.
*/

struct SampleDeck {
    static var contents: [Card] = [
        Card(front: "Open Settings in a single click", back: "SettingsLink"),
        Card(front: "Configure the toolbar title display size", back: "toolbarTitleDisplayMode(_:)"),
        Card(front: "Access both the old and new values that changed", back: "onChange(of:initial:_:)"),
        Card(front: "Standard UI to replace unavailable View content", back: "ContentUnavailableView"),
        Card(front: "View displaying details of selected content", back: "inspector(isPresented:content:)"),
        Card(front: "Run an animation with a completion handler", back: "withAnimation(_:completionCriteria:_:completion:)"),
        Card(front: "Create high-performance graphics by drawing with Metal shaders", back: "Shader"),
        Card(front: "Set the background of a container view", back: "containerBackground(_:for:)"),
        Card(front: "Customize table column visibility and reordering", back: "TableColumnCustomization"),
        Card(front: "Disable selectability of an item in a List or Table", back: "selectionDisabled(_:)"),
        Card(front: "Create paged scroll views", back: "scrollTargetBehavior(_:)")
    ]
}

