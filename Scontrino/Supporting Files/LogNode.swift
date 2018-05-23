//
//  LogNode.swift
//  Scontrino
//
//  Created by Anna Cassino on 22/05/18.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

class LogNode: SKSpriteNode {
    
    var nodeFlag: SKSpriteNode = SKSpriteNode()
    
    convenience init(imageNamed: String, flag: SKSpriteNode) {
        let texture = SKTexture(imageNamed: imageNamed)
        self.init(texture: texture)
        
//        var texSize = texture.size()
////        texSize.width = (texSize.width) * 0.55
////        texSize.height = (texSize.height) * 0.55
//        self.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "red square"), size: texSize)
//        self.physicsBody?.isDynamic = false
//        self.physicsBody?.affectedByGravity = false
//        self.physicsBody?.categoryBitMask = Consts.PhysicsMask.holeNode
//        self.physicsBody?.contactTestBitMask = Consts.PhysicsMask.shapeNodes
//        let isVisible = SKAction.run{
//            self.isHidden = false
//        }
//        let presentationAnimation = SKAction.sequence([
//            SKAction.scale(to: CGSize.zero, duration: 0),
//            isVisible,
//            SKAction.scale(to: self.size, duration: 0.5)
//            ])
//        self.run(presentationAnimation)
        
        flag.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - flag.frame.maxY - 5)
        flag.name = "flag" + " " + imageNamed
        nodeFlag = flag
        self.addChild(flag)
    }
    
    func setup(pos: CGPoint){
        self.position = pos
        self.setScale(0.5)
    }
    
    
}
