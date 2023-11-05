/*

 FileManagerExtension.swift
 Explore_SwiftUI_V7

 How to create a Swift file with keyboard and Xcode commands:

 Command Key (Splat) N -> Swift File

 References:

 https://developer.apple.com/tutorials/sample-apps/imagegallery

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/extensions/

 https://developer.apple.com/documentation/foundation/filemanager

 https://developer.apple.com/documentation/foundation/url

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/statements/

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/statements/#Guard-Statement

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/errorhandling/#Handling-Errors-Using-Do-Catch

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics/#nil

 https://developer.apple.com/documentation/foundation/nsstring/1417198-path

 Created on 11/5/2023 with Swift 5.9, Xcode 15.0

 A file manager object lets you examine the contents of the file system and make changes to it. The FileManager class provides convenient access to a shared file manager object that is suitable for most types of file-related manipulations. A file manager object is typically your primary mode of interaction with the file system. You use it to locate, create, copy, and move files and directories. You also use it to get information about a file or directory or change some of its attributes.

*/

import Foundation

extension FileManager {

    // The URL of the document directory.
    var documentDirectory: URL? {
        return self.urls(for: .documentDirectory, in: .userDomainMask).first
    }

    /* 
     Copies the specified file URL to a file with the same name in the document directory.

     - parameter url: The file URL to be copied.

     - returns: The URL of the copied or existing file in the documents directory, or nil if the copy failed.
    */

    func copyItemToDocumentDirectory(from sourceURL: URL) -> URL? {
        guard let documentDirectory = documentDirectory else { return nil }
        let fileName = sourceURL.lastPathComponent
        let destinationURL = documentDirectory.appendingPathComponent(fileName)
        if self.fileExists(atPath: destinationURL.path) {
            return destinationURL
        } else {
            do {
                try self.copyItem(at: sourceURL, to: destinationURL)
                return destinationURL
            } catch let error {
                print("Unable to copy file: \(error.localizedDescription)")
            }
        }
        return nil
    }

    /*
     Removes an item with the specified file URL from the document directory, if present.

     - parameter url: The file URL to be removed.
    */

    func removeItemFromDocumentDirectory(url: URL) {
        guard let documentDirectory = documentDirectory else { return }
        let fileName = url.lastPathComponent
        let fileUrl = documentDirectory.appendingPathComponent(fileName)
        if self.fileExists(atPath: fileUrl.path) {
            do {
                try self.removeItem(at: url)
            } catch let error {
                print("Unable to remove file: \(error.localizedDescription)")
            }
        }
    }

    // Returns the contents of the specified directory as an array of URLs.
    func getContentsOfDirectory(_ url: URL) -> [URL] {
        var isDirectory: ObjCBool = false
        // The URL must be a directory.
        guard FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory), isDirectory.boolValue else { return [] }
        do {
            return try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
        } catch let error {
            print("Unable to get directory contents: \(error.localizedDescription)")
        }
        return []
    }
}

