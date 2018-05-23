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
    var movingNode: MovingContextNode = MovingContextNode()
    var movingContextNodeInitialPosition = CGPoint.zero
    var movingContextNodePosition: [String: CGPoint] = [:]
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func createSceneContents() {
        super.createSceneContents()
        createLog()
        createMovingNode()
    }
    
    func  createLog(){
        var flag = dataSource.nextFlagNode()
        logNode.append(LogNode(imageNamed: "log", flag: flag))
        flag = dataSource.nextFlagNode()
        logNode.append(LogNode(imageNamed: "log", flag: flag))
//        random size for random log
        logNode[0].setup(pos: CGPoint(x: 90, y: 350))
        logNode[1].setup(pos: CGPoint(x: 320, y: 350))
        self.addChild(logNode[0])
        self.addChild(logNode[1])
    }
    
    func createMovingNode(){
        movingNode = dataSource.nextMovingContextNode(from: logNode)
        movingNode.position = CGPoint(x: 200, y: 200)
        self.addChild(movingNode)
    }
}
