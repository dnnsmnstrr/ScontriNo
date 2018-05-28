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
        super.init(size: CGSize(width: Consts.Graphics.screenWidth, height: Consts.Graphics.screenHeight))
        createSceneContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createSceneContent() {
        let rollerCoasterNode = ButtonNode(imageNamed: "red square")
        rollerCoasterNode.delegate = self
        rollerCoasterNode.name = "RollerCoasterGameScreen"
        rollerCoasterNode.position = CGPoint(x: self.size.width / 2, y: 5.5 * self.size.height / 8)
        self.addChild(rollerCoasterNode)
        
        let floatingLogsNode = ButtonNode(imageNamed: "blue triangle")
        floatingLogsNode.delegate = self
        floatingLogsNode.name = "FloatingLogsGameScreen"
        floatingLogsNode.position = CGPoint(x: self.size.width / 2, y: 4.5 * self.size.height / 8)
        self.addChild(floatingLogsNode)
        
        let ferrisWheelNode = ButtonNode(imageNamed: "orange circle")
        ferrisWheelNode.delegate = self
        ferrisWheelNode.name = "FerrisWheelGameScreen"
        ferrisWheelNode.position = CGPoint(x: self.size.width / 2, y: 3.5 * self.size.height / 8)
        self.addChild(ferrisWheelNode)
        
        let trialNode = ButtonNode(imageNamed: "green star")
        trialNode.delegate = self
        trialNode.name = "TrialScreen"
        trialNode.position = CGPoint(x: self.size.width / 2, y: 1.5 * self.size.height / 8)
        self.addChild(trialNode)
    }
    
    func tapButtonNode(_ sender: ButtonNode) {
        if let name = sender.name {
            switch name {
            case "RollerCoasterGameScreen":
                RootViewController.shared.skView.presentScene(RollerCoasterGameScreen())
            case "FloatingLogsGameScreen":
                RootViewController.shared.skView.presentScene(FloatingLogsGameScreen())
            case "FerrisWheelGameScreen":
                RootViewController.shared.skView.presentScene(FerrisWheelGameScreen())
            case "TrialScreen":
                RootViewController.shared.skView.presentScene(TrialScreen())
            default:
                break
            }
        }
    }
}
