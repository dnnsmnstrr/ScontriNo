//
//  MovingContextNode.swift
//  Scontrino
//
//  Created by Anna Cassino on 22/05/18.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

class MovingContextNode: MovingNode {
    var isInTheRightCategory = false
    var isFitting = false
    var fittingSpeed: CGFloat = 150
    
    convenience init(imageNamed: String) {
        let texture = SKTexture(imageNamed: imageNamed)
        self.init(texture: texture)
        
        var texSize = texture.size()
        texSize.width = (texSize.width) * 0.65
        texSize.height = (texSize.height) * 0.65
        self.isHidden = true
        self.isUserInteractionEnabled = true
        self.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: imageNamed), size: texSize)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = Consts.PhysicsMask.shapeNodes
        self.physicsBody?.contactTestBitMask = Consts.PhysicsMask.holeNode
        self.physicsBody?.collisionBitMask = 0
        let isVisible = SKAction.run {
            self.isHidden = false
        }
        let presentationAnimation = SKAction.sequence([SKAction.scale(to: CGSize.zero, duration: 0),
                                                       isVisible,
                                                       SKAction.scale(to: self.size, duration: 0.5)
            ])
        self.run(presentationAnimation)
    }
    
    func moveTo(position: CGPoint) -> SKAction {
        
        isFitting = true
        let path = UIBezierPath()
        path.move(to: self.position)
        path.addLine(to: position)
        
        let fitTheCategory = SKAction.sequence([
            SKAction.follow(path.cgPath, asOffset: false, orientToPath: false, speed: fittingSpeed),
            SKAction.removeFromParent(),
            ])
        return fitTheCategory
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let scene = self.scene as? CategorizationGameScreen {
//            scene.movingContextNodeInitialPosition = scene.movingContextNodePosition[self.name!]!
//        }
    }
    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first {
////            if let scene = self.scene as? CategorizationGameScreen {
////                let location = touch.location(in: scene)
////                scene.coloredShapesPositions[self.name!] = location
//            }
//        }
//    }
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//
////        if let scene = self.scene as? CategorizationGameScreen {
////            if isInTheRightHole == false {
////                scene.coloredShapesPositions[self.name!] = scene.coloredShapesInitialPositions
////            }
//            else {
//                scene.controlIfRightShapeInHole(nodeName: self.name!)
//            }
//        }
    
    }
//}