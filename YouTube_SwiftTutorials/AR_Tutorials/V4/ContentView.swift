//
// ContentView.swift
// PlaneDetection.swift
//
// Created by ATS and Claude on 5/31/24
// Made with Xcode 15.4

/*
 
 In this updated code:

 The AppDelegate class remains the same as in the provided code. It sets up the SwiftUI view hierarchy and handles the application lifecycle events.
 
 The ContentView struct is the main SwiftUI view that provides the augmented reality functionality. It creates an ARView instance and configures it when the view appears.
 
 The startPlaneDetection() function sets up the AR session with plane detection and environment texturing enabled, similar to the previous code.
 
 The handleTap(recognizer:) function is called when the user taps on the screen. It performs a raycast from the tap location to detect horizontal planes and places a sphere at the detected position.
 
 The createSphere() function generates a sphere mesh with a blue, smooth, and metallic material, just like in the previous code.
 
 The placeObject(object:, at:) function creates an anchor entity at the specified world location, adds the object as a child of the anchor, and adds the anchor to the AR scene.
 
 The ARViewContainer struct is a UIViewRepresentable that allows integrating the ARView into the SwiftUI view hierarchy. It binds the ARView to the ContentView and provides the necessary methods for creating and updating the ARView.

 This updated code should work with the provided SwiftUI interface and RealityKit, allowing you to detect planes and place spheres in the augmented reality scene when the user taps on the screen.
 
 */

import SwiftUI
import RealityKit
import ARKit

struct ContentView: View {
    // Create an ARView to display the augmented reality content
    @State private var arView = ARView(frame: .zero)
    
    var body: some View {
        // Use a ZStack to layer the ARView and other UI elements
        ZStack {
            // Add the ARView to the SwiftUI view hierarchy
            ARViewContainer(arView: $arView)
                .edgesIgnoringSafeArea(.all)
            
            // Add other UI elements on top of the ARView if needed
        }
        .onAppear {
            // Configure the ARView when the view appears
            startPlaneDetection()
            
            // Add a tap gesture recognizer to the ARView
            arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:))))
        }
    }
    
    func startPlaneDetection() {
        // Enable automatic configuration of the AR session
        arView.automaticallyConfigureSession = true
        
        // Create an ARWorldTrackingConfiguration
        let configuration = ARWorldTrackingConfiguration()
        
        // Enable horizontal plane detection
        configuration.planeDetection = [.horizontal]
        
        // Enable automatic environment texturing
        configuration.environmentTexturing = .automatic
        
        // Run the AR session with the configuration
        arView.session.run(configuration)
    }
    
    @objc
    func handleTap(recognizer: UITapGestureRecognizer) {
        // Get the touch location in the ARView
        let tapLocation = recognizer.location(in: arView)
        
        // Perform a raycast from the touch location to detect planes
        // The raycast allows estimating planes and aligns horizontally
        let results = arView.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .horizontal)
        
        // Check if the raycast hit any planes
        if let firstResult = results.first {
            // Get the 3D world position of the raycast hit
            let worldPos = simd_make_float3(firstResult.worldTransform.columns.3)
            
            // Create a sphere object
            let sphere = createSphere()
            
            // Place the sphere at the detected 3D position
            placeObject(object: sphere, at: worldPos)
        }
    }
    
    func createSphere() -> ModelEntity {
        // Generate a sphere mesh with a radius of 0.05
        let sphere = MeshResource.generateSphere(radius: 0.05)
        
        // Create a blue, smooth, and metallic material
        let sphereMaterial = SimpleMaterial(color: .blue, roughness: 0, isMetallic: true)
        
        // Create a model entity with the sphere mesh and material
        let sphereEntity = ModelEntity(mesh: sphere, materials: [sphereMaterial])
        
        return sphereEntity
    }
    
    func placeObject(object: ModelEntity, at location: SIMD3<Float>) {
        // Create an anchor entity at the specified world location
        let objectAnchor = AnchorEntity(world: location)
        
        // Add the object as a child of the anchor entity
        objectAnchor.addChild(object)
        
        // Add the anchor entity to the AR scene
        arView.scene.addAnchor(objectAnchor)
    }
}

// ARViewContainer.swift
struct ARViewContainer: UIViewRepresentable {
    // Bind the ARView to the SwiftUI view
    @Binding var arView: ARView
    
    func makeUIView(context: Context) -> ARView {
        // Return the ARView when the SwiftUI view is created
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // Update the ARView if needed
    }
}
