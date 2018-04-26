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
        
        let backButton = SKSpriteNode(imageNamed: "green star")
        backButton.position = CGPoint(x: 100, y: self.size.height - 50)
        backButton.name = "backButton"
        self.addChild(backButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let nodes = self.nodes(at: location)
            
            if let node = nodes.first {
                if node.name == "backButton" {
                    RootViewController.shared.skView.presentScene(StartScreen())
                }
            }
        }
    }
}
