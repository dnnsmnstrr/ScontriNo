//
//  CategorizationGameScreen.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 02/05/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

class CategorizationGameScreen: GameScene, SKPhysicsContactDelegate  {
    let dataSource = GameDataSource()
    var logNode: [LogNode] = []
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func createSceneContents() {
        super.createSceneContents()
        createLog()
    }
    
    func  createLog(){
        var flag = dataSource.nextFlagNode()
        logNode.append(LogNode(imageNamed: "log", flag: flag))
//        random size for random log
        logNode[0].setup(pos: CGPoint(x: 70, y: 120))
        
        self.addChild(logNode[0])
    }
}
