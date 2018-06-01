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
        super.init(size: CGSize(width: Consts.Graphics.screenWidth, height: Consts.Graphics.screenHeight))
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
        backButton.setTexture(imageNamed: "back button highlighted", for: .highlighted)
        backButton.name = "StartScreen"
        backButton.setScale(Consts.Graphics.scale)
        backButton.position = CGPoint(x: 0.1 * Consts.Graphics.screenWidth, y: 0.9 * Consts.Graphics.screenHeight)
        self.addChild(backButton)
        
        let cameraNode = SKCameraNode()
        cameraNode.position = CGPoint(x: Consts.Graphics.screenWidth / 2, y: Consts.Graphics.screenHeight / 2)
        scene?.addChild(cameraNode)
        scene?.camera = cameraNode
        
        let tableNode = TableNode(headerTitle: "Fonemi")
        tableNode.setNumberOfRows(to: Consts.availablePhonemes.count)
        tableNode.position = CGPoint(x: Consts.Graphics.screenWidth / 2, y: Consts.Graphics.screenHeight - tableNode.headerNode.size.height - 100)
        scene?.addChild(tableNode)
        
        for (index, phoneme) in Consts.availablePhonemes.enumerated() {
            let switchNode = SwitchNode(isOn: UserDefaults.standard.bool(forKey: phoneme), onImage: "switch control \(phoneme) on", offImage: "switch control \(phoneme) off")
            switchNode.delegate = self
            switchNode.name = phoneme
            switchNode.yScale = CGFloat(1.0 / Double(Consts.availablePhonemes.count))
            switchNode.position = CGPoint(x: 0.0, y: -switchNode.size.height - CGFloat(150 * CGFloat(index) / CGFloat(Consts.availablePhonemes.count)))
            tableNode.bodyNode.addChild(switchNode)
        }
    }
    
    func buttonNodeTapped(_ sender: ButtonNode) {
        if let name = sender.name {
            switch name {
            case "StartScreen":
                updateSettings()
                RootViewController.shared.skView.presentScene(StartScreen())
            default:
                break
            }
        }
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
    
    private func updateSettings() {
        Consts.FerrisWheelGameScreen.words.removeAll()
        for phoneme in Consts.phonemes {
            if UserDefaults.standard.bool(forKey: phoneme) {
                Consts.FerrisWheelGameScreen.words.append(contentsOf: Consts.availableWords[Difficulty.easy]![.initial]![phoneme]!)
            }
        }
        print(Consts.FerrisWheelGameScreen.words)
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
                    if cameraNode.position.y - dy > -self.size.height {
                        cameraNode.position.y -= dy
                    } else {
                        cameraNode.position.y = -self.size.height
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
