//
//  ViewController.swift
//  LazerTagAR
//
//  Created by Wylan L Neely on 9/2/22.
//

import UIKit
import RealityKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpARView()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        arView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
        }
    
    //MARK: - Setup
    
    func setUpARView(){
        arView.session.delegate = self

        arView.automaticallyConfigureSession = false
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        
        arView.session.run(config)
    }
    
   @objc func handleTap(recognizer: UITapGestureRecognizer) {
       let anchor = ARAnchor(name: "LazerRed", transform: arView!.cameraTransform.matrix)
       arView.session.add(anchor: anchor)
    }
    
    func placeObject(named entityName: String, for anchor: ARAnchor) {
        let lazerEntity = try! ModelEntity.load(named: entityName)

        let target = AnchoringComponent.Target(anchor: anchor)
        
        
     //   let anchorEntity = AnchorEntity(anchor.identifier)
        
        
    }
    
    
}

extension ViewController: ARSessionDelegate {
    //MARK: - AR Session Delegate
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            if let anchorName = anchor.name, anchorName == "LazerRed" {
                placeObject(named: anchorName, for: anchor)
            }
            
        }
    }
    
}
