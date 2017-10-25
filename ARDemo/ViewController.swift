//
//  ViewController.swift
//  ARDemo
//
//  Created by 堀 洋輔 on 2017/10/21.
//  Copyright © 2017年 yosuke_hori. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var frameView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        
        sceneView.scene = SCNScene()
        sceneView.debugOptions =
            [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        
        frameView.layer.borderColor = UIColor.black.cgColor
        frameView.layer.borderWidth = 2.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    @IBAction func onTapAddButton(_ sender: Any) {
        let macbook = createObject(position: SCNVector3(100, 0, 0), restitution: 1.0, filepath: "art.scnassets/macbook/macbook.dae")
        sceneView.scene.rootNode.addChildNode(macbook)
    }

    @IBAction func onTapCaptureButton(_ sender: Any) {
        
    }
    
    func createObject(position:SCNVector3, restitution:CGFloat, filepath:String) -> SCNNode {
        let scene = SCNScene(named: filepath)
        let node: SCNNode = scene!.rootNode.childNodes[0]
        let aModelShape = SCNPhysicsShape(node: node, options: nil)
        let physicsBody = SCNPhysicsBody(type: .dynamic, shape: aModelShape)
        physicsBody.restitution = restitution
        node.physicsBody = physicsBody
        node.position = position

        return node
    }
}

extension ViewController: ARSCNViewDelegate {
    /*
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()
     
     return node
     }
     */
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
