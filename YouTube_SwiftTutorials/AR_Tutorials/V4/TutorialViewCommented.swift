//
//  TutorialViewCommented.swift
//
//  Created by Nikhil Kurian Jacob on 01/07/2021
    //  RealityKit tutorial: Plane Detection and Raycasting - Nikhil Jacob - YouTube
    //  File was named ViewController.swift
    //  File was part of a storyboard
//
//  Transcribed by ATS on 5/31/24
//  Made with Xcode 15.4
//
//  Extensively commented by Claude AI on 5/31/2024
//

/*
 
 Overall, this code demonstrates the basic functionality of plane detection and object placement in an AR app using RealityKit and ARKit.
 
 This code demonstrates a simple AR app using RealityKit and ARKit. Here's a summary of what the code does:

 The startPlaneDetection() function sets up the AR session with plane detection and environment texturing enabled.
 
 When the user taps on the screen, the handleTap(recognizer:) function is called. It performs a raycast from the tap location to detect horizontal planes.
 
 If a plane is detected, the code creates a sphere using the createSphere() function. The sphere has a blue, smooth, and metallic appearance.
 
 The placeObject(object:, at:) function is then called to place the sphere at the detected 3D position. It creates an anchor entity at the specified location, adds the sphere as a child of the anchor, and adds the anchor to the AR scene.
 
 The createSphere() function generates a sphere mesh with a radius of 0.05 and assigns a blue, smooth, and metallic material to it.
 
 The placeObject(object:, at:) function creates an anchor entity at the specified world location, adds the object as a child of the anchor, and adds the anchor to the AR scene.
 
 */



import UIKit
import RealityKit
import ARKit

class ViewController: UIViewController {
    @IBOutlet var arView: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Start plane detection
        // This function sets up the ARWorldTrackingConfiguration and starts the AR session
        startPlaneDetection()
        
        // 2. Add a tap gesture recognizer to the ARView
        // When the user taps on the screen, it triggers the handleTap(recognizer:) function
        arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:))))
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
        // 1. Create an anchor entity at the specified world location
        let objectAnchor = AnchorEntity(world: location)
        
        // 2. Add the object as a child of the anchor entity
        objectAnchor.addChild(object)
        
        // 3. Add the anchor entity to the AR scene
        arView.scene.addAnchor(objectAnchor)
    }
}
