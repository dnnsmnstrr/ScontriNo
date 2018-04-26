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
        createSceneContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createSceneContents() {
        backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        
        let backButton = ButtonNode(imageNamed: "green star")
        backButton.position = CGPoint(x: 80, y: self.size.height - 80)
        backButton.name = "backButton"
        self.addChild(backButton)
    }
}
