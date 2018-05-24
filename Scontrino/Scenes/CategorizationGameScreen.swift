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
        self.physicsWorld.contactDelegate = self
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
    
    
    public func didBegin(_ contact: SKPhysicsContact) {
        var bodyA = contact.bodyA //oggetto
        var bodyB = contact.bodyB // categoria
        if contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask {
            bodyA = contact.bodyB
            bodyB = contact.bodyA
            debugPrint("A Better then B")
        }else{
            debugPrint("B Better then A")
            //            nodeA = contact.bodyA.node
            //            nodeB = contact.bodyB.node
        }
        if bodyA.categoryBitMask == Consts.PhysicsMask.shapeNodes {
            if bodyB.categoryBitMask == Consts.PhysicsMask.holeNode {
                debugPrint("scontro")
                
                let category = bodyB.node as! LogNode
                debugPrint(category.nodeFlag.name!)
                debugPrint(bodyA.node?.name)
                switch category.nodeFlag.name {
                case "flag fruits":
                    
                    if Consts.CategorizationGameScreen.fruits.contains((bodyA.node?.name)!) {
                        debugPrint("right category")
                        let contactNode = bodyA.node as! MovingContextNode
                        contactNode.isInTheRightCategory = true
                    }
                    
                case "flag animals":
                    
                    if Consts.CategorizationGameScreen.animals.contains((bodyA.node?.name)!) {
                        debugPrint("right category")
                        let contactNode = bodyA.node as! MovingContextNode
                        contactNode.isInTheRightCategory = true
                    }
                    
                default:
                    
//                    if Consts.CategorizationGameScreen.fruits.contains((bodyA.node?.name)!) {
                        debugPrint("default")
//                        let contactNode = bodyA.node as! MovingContextNode
//                        contactNode.isInTheRightCategory = true
//                    }
                }
                
//                if bodyA.node?.name == bodyB.node?.name {
//                    debugPrint("same Shape")
//                    let contactNode = bodyA.node as! MovingShapeNode
//                    contactNode.isInTheRightHole = true
//                }
            }
        }
    }
    
    public func didEnd(_ contact: SKPhysicsContact) {
        var bodyA = contact.bodyA
        var bodyB = contact.bodyB
        if contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask {
            bodyA = contact.bodyB
            bodyB = contact.bodyA
            debugPrint("A Better then B")
        }else{
            debugPrint("B Better then A")
            //            nodeA = contact.bodyA.node
            //            nodeB = contact.bodyB.node
        }
        if bodyA.categoryBitMask == Consts.PhysicsMask.shapeNodes {
            if bodyB.categoryBitMask == Consts.PhysicsMask.holeNode {
                debugPrint("end scontro")
                
                let category = bodyB.node as! LogNode
                
                switch category.nodeFlag.name {
                case "flag fruits":
                    
                    if Consts.CategorizationGameScreen.fruits.contains((bodyA.node?.name)!) {
                        debugPrint("right category")
                        let contactNode = bodyA.node as! MovingContextNode
                        contactNode.isInTheRightCategory = false
                    }
                    
                case "flag animals":
                    
                    if Consts.CategorizationGameScreen.animals.contains((bodyA.node?.name)!) {
                        debugPrint("right category")
                        let contactNode = bodyA.node as! MovingContextNode
                        contactNode.isInTheRightCategory = false
                    }
                    
                default:
                    
//                    if Consts.CategorizationGameScreen.fruits.contains((bodyA.node?.name)!) {
                        debugPrint("right category")
//                        let contactNode = bodyA.node as! MovingContextNode
//                        contactNode.isInTheRightCategory = false
//                    }
                }
                
//                if bodyA.node?.name == bodyB.node?.name {
//                    debugPrint("same Shape")
//                    let contactNode = bodyA.node as! MovingShapeNode
//                    contactNode.isInTheRightHole = false
//                }
            }
        }
        
    }
    
    func checkRightCategory () {
        
    }
    
}
