//
//  GameScene.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 26/04/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, ButtonNodeDelegate {
    
    override init() {
        super.init(size: CGSize(width: Consts.Graphics.screenWidth, height: Consts.Graphics.screenHeight))
        createSceneContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createSceneContents() {
        let backButton = ButtonNode(imageNamed: "back button")
        backButton.delegate = self
        backButton.position = CGPoint(x: 80, y: self.size.height - 80)
        backButton.name = "backButton"
        backButton.zPosition = 100
        self.addChild(backButton)
    }
    
    func tapButtonNode(_ sender: ButtonNode) {
        //RootViewController.shared.view.viewWithTag(0451)?.removeFromSuperview()
        
        if let speech = RootViewController.shared.skView.scene as? FerrisWheelGameScreen {
            speech.listen = false
        }

        RootViewController.shared.skView.presentScene(StartScreen())
    }
}
