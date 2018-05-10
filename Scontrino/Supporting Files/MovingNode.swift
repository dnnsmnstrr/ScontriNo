//
//  MovingNode.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 26/04/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

class MovingNode: SKSpriteNode {
    var isInTheRightHole = false
    
    convenience init(imageNamed: String) {
        let texture = SKTexture(imageNamed: imageNamed)
        self.init(texture: texture)
        self.isUserInteractionEnabled = true
        if imageNamed.contains("star"){
            debugPrint("cacca")
            self.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "red polygon"), size: SKTexture(imageNamed: "red polygon").size())
        }
        else{
            self.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        }
        
//        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = Consts.PhysicsMask.shapeNodes
        self.physicsBody?.contactTestBitMask = Consts.PhysicsMask.holeNode
        self.physicsBody?.collisionBitMask = 0
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if let scene = self.scene as? CarGameScreen {
                let location = touch.location(in: scene)
                scene.coloredShapesPositions[self.name!] = location
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first {
            if isInTheRightHole == false{
                if let scene = self.scene as? CarGameScreen {
//                    let location = touch.location(in: scene)
                    scene.coloredShapesPositions[self.name!] = scene.coloredShapesInitialPositions[self.name!]
                }
            }
//        }
    }
}
