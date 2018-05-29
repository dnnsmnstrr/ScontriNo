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
    
    let screenScale: CGFloat = UIScreen.main.scale

    var offsetClosed: CGFloat? = nil
    var offsetOpened: CGFloat? = nil
    var sizeWidth: CGFloat = 25+2
    var sizeHeight: CGFloat = 11+2
    
    
    
    var doorsOpen: Bool = false
    
    
    convenience init(imageNamed: String) {
        let texture = SKTexture(imageNamed: imageNamed)
        self.init(texture: texture)
        
        var texSize = texture.size()
        self.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: imageNamed), size: texSize)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = true
        
        //MARK: cabin occupant
        occupant = SKSpriteNode.init(imageNamed: "moon")
        occupant?.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        occupant?.zPosition = 4
        
        
        //MARK: doors
        //stupidly hardcoded
        offsetClosed = self.frame.width/(22*screenScale*(screenScale/2))
        offsetOpened = self.frame.width/(10*screenScale*(screenScale/2))
        
        leftDoor = SKSpriteNode.init(imageNamed: "left door")
        rightDoor = SKSpriteNode.init(imageNamed: "right door")
        
        //rough default positioning
        leftDoor?.position = CGPoint(x: self.frame.midX - offsetClosed!, y: self.frame.midY - self.frame.height/150)
        leftDoor?.size = CGSize(width: self.size.width/sizeWidth, height: self.size.height/sizeHeight)
        leftDoor?.zPosition = 5
        
        rightDoor?.position = CGPoint(x: self.frame.midX + offsetClosed!, y: self.frame.midY - self.frame.height/150)
        rightDoor?.size = CGSize(width: self.size.width/sizeWidth, height: self.size.height/sizeHeight)
        rightDoor?.zPosition = 6
        
        self.addChild(leftDoor!)
        self.addChild(rightDoor!)
        self.addChild(occupant!)
        
        
    }
    
    func openDoors(duration: TimeInterval = 1, wait: Bool = false, waitDuration: TimeInterval = 2) {
        let openingLeft = SKAction.moveBy(x: -offsetOpened!, y: 0, duration: duration)
        let openingRight = SKAction.moveBy(x: offsetOpened!, y: 0, duration: duration)
        let waiting = SKAction.wait(forDuration: waitDuration)
        print("opening doors")
        if !doorsOpen {
            if wait{
                let leftSequence = SKAction.sequence([waiting, openingLeft])
                let rightSequence = SKAction.sequence([waiting, openingRight])
                leftDoor?.run(leftSequence)
                rightDoor?.run(rightSequence)
            }
            else{
                leftDoor?.run(openingLeft)
                rightDoor?.run(openingRight)
            }
            
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
