//
//  CabinNode.swift
//  Scontrino
//
//  Created by Dennis Muensterer on 25.05.18.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

class CabinNode: SKSpriteNode {
    
    var offsetClosed: CGFloat? = nil
    var offsetOpened: CGFloat? = nil
    var doorsOpen: Bool = false
    
    var leftDoor: SKSpriteNode?
    var rightDoor: SKSpriteNode?
    
    
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
        offsetClosed = self.frame.width/53
        offsetOpened = self.frame.width/40

        leftDoor = SKSpriteNode.init(imageNamed: "left door")
        //open state
//        leftDoor.position = CGPoint(x: self.frame.midX - offsetOpened, y: self.frame.midY - self.frame.width/100)
        //closed state
        leftDoor?.position = CGPoint(x: self.frame.midX - offsetClosed!, y: self.frame.midY - self.frame.height/120)

        
        leftDoor?.size = CGSize(width: self.size.width/25, height: self.size.height/11)
        leftDoor?.zPosition = 4
        
        
        rightDoor = SKSpriteNode.init(imageNamed: "right door")
        
        //open state
//        rightDoor.position = CGPoint(x: self.frame.midX + offsetOpened, y: self.frame.midY - self.frame.width/100)
        //closed state
        rightDoor?.position = CGPoint(x: self.frame.midX + offsetClosed!, y: self.frame.midY - self.frame.height/120)
        
        rightDoor?.size = CGSize(width: self.size.width/25, height: self.size.height/11)
        rightDoor?.zPosition = 5
        
        self.addChild(leftDoor!)
        self.addChild(rightDoor!)
        
        
    }
    
    func openDoors(duration: TimeInterval = 1) {
        let openingLeft = SKAction.moveBy(x: -offsetOpened!, y: 0, duration: duration)
        let openingRight = SKAction.moveBy(x: offsetOpened!, y: 0, duration: duration)
        print("opening doors")
        leftDoor?.run(openingLeft)
        rightDoor?.run(openingRight)
        doorsOpen = true
    }
    func closeDoors(duration: TimeInterval = 1) {
        let openingLeft = SKAction.moveBy(x: offsetOpened!, y: 0, duration: duration)
        let openingRight = SKAction.moveBy(x: -offsetOpened!, y: 0, duration: duration)
        print("closing doors")
        leftDoor?.run(openingLeft)
        rightDoor?.run(openingRight)
        doorsOpen = false
    }
    
}
