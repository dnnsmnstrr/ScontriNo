//
//  MenuScreen.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 26/04/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

class MenuScreen: SKScene, ButtonNodeDelegate {
    var touchLocation: CGPoint!
    
    override init() {
        super.init(size: Consts.Graphics.screenResolution)
        createSceneContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createSceneContent() {
        let backgroundNode = SKSpriteNode(imageNamed: "start screen background")
        backgroundNode.setScale(Consts.Graphics.scale)
        backgroundNode.position = CGPoint(x: Consts.Graphics.screenWidth / 2, y: Consts.Graphics.screenHeight / 2)
        self.addChild(backgroundNode)
        
        let backButton = ButtonNode(imageNamed: "back button", for: .normal)
        backButton.delegate = self
        backButton.name = "StartScreen"
        backButton.setScale(Consts.Graphics.scale)
        backButton.position = CGPoint(x: 100, y: self.size.height - 100)
        self.addChild(backButton)
        
        let ferrisWheelNode = ButtonNode(imageNamed: "ferris wheel icon", for: .normal)
        ferrisWheelNode.delegate = self
        ferrisWheelNode.name = "FerrisWheelGameScreen"
        ferrisWheelNode.setScale(Consts.Graphics.scale)
        ferrisWheelNode.position = CGPoint(x: Consts.Graphics.screenWidth / 2, y: Consts.Graphics.screenHeight / 2)
        self.addChild(ferrisWheelNode)
        
        let rollerCoasterNode = ButtonNode(imageNamed: "roller coaster icon", for: .normal)
        rollerCoasterNode.delegate = self
        rollerCoasterNode.name = "RollerCoasterGameScreen"
        rollerCoasterNode.setScale(Consts.Graphics.scale)
        rollerCoasterNode.position = CGPoint(x: Consts.Graphics.screenWidth / 6, y: Consts.Graphics.screenHeight / 2 - (ferrisWheelNode.size.height - rollerCoasterNode.size.height) / 2)
        self.addChild(rollerCoasterNode)
        
        let floatingLogsNode = ButtonNode(imageNamed: "floating logs icon", for: .normal)
        floatingLogsNode.delegate = self
        floatingLogsNode.name = "FloatingLogsGameScreen"
        floatingLogsNode.setScale(Consts.Graphics.scale)
        floatingLogsNode.position = CGPoint(x: 5 * Consts.Graphics.screenWidth / 6, y: Consts.Graphics.screenHeight / 2 - (ferrisWheelNode.size.height - floatingLogsNode.size.height) / 2)
        self.addChild(floatingLogsNode)
        
//        let trialNode = ButtonNode(imageNamed: "green star", for: .normal)
//        trialNode.delegate = self
//        trialNode.name = "TrialScreen"
//        trialNode.position = CGPoint(x: self.size.width / 2, y: 1.5 * self.size.height / 8)
//        self.addChild(trialNode)
    }
    
    func buttonNodeTapped(_ sender: ButtonNode) {
        if let name = sender.name {
            switch name {
            case "StartScreen":
                RootViewController.shared.skView.presentScene(StartScreen())
            case "RollerCoasterGameScreen":
                RootViewController.shared.skView.presentScene(RollerCoasterGameScreen())
            case "FloatingLogsGameScreen":
                RootViewController.shared.skView.presentScene(FloatingLogsGameScreen())
            case "FerrisWheelGameScreen":
                RootViewController.shared.skView.presentScene(FerrisWheelGameScreen())
//            case "TrialScreen":
//                RootViewController.shared.skView.presentScene(TrialScreen())
            default:
                break
            }
        }
    }
}
