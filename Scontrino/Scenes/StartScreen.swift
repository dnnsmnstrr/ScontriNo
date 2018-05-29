//
//  StartScreen.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 28/05/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

class StartScreen: SKScene, ButtonNodeDelegate {
    
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
        
        let settingsButtonNode = ButtonNode(imageNamed: "settings button normal")
        settingsButtonNode.delegate = self
        settingsButtonNode.name = "SettingsScreen"
        settingsButtonNode.setScale(Consts.Graphics.scale)
        settingsButtonNode.position = CGPoint(x: Consts.Graphics.screenWidth - settingsButtonNode.size.width / 2, y: Consts.Graphics.screenHeight - settingsButtonNode.size.height / 2)
        scene?.addChild(settingsButtonNode)
        
        let leftDoorGateNode = SKSpriteNode(imageNamed: "gate left door")
        leftDoorGateNode.name = "gate left door"
        leftDoorGateNode.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        leftDoorGateNode.setScale(Consts.Graphics.scale)
        print(Consts.Graphics.screenBounds)
        leftDoorGateNode.position = CGPoint(x: 0.0, y: 0.0)
        scene?.addChild(leftDoorGateNode)
        
        let rightDoorGateNode = SKSpriteNode(imageNamed: "gate right door")
        rightDoorGateNode.name = "gate right door"
        rightDoorGateNode.anchorPoint = CGPoint(x: 1.0, y: 0.0)
        rightDoorGateNode.setScale(Consts.Graphics.scale)
        rightDoorGateNode.position = CGPoint(x: Consts.Graphics.screenWidth, y: 0.0)
        scene?.addChild(rightDoorGateNode)

        let playButtonNode = ButtonNode(imageNamed: "play button normal")
        playButtonNode.delegate = self
        playButtonNode.name = "MenuScreen"
        playButtonNode.setScale(Consts.Graphics.scale)
        playButtonNode.position = CGPoint(x: Consts.Graphics.screenWidth / 2, y: Consts.Graphics.screenHeight / 2)
        scene?.addChild(playButtonNode)
    }
    
    func buttonNodeTapped(_ sender: ButtonNode) {
        if let name = sender.name {
            switch name {
            case "MenuScreen":
                let settingsButton = scene?.childNode(withName: "SettingsScreen") as! ButtonNode
                let playButton = scene?.childNode(withName: "MenuScreen") as! ButtonNode
                let leftDoor = scene?.childNode(withName: "gate left door") as! SKSpriteNode
                let rightDoor = scene?.childNode(withName: "gate right door") as! SKSpriteNode
                let moveGateLeft = SKAction.move(by: CGVector(dx: -leftDoor.size.width, dy: 0.0), duration: 1.0)
                let moveGateRight = SKAction.move(by: CGVector(dx: rightDoor.size.width, dy: 0.0), duration: 1.0)
                let fadeOut = SKAction.fadeOut(withDuration: 1.0)
                let transition = SKAction.run {
                    RootViewController.shared.skView.presentScene(MenuScreen())
                }
                let playSequence = SKAction.sequence([fadeOut, transition])
                let leftDoorGroup = SKAction.group([moveGateLeft, fadeOut])
                let rightDoorGroup = SKAction.group([moveGateRight, fadeOut])
                playButton.run(playSequence)
                settingsButton.run(fadeOut)
                leftDoor.run(leftDoorGroup)
                rightDoor.run(rightDoorGroup)
            case "SettingsScreen":
                RootViewController.shared.skView.presentScene(SettingsScreen())
            default:
                break
            }
        }
    }
}
