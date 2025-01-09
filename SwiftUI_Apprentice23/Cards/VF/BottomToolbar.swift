//
// Cards
// BottomToolbar.swift
//
// Created on 1/1/25
// Swift Version 6.0
//
// ATS Project
// Kodeco Swift UI Apprentice 23 Tutorial
// Tutor: Google's Gemini 2.0 Experimental
//
// Abstract:  This SwiftUI application serves as a foundation for a card-based information display system. It currently implements a scrollable list of card thumbnails with full-screen detail views. Future development will include features such as [mention planned features, e.g., data loading from a remote source, user interaction with card details, etc.]


import SwiftUI

struct ToolbarButton: View {
    
  //let modal: ToolbarSelection

  var body: some View {
    VStack {
      Image(systemName: "heart.circle")
        .font(.largeTitle)
      Text("Stickers")
    }
    .padding(.top)
  }
}


struct BottomToolbar: View {
    
    @Binding var modal: ToolbarSelection?
    
    var body: some View {
      HStack {
        Button {
          modal = .stickerModal
        } label: {
          ToolbarButton()
        }
      }
    }

}

struct BottomToolbar_Previews: PreviewProvider {
  static var previews: some View {
    BottomToolbar(modal: .constant(.stickerModal))
      .padding()
  }
}



//#Preview {
//    BottomToolbar()
//}
