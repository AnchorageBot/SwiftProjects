//
//  Item.swift
//  FavoriteMovies
//
//  Created by ATS on 4/23/24.
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
