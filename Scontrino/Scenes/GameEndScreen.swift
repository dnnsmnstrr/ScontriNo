//
//  GameEndScreen.swift
//  Scontrino
//
//  Created by Federica Cioppa on 22/06/18.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import Foundation
import SpriteKit

class GameEndScene: SKScene {
    
    
    var monkey = MonkeyPlayer()
    
//    func buttonNodeTapped(_ sender: ButtonNode) {
//
//    }
//
    var touchLocation: CGPoint!
    
    override init() {
        super.init(size: Consts.Graphics.screenResolution)
        createSceneContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func createSceneContent() {
        let backgroundNode = SKSpriteNode(imageNamed: Consts.endBackground)
        backgroundNode.setScale(Consts.Graphics.scale)
        backgroundNode.position = CGPoint(x: Consts.Graphics.screenWidth / 2, y: Consts.Graphics.screenHeight / 2)
        self.addChild(backgroundNode)
        
        monkey = MonkeyPlayer()
        self.addChild(monkey)
        
        
//        let backButton = ButtonNode(imageNamed: "back button normal", for: .normal)
//        backButton.delegate = self
//        backButton.setTexture(imageNamed: "back button highlighted", for: .highlighted)
//        backButton.name = "StartScreen"
//        backButton.setScale(Consts.Graphics.scale)
//        backButton.position = CGPoint(x: 0.1 * Consts.Graphics.screenWidth, y: 0.9 * Consts.Graphics.screenHeight)
//        self.addChild(backButton)
    
    }
    
}
