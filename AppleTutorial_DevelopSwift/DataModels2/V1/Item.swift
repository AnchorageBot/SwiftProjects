//
//  Item.swift
//  FavoriteMovies
//
//  Created by ATS on 4/23/24.
//  Made with Xcode 15.3
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
