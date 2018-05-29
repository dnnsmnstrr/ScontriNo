//
//  SettingsScreen.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 29/05/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

class SettingsScreen: SKScene, ButtonNodeDelegate, SwitchNodeDelegate {
    var touchLocation: CGPoint!
    
    override init() {
        super.init(size: CGSize(width: Consts.Graphics.screenWidth, height: 5 * Consts.Graphics.screenHeight))
        createSceneContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createSceneContents() {
        self.scaleMode = .resizeFill
        self.backgroundColor = .white
        
        let backButton = ButtonNode(imageNamed: "back button", for: .normal)
        backButton.delegate = self
        backButton.position = CGPoint(x: 100, y: Consts.Graphics.screenHeight - 100)
        backButton.name = "backButton"
        self.addChild(backButton)
        
        let cameraNode = SKCameraNode()
        cameraNode.position = CGPoint(x: Consts.Graphics.screenWidth / 2, y: Consts.Graphics.screenHeight / 2)
        scene?.addChild(cameraNode)
        scene?.camera = cameraNode
        
        let tableHeaderNode = SKSpriteNode(imageNamed: "settings table header")
        tableHeaderNode.setScale(Consts.Graphics.scale)
        tableHeaderNode.position = CGPoint(x: Consts.Graphics.screenWidth / 2, y: Consts.Graphics.screenHeight - tableHeaderNode.size.height)
        scene?.addChild(tableHeaderNode)
        
        let tableTitleNode = SKLabelNode(text: "Fonemi")
        tableTitleNode.fontName = "Helvetica"
        tableTitleNode.fontSize = 48.0
        tableTitleNode.fontColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tableTitleNode.position = CGPoint(x: 0.0, y: -tableTitleNode.fontSize / 2)
        tableHeaderNode.addChild(tableTitleNode)
        
        let tableBodyNode = SKSpriteNode(imageNamed: "settings table body")
        tableBodyNode.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        tableBodyNode.centerRect = CGRect(x: 10.0 / 500.0, y: 10.0 / 200.0, width: 480.0 / 500, height: 180.0 / 200.0)
        tableBodyNode.setScale(Consts.Graphics.scale)
        tableBodyNode.yScale = 23.5
        tableBodyNode.position = CGPoint(x: Consts.Graphics.screenWidth / 2, y: tableHeaderNode.position.y - tableHeaderNode.size.height / 2)
        scene?.addChild(tableBodyNode)
        
        for (index, phoneme) in Consts.phonems.enumerated() {
            let switchNode = SwitchNode(isOn: UserDefaults.standard.bool(forKey: phoneme), onImage: "switch control \(phoneme) on", offImage: "switch control \(phoneme) off")
            switchNode.delegate = self
            switchNode.name = phoneme
            switchNode.yScale = 1 / 23.5
            switchNode.position = CGPoint(x: 0.0, y: -CGFloat(23.5 * switchNode.size.height + CGFloat(150 * index)) / 23.5)
            tableBodyNode.addChild(switchNode)
        }
    }
    
    func buttonNodeTapped(_ sender: ButtonNode) {
        RootViewController.shared.skView.presentScene(StartScreen())
    }
    
    func switchNodeTapped(_ sender: SwitchNode) {
        if let name = sender.name {
            switch name {
            case "a":
                UserDefaults.standard.set(sender.isOn, forKey: "a")
            case "b":
                UserDefaults.standard.set(sender.isOn, forKey: "b")
            case "d":
                UserDefaults.standard.set(sender.isOn, forKey: "d")
            case "dz":
                UserDefaults.standard.set(sender.isOn, forKey: "dz")
            case "dʒ":
                UserDefaults.standard.set(sender.isOn, forKey: "dʒ")
            case "e":
                UserDefaults.standard.set(sender.isOn, forKey: "e")
            case "ɛ":
                UserDefaults.standard.set(sender.isOn, forKey: "ɛ")
            case "f":
                UserDefaults.standard.set(sender.isOn, forKey: "f")
            case "g":
                UserDefaults.standard.set(sender.isOn, forKey: "g")
            case "i":
                UserDefaults.standard.set(sender.isOn, forKey: "i")
            case "j":
                UserDefaults.standard.set(sender.isOn, forKey: "j")
            case "k":
                UserDefaults.standard.set(sender.isOn, forKey: "k")
            case "l":
                UserDefaults.standard.set(sender.isOn, forKey: "l")
            case "ʎ":
                UserDefaults.standard.set(sender.isOn, forKey: "ʎ")
            case "m":
                UserDefaults.standard.set(sender.isOn, forKey: "m")
            case "ɱ":
                UserDefaults.standard.set(sender.isOn, forKey: "ɱ")
            case "n":
                UserDefaults.standard.set(sender.isOn, forKey: "n")
            case "ɲ":
                UserDefaults.standard.set(sender.isOn, forKey: "ɲ")
            case "ŋ":
                UserDefaults.standard.set(sender.isOn, forKey: "ŋ")
            case "o":
                UserDefaults.standard.set(sender.isOn, forKey: "o")
            case "ɔ":
                UserDefaults.standard.set(sender.isOn, forKey: "ɔ")
            case "p":
                UserDefaults.standard.set(sender.isOn, forKey: "p")
            case "r":
                UserDefaults.standard.set(sender.isOn, forKey: "r")
            case "s":
                UserDefaults.standard.set(sender.isOn, forKey: "s")
            case "ʃ":
                UserDefaults.standard.set(sender.isOn, forKey: "ʃ")
            case "t":
                UserDefaults.standard.set(sender.isOn, forKey: "t")
            case "ts":
                UserDefaults.standard.set(sender.isOn, forKey: "ts")
            case "tʃ":
                UserDefaults.standard.set(sender.isOn, forKey: "tʃ")
            case "u":
                UserDefaults.standard.set(sender.isOn, forKey: "u")
            case "v":
                UserDefaults.standard.set(sender.isOn, forKey: "v")
            case "w":
                UserDefaults.standard.set(sender.isOn, forKey: "w")
            case "z":
                UserDefaults.standard.set(sender.isOn, forKey: "z")
            default:
                break
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            touchLocation = touch.location(in: self)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            if let cameraNode = self.camera {
                let dy = location.y - touchLocation.y
                if dy > 0 {
                    if cameraNode.position.y - dy > -3.5 * Consts.Graphics.screenHeight {
                        cameraNode.position.y -= dy
                    } else {
                        cameraNode.position.y = -3.5 * Consts.Graphics.screenHeight
                    }
                } else {
                    if cameraNode.position.y - dy < Consts.Graphics.screenHeight / 2 {
                        cameraNode.position.y -= dy
                    } else {
                        cameraNode.position.y = Consts.Graphics.screenHeight / 2
                    }
                }
                touchLocation = CGPoint(x: location.x, y: location.y - dy)
            }
        }
    }
}
