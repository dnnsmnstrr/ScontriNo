//
//  HoleNode.swift
//  Scontrino
//
//  Created by Alessio Perrotti on 15/05/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

enum HoleState {
    case normal, noBorder
}

class HoleNode: SKSpriteNode {
    
    var normalImageName: String!
    var noBorderImageName: String!
    var state = HoleState.normal {
        willSet {
            switch newValue {
            case .normal:
                let texture = SKTexture(imageNamed: normalImageName)
                self.texture = texture
            case .noBorder:
                let texture = SKTexture(imageNamed: noBorderImageName)
                self.texture = texture
            
        
            }
    
        }
    }
    convenience init(imageNamed: String) {
        let texture = SKTexture(imageNamed: imageNamed)
        self.init(texture: texture)
        self.isHidden = true
        self.setScale(Consts.Graphics.scale)
        let mySize = self.size
        var texSize = texture.size()
        texSize.width = (texSize.width) * 0.55
        texSize.height = (texSize.height) * 0.55
        self.normalImageName = imageNamed
        let shapeName = texture.description.split(separator: "\'")[1].split(separator: " ").first!
        self.noBorderImageName = shapeName.description
        
        self.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "square normal"), size: texSize)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = Consts.PhysicsMask.holeNode
        self.physicsBody?.contactTestBitMask = Consts.PhysicsMask.shapeNodes
        let isVisible = SKAction.run{
            self.isHidden = false
        }
        let presentationAnimation = SKAction.sequence([
            SKAction.scale(to: 0, duration: 0),
            isVisible,
            SKAction.scale(to: 1, duration: 0.5)
            ])
        self.run(presentationAnimation)
    }
    func setup(pos: CGPoint) {
        self.position = pos
        self.zPosition = Consts.RollerCoasterGameScreen.zPositions.hole
        state = .normal
    }
}
