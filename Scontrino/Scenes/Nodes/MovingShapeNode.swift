//
//  MovingShapeNode.swift
//  Scontrino
//
//  Created by Alessio Perrotti on 17/05/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

class MovingShapeNode: MovingNode {
    var isInTheRightHole = false
    var isFitting = false
    var fittingSpeed: CGFloat = 150
    
    convenience init(imageNamed: String) {
        let texture = SKTexture(imageNamed: imageNamed)
        self.init(texture: texture)
        self.zPosition = Consts.CarGameScreen.zPositions.shapes
        var texSize = texture.size()
        texSize.width = (texSize.width) * 0.65
        texSize.height = (texSize.height) * 0.65
        self.isHidden = true
        self.isUserInteractionEnabled = true
        self.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "red square"), size: texSize)
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
    
    func moveTo(position: CGPoint, onComplete: @escaping (Bool) -> Void) -> SKAction {
        
        isFitting = true
        let path = UIBezierPath()
        path.move(to: self.position)
        path.addLine(to: position)
        
        let completedAction = SKAction.run {
            onComplete(true)
        }
        
        let fillInHoleAnimation = SKAction.sequence([
            SKAction.follow(path.cgPath, asOffset: false, orientToPath: false, speed: fittingSpeed),
            completedAction
//            SKAction.removeFromParent(),
            ])
        return fillInHoleAnimation
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let scene = self.scene as? RollerCoasterGameScreen {
            scene.coloredShapesInitialPositions = scene.coloredShapesPositions[self.name!]!
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if let scene = self.scene as? RollerCoasterGameScreen {
                let location = touch.location(in: scene)
                scene.coloredShapesPositions[self.name!] = location
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let scene = self.scene as? RollerCoasterGameScreen {
            if isInTheRightHole == false {
                scene.coloredShapesPositions[self.name!] = scene.coloredShapesInitialPositions
            }
            else {
                scene.shapeIsGoingToRightHole(nodeName: self.name!)
//                scene.controlIfRightShapeInHole(nodeName: self.name!)
            }
        }
        
    }
}
