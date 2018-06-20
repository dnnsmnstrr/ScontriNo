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
    var fittingSpeed: CGFloat = 200
    var category: String = ""
    let mySize = Consts.Graphics.screenHeight / 1100
    
    convenience init(imageNamed: String) {
        let texture = SKTexture(imageNamed: imageNamed)
        self.init(texture: texture)
        self.position = Consts.NodePositions.movingCategFinalPos
        
        var texSize = texture.size()
//        let mySize = self.size
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
        let presentationAnimation = SKAction.sequence([
//            moveTo(position: Consts.NodePositions.movingCategFinalPos),
//            isVisible,
            SKAction.scale(to: CGSize.zero, duration: 0),
            isVisible,
            SKAction.scale(to: mySize, duration: 0.3)
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
//            SKAction.removeFromParent(),
            ])
        return fitTheCategory
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let scene = self.scene as? FloatingLogsGameScreen {
//            scene.movingContextNodeInitialPosition = scene.movingContextNodePosition[self.name!]!
//        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if let scene = self.scene as? FloatingLogsGameScreen {
                let location = touch.location(in: scene)
                scene.movingNode.position = location
            }
        }
    }


    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        if let scene = self.scene as? FloatingLogsGameScreen {
            if isInTheRightCategory == false {
                scene.movingNode.position = Consts.NodePositions.movingCategFinalPos

            }
            else {
                scene.checkRightCategory()
            }
        }
    
    }
}
