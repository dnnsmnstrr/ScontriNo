//
//  StartScreen.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 26/04/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

class StartScreen: SKScene {
    
    override init() {
        super.init(size: CGSize(width: Consts.Graphics.screenWidth, height: Consts.Graphics.screenHeight))
        createSceneContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createSceneContent() {
        // Add additional scene contents here.
        let topNode = SKShapeNode(rect: CGRect(x: -100, y: -50, width: 200, height: 100))
        topNode.name = "topNode"
        topNode.fillColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        topNode.position = CGPoint(x: self.size.width / 2, y: 3 * self.size.height / 4)
        self.addChild(topNode)
        
        let middleNode = SKShapeNode(rect: CGRect(x: -100, y: -50, width: 200, height: 100))
        middleNode.name = "middleNode"
        middleNode.fillColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        middleNode.position = CGPoint(x: self.size.width / 2, y: 2 * self.size.height / 4)
        self.addChild(middleNode)
        
        let bottomNode = SKShapeNode(rect: CGRect(x: -100, y: -50, width: 200, height: 100))
        bottomNode.name = "bottomNode"
        bottomNode.fillColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        bottomNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 4)
        self.addChild(bottomNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            
            switch node.name {
            case "topNode":
                RootViewController.shared.skView.presentScene(CarGameScreen())
            case "middleNode":
                RootViewController.shared.skView.presentScene(FaceDetectionScreen())
            case "bottomNode":
                RootViewController.shared.skView.presentScene(SpeechRecognitionScreen())
            default:
                break
            }
        }
    }
}
