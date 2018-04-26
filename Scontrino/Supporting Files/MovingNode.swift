//
//  MovingNode.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 26/04/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

class MovingNode: SKSpriteNode {
    
    convenience init(imageNamed: String) {
        let texture = SKTexture(imageNamed: imageNamed)
        self.init(texture: texture)
        self.isUserInteractionEnabled = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if let parent = self.parent as? CarGameScreen {
                let location = touch.location(in: parent)
                parent.nodePosition = location
            }
        }
    }
}
