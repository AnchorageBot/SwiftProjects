[RealityKit tutorial: Build an AR App In UNDER 3 MINUTES! - Nikhil Jacob - YouTube](https://youtu.be/jjCsI56XavI?si=nvzsyq73epWZ3GdM)

- - - -

Xcode 15.4

* File -> New -> Project - iOS -> Augmented Reality App
  * Product Name: Sphere.swift
  * Interface: SwiftUI
  * Language: Swift
  * Content Technology: Reality Kit 

* Product -> Destination -> iOS Device
- - - -

Autogenerated Xcode Files
* AppDelegate.swift
* ContentView.swift - Grey Cube

        let mesh = MeshResource.generateBox(size: 0.1, cornerRadius: 0.005)
        let material = SimpleMaterial(color: .gray, roughness: 0.15, isMetallic: true)
  
- - - -

iOS Device
* Settings -> Privacy & Security -> Developer Mode

Mac
* Cable (& dongle) to connect iOS Device

- - - -

Xcode
* Product -> Run
