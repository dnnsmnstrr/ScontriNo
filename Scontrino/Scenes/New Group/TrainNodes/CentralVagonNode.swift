//
//  VagonNode.swift
//  Scontrino
//
//  Created by Alessio Perrotti on 24/05/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

class CentralVagonNode : SKSpriteNode {
    convenience init(imageNamed: String) {
        let texture = SKTexture(imageNamed: imageNamed)
        self.init(texture: texture)
//        self.position = CGPoint(x: Consts.Graphics.screenWidth - self.size.width, y: Consts.Graphics.screenHeight - self.size.height)
//        let presentationAnimation = SKAction.sequence([
//            SKAction.wait(forDuration: 0.5)
//            SKAction.scale(to: CGSize.zero, duration: 0),
//            isVisible,
//            SKAction.scale(to: self.size, duration: 0.5)
//            ])
//        self.run(presentationAnimation)
    }
    
}

