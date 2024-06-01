//
//  TutorialView.swift
//  PlaneDetection.swift
//
//  Created by Nikhil Kurian Jacob on 01/07/2021
    //  RealityKit tutorial: Plane Detection and Raycasting - Nikhil Jacob - YouTube
    //  File was named ViewController.swift
    //  File was part of a storyboard
//
//  Transcribed by ATS from the YouTube tutorial on 5/31/24
//  Made with Xcode 15.4
//

import UIKit
import RealityKit
import ARKit

class ViewController: UIViewController {
    @IBOutlet var arView: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    // 1. Start plane detection
    startPlaneDetection()
    
    // 2. 2D point
    arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:))))
    }
    
    @objc
    func handleTap(recognizer: UITapGestureRecognizer) {
        
        // Touch location
        let tapLocation = recognizer.location(in: arView)
        
        // Raycast (2D -> 3D)
        let results = arView.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .horizontal)
        
        if let firstResult = results.first {
            
            // 3D point
            let worldPos = simd_make_float3(firstResult.worldTransform.columns.3)
            
            // Create sphere
            let sphere = createSphere()
            
            // Place the sphere
            placeObject(object: sphere, at: worldPos)
        }
    }
    
    func startPlaneDetection() {
        
        arView.automaticallyConfigureSession = true
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        configuration.environmentTexturing = .automatic
        
        arView.session.run(configuration)
    }
    
    func createSphere() -> ModelEntity {
        
        // Mesh
        let sphere = MeshResource.generateSphere(radius: 0.05)
        
        // Assign material
        let sphereMaterial = SimpleMaterial(color: .blue, roughness: 0, isMetallic: true)
        
        // Model entity
        let sphereEntity = ModelEntity(mesh: sphere, materials: [sphereMaterial] )
        
        return sphereEntity
        
    }
    
    func placeObject(object: ModelEntity, at location:SIMD3<Float>) {
        
        // 1. Anchor
        let objectAnchor = AnchorEntity(world: location)
        
        // 2. Tie model to anchor
        objectAnchor.addChild(object)
        
        // 3. Add anchor to scene
        arView.scene.addAnchor(objectAnchor)
    }
}

