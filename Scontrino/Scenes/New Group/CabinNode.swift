//
//  CabinNode.swift
//  Scontrino
//
//  Created by Dennis Muensterer on 25.05.18.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

class CabinNode: SKSpriteNode {
    let dataSource = GameDataSource()
    
    var leftDoor: SKSpriteNode?
    var rightDoor: SKSpriteNode?
    var occupant: SKSpriteNode?
    
    var offsetClosed: CGFloat? = nil
    var offsetOpened: CGFloat? = nil
    var sizeWidth: CGFloat = 25+2
    var sizeHeight: CGFloat = 11+2
    
    
    var doorsOpen: Bool = false
    
    
    convenience init(imageNamed: String) {
        let texture = SKTexture(imageNamed: imageNamed)
        self.init(texture: texture)
        
        var texSize = texture.size()
//        texSize.width = (texSize.width) * 0.8
//        texSize.height = (texSize.height) * 0.8
        self.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: imageNamed), size: texSize)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = true
        
        //MARK: cabin occupant
        occupant = SKSpriteNode.init(imageNamed: "moon")
        occupant?.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        occupant?.zPosition = 4

        
        //MARK: doors
        //currently hardcoded
        offsetClosed = self.frame.width/53-2.7
        offsetOpened = self.frame.width/40-2.5

        leftDoor = SKSpriteNode.init(imageNamed: "left door")
        rightDoor = SKSpriteNode.init(imageNamed: "right door")

        //rough default positioning
        leftDoor?.position = CGPoint(x: self.frame.midX - offsetClosed!, y: self.frame.midY - self.frame.height/120)
        leftDoor?.size = CGSize(width: self.size.width/sizeWidth, height: self.size.height/sizeHeight)
        leftDoor?.zPosition = 5
        
        rightDoor?.position = CGPoint(x: self.frame.midX + offsetClosed!, y: self.frame.midY - self.frame.height/120)
        rightDoor?.size = CGSize(width: self.size.width/sizeWidth, height: self.size.height/sizeHeight)
        rightDoor?.zPosition = 6
        
        self.addChild(leftDoor!)
        self.addChild(rightDoor!)
        self.addChild(occupant!)
        
        
    }
    
    func openDoors(duration: TimeInterval = 1) {
        let openingLeft = SKAction.moveBy(x: -offsetOpened!, y: 0, duration: duration)
        let openingRight = SKAction.moveBy(x: offsetOpened!, y: 0, duration: duration)
        print("opening doors")
        if !doorsOpen {
            leftDoor?.run(openingLeft)
            rightDoor?.run(openingRight)
        }
        doorsOpen = true
    }
    func closeDoors(duration: TimeInterval = 1) {
        let closingLeft = SKAction.moveBy(x: offsetOpened!, y: 0, duration: duration)
        let closingRight = SKAction.moveBy(x: -offsetOpened!, y: 0, duration: duration)
        print("closing doors")
        if doorsOpen {
            leftDoor?.run(closingLeft)
            rightDoor?.run(closingRight)
        }
        doorsOpen = false
    }
    
    
}
