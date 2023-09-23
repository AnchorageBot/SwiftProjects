/*

 Source:
 https://developer.apple.com/tutorials/swiftui-concepts/driving-changes-in-your-ui-with-state-and-bindings

 */


/// This file contains helper source code for the recipe data store.

import SwiftUI

/// Load file from the file system.
///
/// `load` expects a JSON file. Use the method to load the recipe data; for
/// example: `DataStore(recipes: load("recipeData.json"))`.
///

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

/// The in-memory image store that this sample uses.
///
/// A user of the app can add images. Instead of saving those images to the
/// file, the sample uses an in-memory image store. This approach is okay
/// for sample where data changes that a person makes are discarded when
/// the app quits. However, you shouldn't use this approach in a real-world
/// app.
final class ImageStore {
    typealias _ImageDictionary = [String: Image]
    fileprivate var images: _ImageDictionary = [:]

    fileprivate static var scale = 2
    
    static var shared = ImageStore()
    
    func image(name: String) -> Image {
        let index = _guaranteeImage(name: name)
        return images.values[index]
    }
    
    func add(_ image: Image, with name: String) {
        images[name] = image
    }

    static func loadImage(name: String) -> Image {
        guard
            let url = Bundle.main.url(forResource: name, withExtension: "jpg"),
            let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
            let cgImage = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)
        else {
            return Image("placeholder")
        }
        return Image(cgImage, scale: CGFloat(ImageStore.scale), label: Text(""))
    }
    
    fileprivate func _guaranteeImage(name: String) -> _ImageDictionary.Index {
        if let index = images.index(forKey: name) { return index }
        
        images[name] = ImageStore.loadImage(name: name)
        return images.index(forKey: name)!
    }
}
