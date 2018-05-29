//
//  SettingsScreen.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 29/05/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

class SettingsScreen: SKScene, SwitchNodeDelegate {
    
    override init() {
        super.init(size: Consts.Graphics.screenResolution)
        createSceneContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createSceneContents() {
        self.backgroundColor = .white
        
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
        tableBodyNode.setScale(Consts.Graphics.scale)
        tableBodyNode.position = CGPoint(x: Consts.Graphics.screenWidth / 2, y: tableHeaderNode.position.y - tableHeaderNode.size.height / 2)
        scene?.addChild(tableBodyNode)
        
        let aSwitchNode = SwitchNode(isOn: UserDefaults.standard.bool(forKey: "a"), onImage: "switch control a on", offImage: "switch control a off")
        aSwitchNode.delegate = self
        aSwitchNode.name = "a"
        aSwitchNode.position = CGPoint(x: 0.0, y: -50 - aSwitchNode.size.height / 2)
        tableBodyNode.addChild(aSwitchNode)
        
        let bSwitchNode = SwitchNode(isOn: UserDefaults.standard.bool(forKey: "b"), onImage: "switch control b on", offImage: "switch control b off")
        bSwitchNode.delegate = self
        bSwitchNode.name = "b"
        bSwitchNode.position = CGPoint(x: 0.0, y: -2 * 50 - 3 * bSwitchNode.size.height / 2)
        tableBodyNode.addChild(bSwitchNode)
    }
    
    func switchNodeTapped(_ sender: SwitchNode) {
        if let name = sender.name {
            switch name {
            case "a":
                UserDefaults.standard.set(sender.isOn, forKey: "a")
            case "b":
                UserDefaults.standard.set(sender.isOn, forKey: "b")
            default:
                break
            }
        }
    }
}
