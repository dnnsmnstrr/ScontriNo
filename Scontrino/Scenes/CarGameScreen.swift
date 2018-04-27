//
//  CarGameScreen.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 26/04/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

class CarGameScreen: GameScene {
    let squareNode = MovingNode(imageNamed: "red square")
    var squarePosition: CGPoint!
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func createSceneContents() {
        super.createSceneContents()
        squarePosition = CGPoint(x: CGFloat(UIScreen.main.bounds.width / 2), y: UIScreen.main.bounds.height / 2)
        squareNode.position = squarePosition
        
        self.addChild(squareNode)
    }
    
    override func update(_ currentTime: TimeInterval) {
        squareNode.position = squarePosition
    }
}
