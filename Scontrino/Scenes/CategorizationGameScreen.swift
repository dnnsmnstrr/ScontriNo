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
    
    func createSingleLog (location: CGPoint) {
        
        
        
        
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
                debugPrint(bodyA.node?.name!)
                switch category.nodeFlag.name {
                case "flag fruits":
                    
                    if Consts.CategorizationGameScreen.fruits.contains((bodyA.node?.name)!) {
                        debugPrint("right category")
                        let contactNode = bodyA.node as! MovingContextNode
                        contactNode.category = category.nodeFlag.name!
                        contactNode.isInTheRightCategory = true
                        print("category: " + contactNode.category)
                    }
                    
                case "flag animals":
                    
                    if Consts.CategorizationGameScreen.animals.contains((bodyA.node?.name)!) {
                        debugPrint("right category")
                        let contactNode = bodyA.node as! MovingContextNode
                        contactNode.isInTheRightCategory = true
                        contactNode.category = category.nodeFlag.name!
                        print("category: " + contactNode.category)
                    }
                    
                case "flag clothes":
                    
                    if Consts.CategorizationGameScreen.clothes.contains((bodyA.node?.name)!) {
                        debugPrint("right category")
                        let contactNode = bodyA.node as! MovingContextNode
                        contactNode.isInTheRightCategory = true
                        contactNode.category = category.nodeFlag.name!
                        print("category: " + contactNode.category)
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
                    
                case "flag clothes":
                    
                    if Consts.CategorizationGameScreen.clothes.contains((bodyA.node?.name)!) {
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
      
        
        var index = 0
        var logPosition: CGPoint = CGPoint.zero
        print("altezza nodo: \(logNode[0].size.height)")
        
        print("log category: " + movingNode.category)
        print("log[0] : " + logNode[0].nodeFlag.name!)
        print("log[1] : " + logNode[1].nodeFlag.name!)
        if logNode[0].nodeFlag.name == movingNode.category {
            print("first one")
            logPosition = logNode[0].position
            index = 0
            
        } else if logNode[1].nodeFlag.name == movingNode.category {
            print("second")
            logPosition = logNode[1].position
            index = 1
        }
        
        
        let newSequence = SKAction.sequence([
            movingNode.moveTo(position: logPosition),
            
            //                    createNewMovingNode
            ])
        movingNode.run(newSequence)
        //                movingNode.removeFromParent()
        //                logNode[index].addChild(movingNode)
        
        
        
        
        let newPosition = CGPoint(x: self.logNode[index].initialPosition.x, y: self.frame.height + self.logNode[index].size.height / 2)
        
        //creating animation to get a new hole after the shape is in his center
        //                let createNewLog = SKAction.move(to: newPosition, duration: 2)
        
        
        
        //creating animation to get a new shape
        let createNewMovingNode = SKAction.run {
            
            self.movingNode.removeFromParent()
            self.createMovingNode()
            
        }
        
        
        
        //                let logOutsideTheScene = SKAction.sequence([
        //                    SKAction.wait(forDuration: newSequence.duration),
        //                    SKAction.wait(forDuration: 0.2),
        ////                    SKAction.removeFromParent(),
        ////                    createNewLog
        ////                    logNode[index].moveTo(position: newPosition)
        //
        //                    ])
        
        //        let resetPosition = SKAction.run {
        //
        //            self.logNode[index].position = CGPoint(x: self.logNode[index].initialPosition.x, y: 0 - self.logNode[index].size.height/2)
        //            print("x: \(self.logNode[index].position.x), y: \(self.logNode[index].position.y)")
        //        }
        
        //        let prova = SKAction.run {
        //
        //            self.logNode[index].position = self.logNode[index].initialPosition
        //            print("x: \(self.logNode[index].position.x), y: \(self.logNode[index].position.y)")
        //        }
        
        
        let logInitialPoisition = SKAction.sequence([
            SKAction.wait(forDuration: newSequence.duration),
            SKAction.wait(forDuration: 0.2),
            //            resetPosition,
            logNode[index].moveTo(position: newPosition, startingPoint: logNode[index].position),
            //            movingNode.removeFromParent(),
            //            logNode[index].moveTo(position: CGPoint(x: newPosition.x, y: 0 - self.logNode[index].size.height), startingPoint: newPosition),
            //            SKAction.removeFromParent(),
            logNode[index].moveTo(position: self.logNode[index].initialPosition, startingPoint: CGPoint(x: newPosition.x, y: 0 - self.logNode[index].size.height)),
            createNewMovingNode
            
            ])
        
        //        self.run(changeHoleAnimation)
        //                self.logNode[index].run(changeHoleAnimation)
        //                self.movingNode.removeFromParent()
        //        logNode[index].run(logNode[index].moveTo(position: newPosition))
        
        //        logNode[index].run(logOutsideTheScene)
        
        movingNode.run( movingNode.moveTo(position: newPosition))
        //        logNode[index].position = CGPoint(x: lastPosition.x, y: 0 - logNode[index].size.height/2)
        
        logNode[index].run(logInitialPoisition)
        
        //        movingNode.removeFromParent()
        //        logNode[index].run(logNode[index].moveTo(position: CGPoint(x: 89, y: 350)))
        //        logNode[index].position = CGPoint(x: lastPosition.x, y: 0)
        //        logNode[index].run(logNode[index].moveTo(position: lastPosition))
        
        //                self.run(createNewMovingNode)
        
        
    
        
    }
    
}
