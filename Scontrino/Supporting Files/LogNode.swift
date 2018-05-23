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
