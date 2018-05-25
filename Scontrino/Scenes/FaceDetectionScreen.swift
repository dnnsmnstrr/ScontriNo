//
//  FaceDetectionScreen.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 26/04/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//
//

import UIKit
import SpriteKit
import AVFoundation
import Vision

class FaceDetectionScreen: GameScene {
    
    let cameraNode = SKCameraNode()
    
    var ferrisWheel: SKSpriteNode!
    private var cabins: [SKSpriteNode] = []
    var startTime: TimeInterval?
    var start: CGPoint?
    var end: CGPoint?
    var wheelSpeed: CGFloat = 1000
    var zoomedIn: Bool = false
    var zoomPoint: CGFloat?
    
    
    
    override func createSceneContents() {
        super.createSceneContents()
        
        cameraNode.position = CGPoint(x: self.size.width / 2,y: self.size.height / 2)
        self.addChild(cameraNode)
        self.camera = cameraNode
        
        
        
        
        //create ferris wheel
        
        ferrisWheel = SKSpriteNode.init(texture: SKTexture(imageNamed: "Wheel"))
        ferrisWheel.name = "wheel"
//        ferrisWheel.texture
        ferrisWheel.zPosition = 2
        ferrisWheel.anchorPoint = CGPoint(x: 0.5, y: 0.5) // default
        ferrisWheel.position = CGPoint(x: size.width/2, y: size.height/2)
        ferrisWheel.size = CGSize(width: size.width, height: size.width)
        zoomPoint = ferrisWheel.frame.minY - size.height/20
        ferrisWheel.physicsBody = SKPhysicsBody(circleOfRadius: max((ferrisWheel.size.width) / 2,
                                                                    (ferrisWheel.size.height) / 2))
        ferrisWheel.zRotation = CGFloat.pi / 2
        ferrisWheel.physicsBody?.pinned = true
        ferrisWheel.physicsBody?.angularDamping = 0.1
        
        
        
        self.addChild(ferrisWheel)
        
        
        let radius = ferrisWheel.size.width/2 - 2
        for i in 1...6 {
            
            let newCabin = CabinNode.init(imageNamed: "cabin body")
//            let newCabin = SKSpriteNode.init(texture: SKTexture(imageNamed: "Cabin"))
            
            newCabin.zPosition = 3
            newCabin.size = CGSize(width: ferrisWheel.size.width/5, height: ferrisWheel.size.height/5)

            let currentX = radius*CGFloat(cosf(2*Float.pi*Float(i)/6))+ferrisWheel.frame.midX
            let currentY = radius*CGFloat(sinf(2*Float.pi*Float(i)/6))+ferrisWheel.frame.midY

            newCabin.position = CGPoint(x: currentX, y: currentY-newCabin.size.height/2)
            newCabin.physicsBody = SKPhysicsBody(circleOfRadius: newCabin.size.height/2)
            newCabin.physicsBody?.angularDamping = 30
            newCabin.physicsBody?.mass = 2
            self.addChild(newCabin)
            cabins.append(newCabin)
            
            let joint = SKPhysicsJointPin.joint(withBodyA: ferrisWheel.physicsBody! , bodyB: newCabin.physicsBody!, anchor: CGPoint(x: currentX, y: currentY))
            //limit joint angles
            //            joint.shouldEnableLimits = true
            //            joint.lowerAngleLimit = -0.3
            //            joint.upperAngleLimit = 0.3
            self.physicsWorld.add(joint)
            
        }
        
        
        //MARK: touches
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        self.start = touch.location(in: self)
        self.startTime = touch.timestamp
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        self.end = touch.location(in: self)
        var dx = ((self.end?.x)! - (self.start?.x)!)
        var dy = ((self.end?.y)! - (self.start?.y)!)
        
        let magnitude:CGFloat = sqrt(dx*dx+dy*dy)
        print(magnitude)
        if magnitude >= 25 {
            let dt:CGFloat = CGFloat(touch.timestamp - self.startTime!)
            if dt > 0.1 {
                wheelSpeed = magnitude / dt
                dx = dx / magnitude
                dy = dy / magnitude
                print("dx: \(dx), dy: \(dy), speed: \(wheelSpeed) ")
                
            }
            let touchPosition = touch.location(in: self)
            if touchPosition.x < (self.frame.width / 2) {
                self.ferrisWheel.physicsBody?.applyAngularImpulse(-(wheelSpeed/100))
            } else {
                self.ferrisWheel.physicsBody?.applyAngularImpulse(wheelSpeed/100)
            }
        }
        if magnitude < 25 {
            if !zoomedIn{
                zoomIn()
            }
            else {
                zoomOut()
            }
            
            let touchPosition = touch.location(in: self)
            if touchPosition.x < (self.frame.width / 2) {
                self.ferrisWheel.physicsBody?.angularVelocity = 0
            } else {
                self.ferrisWheel.physicsBody?.angularVelocity = 0
            }
        }
        
    }
    
    //MARK: custom functions
    
    func zoomIn(scalingFactor: CGFloat = 0.2) {
        let zoomInAction = SKAction.scale(to: scalingFactor, duration: 1)
        let positioning = SKAction.moveTo(y: zoomPoint!, duration: 1)
        let group = SKAction.group([zoomInAction, positioning])
        cameraNode.run(group)
        zoomedIn = true
    }
    
    func zoomOut(scalingFactor: CGFloat = 1) {
        let zoomInAction = SKAction.scale(to: scalingFactor, duration: 1)
        let positioning = SKAction.moveTo(y: self.size.height / 2, duration: 1)
        let group = SKAction.group([zoomInAction, positioning])
        cameraNode.run(group)
        zoomedIn = false
    }
    
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
