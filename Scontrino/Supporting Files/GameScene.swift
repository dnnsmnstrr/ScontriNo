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
        super.init(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        createSceneContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createSceneContents() {
        let backButton = ButtonNode(imageNamed: "green star")
        backButton.position = CGPoint(x: 80, y: self.size.height - 80)
        backButton.name = "backButton"
        self.addChild(backButton)
    }
}
