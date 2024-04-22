
//
//  Friend.swift
//  Birthdays
//
//  Created by ATS on 4/20/24
//  Xcode version 15.3
//  Commented and refactored by Claude on 4/21/24
//

/*
 Abstract:
 This code defines the Friend model class, which represents a friend's information
 in the Birthdays app. The class is annotated with @Model to make it a stored model
 managed by SwiftData. It includes properties for the friend's name and birthday,
 as well as a computed property to determine if the friend's birthday is today.

 References:
 - SwiftData Documentation
   https://developer.apple.com/documentation/swiftdata
 - Date Documentation
   https://developer.apple.com/documentation/foundation/date
 - Calendar Documentation
   https://developer.apple.com/documentation/foundation/calendar
*/

import Foundation
import SwiftData

@Model
class Friend {
    // Stored properties for the friend's name and birthday
    let name: String
    let birthday: Date
    
    // Initializer to create a new Friend instance
    init(name: String, birthday: Date) {
        self.name = name
        self.birthday = birthday
    }
    
    // Computed property to determine if the friend's birthday is today
    var isBirthdayToday: Bool {
        Calendar.current.isDateInToday(birthday)
    }
}
