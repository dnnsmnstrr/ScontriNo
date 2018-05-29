//
//  HeadVagonNode.swift
//  Scontrino
//
//  Created by Alessio Perrotti on 24/05/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

class HeadVagonNode : SKSpriteNode {
    convenience init(imageNamed: String) {
        let texture = SKTexture(imageNamed: imageNamed)
        self.init(texture: texture)
        self.setScale(Consts.Graphics.scale)
//        self.setScale(0.1)
//        self.anchorPoint = CGPoint(x: self.frame.size.width, y: self.frame.size.height / 2)
//        self.anchorPoint = CGPoint(x: 0, y: 0.5)
    }
    
    func setup() {
        self.position.y = Consts.Graphics.screenHeight - Consts.Graphics.screenHeight / 1.7
        self.position.x = 0 - (self.size.width / 2)
        self.zPosition = Consts.CarGameScreen.zPositions.vagons
//        self.position.x = 0 - self.size.width / 2
        
    }
    
}
