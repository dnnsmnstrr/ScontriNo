//
//  TableNode.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 31/05/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

class TableNode: SKNode {
    let headerNode: SKSpriteNode
    var bodyNode: SKSpriteNode
    var numberOfRows: Int = 1 {
        willSet {
            self.bodyNode.yScale = CGFloat(newValue)
            self.bodyNode.position.y = 0
        }
    }
    var rowHeight: Int = 100
    
    convenience init(headerTitle: String) {
        self.init()
        let headerTitleLabelNode = SKLabelNode(text: headerTitle)
        headerTitleLabelNode.fontSize = 48.0
        headerTitleLabelNode.fontColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        headerTitleLabelNode.position = CGPoint(x: 0.0, y: -headerTitleLabelNode.fontSize / 2)
        headerNode.addChild(headerTitleLabelNode)
    }
    
    override init() {
        headerNode = SKSpriteNode(imageNamed: "table header")
        bodyNode = SKSpriteNode(imageNamed: "table body")
        super.init()
        headerNode.position = CGPoint(x: 0.0, y: headerNode.size.height / 2)
        bodyNode.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        bodyNode.position = CGPoint(x: 0.0, y: 0.0)
        bodyNode.centerRect = CGRect(x: 50.0/500.0, y: 50.0/200.0, width: 400.0/500.0, height: 100.0/200.0)
        self.addChild(headerNode)
        self.addChild(bodyNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        headerNode = SKSpriteNode(imageNamed: "table header")
        bodyNode = SKSpriteNode(imageNamed: "table body")
        super.init(coder: aDecoder)
    }
    
    func setNumberOfRows(to numberOfRows: Int) {
        self.numberOfRows = numberOfRows
    }
    
}
