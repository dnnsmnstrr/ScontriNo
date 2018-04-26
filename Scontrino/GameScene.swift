//
//  GameScene.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 26/04/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    override init() {
        super.init(size: CGSize(width: 375, height: 667))
        backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        
        let backButton = SKShapeNode(rect: CGRect(x: 100, y: 100, width: 100, height: 100))
        backButton.fillColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        backButton.position = CGPoint(x: 100, y: 100)
        self.addChild(backButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
