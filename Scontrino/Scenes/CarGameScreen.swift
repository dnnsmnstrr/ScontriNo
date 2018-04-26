//
//  CarGameScreen.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 26/04/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

class CarGameScreen: GameScene {
    let node = MovingNode(imageNamed: "blue triangle")
    var nodePosition: CGPoint?
    
    override init() {
        super.init()
        
        node.name = "triangle"
        node.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(node)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if let position = nodePosition {
            node.position = position
        }
    }
}
