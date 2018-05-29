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
        self.setScale(Consts.Graphics.scale)
//        self.setScale(0.1)
        
//        self.position = CGPoint(x: Consts.Graphics.screenWidth - self.size.width, y: Consts.Graphics.screenHeight - self.size.height)
//        let presentationAnimation = SKAction.sequence([
//            SKAction.wait(forDuration: 0.5)
//            SKAction.scale(to: CGSize.zero, duration: 0),
//            isVisible,
//            SKAction.scale(to: self.size, duration: 0.5)
//            ])
//        self.run(presentationAnimation)
    }
    func setup(posX: CGFloat) {
        self.position.y = Consts.Graphics.screenHeight - Consts.Graphics.screenHeight / 2
        self.position.x = posX - self.size.width / 2
        self.zPosition = Consts.CarGameScreen.zPositions.vagons
    }
    
}

