//
//  SettingsScreen.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 29/05/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

class SettingsScreen: SKScene {
    
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
        tableTitleNode.position = CGPoint(x: 0, y: -tableTitleNode.fontSize / 2)
        tableHeaderNode.addChild(tableTitleNode)
        
        let tableBodyNode = SKSpriteNode(imageNamed: "settings table body")
        tableBodyNode.setScale(Consts.Graphics.scale)
        tableBodyNode.position = CGPoint(x: Consts.Graphics.screenWidth / 2, y: tableHeaderNode.position.y - tableBodyNode.size.height + tableHeaderNode.size.height / 2 - 5)
        scene?.addChild(tableBodyNode)
    }
}
