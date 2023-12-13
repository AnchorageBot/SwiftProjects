/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The content of the toolbar.
*/

import SwiftUI

struct EditorToolbar: ToolbarContent {
    let isEnabled: Bool
    @Binding var editing: Bool

    var body: some ToolbarContent {
        ToolbarItem {
            if Design.editFeatureEnabled {
                Button {
                    editing.toggle()
                } label: {
                    Image(systemName: editing ? "play" : "pencil" )
                }
                .disabled(!isEnabled)
            } else {
                EmptyView()
            }
        }
    }
}
