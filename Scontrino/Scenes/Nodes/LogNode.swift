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
    var fittingSpeed: CGFloat = 200
    var initialPosition: CGPoint = CGPoint.zero
    
    convenience init(imageNamed: String, flag: SKSpriteNode) {
        let texture = SKTexture(imageNamed: imageNamed)
        self.init(texture: texture)
        
        var texSize = texture.size()
        texSize.width = (texSize.width) * 0.8
        texSize.height = (texSize.height) * 0.8
        self.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: imageNamed), size: texSize)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = Consts.PhysicsMask.holeNode
        self.physicsBody?.contactTestBitMask = Consts.PhysicsMask.shapeNodes
        
       
        
//        self.setScale(newDimension)
        
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
//        flag.setScale(newDimension)
//        flag.name = "flag" + " " + imageNamed
        nodeFlag = flag
        self.addChild(flag)
    }
    
    func setup(pos: CGPoint){
        
         let newDimension = Consts.Graphics.screenHeight / 1024
        print("dimensione: \(newDimension)")
        
        self.position = pos
        self.initialPosition = pos
//        let scaleNumberHeight = Consts.Graphics.screenResolution.height / 2
//        let scaleNumberWidth = Consts.Graphics.screenResolution.width / 5
//        self.size.height = scaleNumberHeight
//        self.size.width = scaleNumberWidth
        
                self.setScale(newDimension)
        
    }
    
    func moveTo(position: CGPoint, startingPoint: CGPoint) -> SKAction {
        
        //        isFitting = true
        let path = UIBezierPath()
        path.move(to: startingPoint)
        path.addLine(to: position)
        
        let fitTheCategory = SKAction.sequence([
            SKAction.follow(path.cgPath, asOffset: false, orientToPath: false, speed: fittingSpeed),
            //            SKAction.removeFromParent(),
            ])
        return fitTheCategory
    }
    
    
}
