//
//  CabinNode.swift
//  Scontrino
//
//  Created by Dennis Muensterer on 25.05.18.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

class CabinNode: SKSpriteNode {
    convenience init(imageNamed: String) {
        let texture = SKTexture(imageNamed: imageNamed)
        self.init(texture: texture)
        
        var texSize = texture.size()
//        texSize.width = (texSize.width) * 0.8
//        texSize.height = (texSize.height) * 0.8
        self.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: imageNamed), size: texSize)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = true
        
        //MARK: doors
        let offset = self.frame.width/53
        
        let leftDoor = SKSpriteNode.init(imageNamed: "left door")
        //open state
//        leftDoor.position = CGPoint(x: self.frame.midX - self.frame.width/20, y: self.frame.midY - self.frame.width/100)
        //closed state
        leftDoor.position = CGPoint(x: self.frame.midX - offset, y: self.frame.midY - self.frame.height/120)

        
        leftDoor.size = CGSize(width: self.size.width/25, height: self.size.height/11)
        leftDoor.zPosition = 4
        
        
        let rightDoor = SKSpriteNode.init(imageNamed: "right door")
        
        //open state
//        rightDoor.position = CGPoint(x: self.frame.midX + self.frame.width/20, y: self.frame.midY - self.frame.width/100)
        //closed state
        rightDoor.position = CGPoint(x: self.frame.midX + offset, y: self.frame.midY - self.frame.height/120)
        
        rightDoor.size = CGSize(width: self.size.width/25, height: self.size.height/11)
        rightDoor.zPosition = 5
        
        self.addChild(leftDoor)
        self.addChild(rightDoor)
        
        
    }
}
