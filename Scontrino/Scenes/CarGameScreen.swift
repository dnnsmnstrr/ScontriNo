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
    var squarePosition = CGPoint.zero
    
    var intersectArea = SKShapeNode(rect: CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 100, height: 100))
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func createSceneContents() {
        super.createSceneContents()
        
        let graySquare = SKSpriteNode(imageNamed: "gray square")
        graySquare.position = CGPoint(x: self.frame.width / 4, y: self.frame.midY)
        self.addChild(graySquare)
        
        intersectArea.fillColor = .brown
        self.addChild(intersectArea)
        
        squareNode.name = "square"
        squareNode.position = CGPoint(x: CGFloat(self.frame.midX), y: self.frame.midY)
        squareNode.physicsBody = SKPhysicsBody(rectangleOf: squareNode.size, center: squareNode.position)
        squareNode.physicsBody?.affectedByGravity = false
        
        squarePosition = squareNode.position
        self.addChild(squareNode)
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first {
//            let location = touch.location(in: self)
//            let node = self.atPoint(location)
//        }
//    }
    
    override func update(_ currentTime: TimeInterval) {
        squareNode.position = squarePosition
        print("line 51")
        if let body = self.physicsWorld.body(in: intersectArea.frame) {
            print("line 53")
            if body == squareNode.physicsBody {
                squareNode.texture = SKTexture(imageNamed: "highlighted red square")
            }
        } else {
            squareNode.texture = SKTexture(imageNamed: "red square")
        }
        // opzione 1 -
    }
}
