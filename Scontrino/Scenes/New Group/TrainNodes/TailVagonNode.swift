//
//  TailVagonNode.swift
//  Scontrino
//
//  Created by Alessio Perrotti on 24/05/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

class TailVagonNode : SKSpriteNode {
    convenience init(imageNamed: String) {
        let texture = SKTexture(imageNamed: imageNamed)
        self.init(texture: texture)
        self.setScale(Consts.Graphics.scale)
//        self.setScale(0.1)
    }
    func setup(posX: CGFloat) {
        self.position.y = Consts.Graphics.screenHeight - Consts.Graphics.screenHeight / 1.7
        self.position.x = posX - self.size.width / 2
        self.zPosition = Consts.RollerCoasterGameScreen.zPositions.vagons
    }
}
