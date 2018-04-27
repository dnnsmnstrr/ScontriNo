//
//  SpeechRecognitionScene.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 26/04/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

class SpeechRecognitionScreen: GameScene {

    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func createSceneContents() {
        super.createSceneContents()
        let starCardNode = SKSpriteNode(imageNamed: "star card")
        starCardNode.name = "star card"
        starCardNode.position = CGPoint(x: Consts.Graphics.screenWidth / 2, y: Consts.Graphics.screenHeight / 2)
        self.addChild(starCardNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let starCardNode = self.childNode(withName: "star card")
        let fadeAway = SKAction.fadeOut(withDuration: 1.0)
        let removeNode = SKAction.removeFromParent()
        let sequence = SKAction.sequence([fadeAway, removeNode])
        starCardNode?.run(sequence)
        
        let moonCardNode = SKSpriteNode(imageNamed: "moon card")
        moonCardNode.position = CGPoint(x: Consts.Graphics.screenWidth / 2, y: Consts.Graphics.screenHeight / 2)
        self.addChild(moonCardNode)
        moonCardNode.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.0), SKAction.wait(forDuration: 1.0), SKAction.fadeIn(withDuration: 1.0)]))
    }
    
}
