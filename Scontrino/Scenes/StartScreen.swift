//
//  StartScreen.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 26/04/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

class StartScreen: SKScene, ButtonNodeDelegate {
    var touchLocation: CGPoint!
    
    override init() {
        super.init(size: CGSize(width: Consts.Graphics.screenWidth * 2, height: 2 * Consts.Graphics.screenHeight))
        createSceneContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createSceneContent() {
        self.scaleMode = .resizeFill
        // Add additional scene contents here.
        let cameraNode = SKCameraNode()
        cameraNode.position = CGPoint(x: Consts.Graphics.screenWidth, y: Consts.Graphics.screenHeight)
        self.addChild(cameraNode)
        self.camera = cameraNode
        
        let extraNode = ButtonNode(imageNamed: "blue triangle")
        extraNode.delegate = self
        extraNode.name = "CategoriseGameScreen"
        extraNode.position = CGPoint(x: self.size.width / 2, y: 5.5 * self.size.height / 8)
        self.addChild(extraNode)
        
        let topNode = ButtonNode(imageNamed: "red square")
        topNode.delegate = self
        topNode.name = "CarGameScreen"
        topNode.position = CGPoint(x: self.size.width / 2, y: 4.5 * self.size.height / 8)
        self.addChild(topNode)
        
        let middleNode = ButtonNode(imageNamed: "orange circle")
        middleNode.delegate = self
        middleNode.name = "FaceDetectionScreen"
        middleNode.position = CGPoint(x: self.size.width / 2, y: 3.5 * self.size.height / 8)
        self.addChild(middleNode)
        
        let bottomNode = ButtonNode(imageNamed: "yellow rounded")
        bottomNode.delegate = self
        bottomNode.name = "SpeechRecognitionScreen"
        bottomNode.position = CGPoint(x: self.size.width / 2, y: 2.5 * self.size.height / 8)
        self.addChild(bottomNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            touchLocation = touch.location(in: self)
            let node = self.atPoint(touchLocation)
            
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
    
    func tapButtonNode(_ sender: ButtonNode) {
        if let name = sender.name {
            switch name {
            case "CarGameScreen":
                RootViewController.shared.skView.presentScene(CarGameScreen())
            case "FaceDetectionScreen":
                RootViewController.shared.skView.presentScene(FaceDetectionScreen())
            case "SpeechRecognitionScreen":
                RootViewController.shared.skView.presentScene(SpeechRecognitionScreen())
            default:
                print("default")
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if let cameraNode = self.camera {
                let (dx, dy) = (location.x - touchLocation.x, location.y - touchLocation.y)
                
                cameraNode.position.x -= dx
                cameraNode.position.y -= dy
                
                touchLocation = CGPoint(x: location.x - dx, y: location.y - dy)
            }
        }
    }
}
