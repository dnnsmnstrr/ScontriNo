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
        self.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "red square"), size: SKTexture(imageNamed: "red square").size())
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = Consts.PhysicsMask.shapeNodes
        self.physicsBody?.contactTestBitMask = Consts.PhysicsMask.holeNode
        self.physicsBody?.collisionBitMask = 0
        let presentationAnimation = SKAction.sequence([SKAction.scale(to: CGSize.zero, duration: 0),
                                                       SKAction.scale(to: self.size, duration: 0.5)
            ])
        self.run(presentationAnimation)
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
        
                if let scene = self.scene as? CarGameScreen {
                    if isInTheRightHole == false {
                        scene.coloredShapesPositions[self.name!] = scene.coloredShapesInitialPositions[self.name!]
                    }
                    else
                    {
                        scene.controlIfRightShapeInHole(nodeName: self.name!)
                    }
                }
            
    }
}
