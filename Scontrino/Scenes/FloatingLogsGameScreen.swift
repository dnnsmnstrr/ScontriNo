//
//  FloatingLogsGameScreen.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 02/05/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

class FloatingLogsGameScreen: GameScene, SKPhysicsContactDelegate  {
    let dataSource = GameDataSource()
    var logNode: [LogNode] = []
    var movingNode: MovingContextNode = MovingContextNode()
    var endComparison = false
    var remainingContextMovingNode = 0
    var logIndex = 0
    
    override init() {
        super.init()
        let backgroundNode = SKSpriteNode(imageNamed: "backgroundLog")
        backgroundNode.zPosition = -10
        backgroundNode.size = CGSize(width: self.size.width, height: self.size.height)
        backgroundNode.position = CGPoint(x: size.width/2, y: size.height/2)
        //        backgroundNode.frame =
        self.addChild(backgroundNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func createSceneContents() {
        super.createSceneContents()
        self.physicsWorld.contactDelegate = self
        createLog()
        createMovingNode()
        remainingContextMovingNode = dataSource.countMovingNode(from: logNode)
        remainingContextMovingNode -= 1
        print("nodi rimasti: \(remainingContextMovingNode)")
    }
    
    func  createLog(){
        var flag = dataSource.nextFlagNode()
        logNode.append(LogNode(imageNamed: "log", flag: flag))
        flag = dataSource.nextFlagNode()
        logNode.append(LogNode(imageNamed: "log", flag: flag))
//        random size for random log
        logNode[0].setup(pos: Consts.NodePositions.firstLogPosition)
        logNode[1].setup(pos: Consts.NodePositions.secondLogPosition)
        self.addChild(logNode[0])
        self.addChild(logNode[1])
    }
    
    
    func createMovingNode(){
        movingNode = dataSource.nextMovingContextNode(from: logNode)
//        movingNode.position = CGPoint(x: 200, y: 200)
        self.addChild(movingNode)
        remainingContextMovingNode -= 1
        print("nodi rimasti: \(remainingContextMovingNode)")
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
                case "flag oggetti":
                    
                    if Consts.FloatingLogsGameScreen.oggetti.contains((bodyA.node?.name)!) {
                        debugPrint("right category")
                        let contactNode = bodyA.node as! MovingContextNode
                        contactNode.category = category.nodeFlag.name!
                        contactNode.isInTheRightCategory = true
                        print("category: " + contactNode.category)
                    }
                    
                case "flag abbigliamento":
                    
                    if Consts.FloatingLogsGameScreen.abbigliamento.contains((bodyA.node?.name)!) {
                        debugPrint("right category")
                        let contactNode = bodyA.node as! MovingContextNode
                        contactNode.isInTheRightCategory = true
                        contactNode.category = category.nodeFlag.name!
                        print("category: " + contactNode.category)
                    }
                    
                case "flag animali":
                    
                    if Consts.FloatingLogsGameScreen.animali.contains((bodyA.node?.name)!) {
                        debugPrint("right category")
                        let contactNode = bodyA.node as! MovingContextNode
                        contactNode.isInTheRightCategory = true
                        contactNode.category = category.nodeFlag.name!
                        print("category: " + contactNode.category)
                    }
                    
                case "flag cibo":
                    
                    if Consts.FloatingLogsGameScreen.cibo.contains((bodyA.node?.name)!) {
                        debugPrint("right category")
                        let contactNode = bodyA.node as! MovingContextNode
                        contactNode.isInTheRightCategory = true
                        contactNode.category = category.nodeFlag.name!
                        print("category: " + contactNode.category)
                    }
                    
                case "flag mezziDiTrasporto":
                    
                    if Consts.FloatingLogsGameScreen.mezziDiTrasporto.contains((bodyA.node?.name)!) {
                        debugPrint("right category")
                        let contactNode = bodyA.node as! MovingContextNode
                        contactNode.isInTheRightCategory = true
                        contactNode.category = category.nodeFlag.name!
                        print("category: " + contactNode.category)
                    }
                    
                case "flag stagioni":
                    
                    if Consts.FloatingLogsGameScreen.stagioni.contains((bodyA.node?.name)!) {
                        debugPrint("right category")
                        let contactNode = bodyA.node as! MovingContextNode
                        contactNode.isInTheRightCategory = true
                        contactNode.category = category.nodeFlag.name!
                        print("category: " + contactNode.category)
                    }
                    
                default:
                        debugPrint("default")

                }

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
                case "flag oggetti":
                    
                    if Consts.FloatingLogsGameScreen.oggetti.contains((bodyA.node?.name)!) {
                        debugPrint("right category")
                        let contactNode = bodyA.node as! MovingContextNode
                        contactNode.isInTheRightCategory = false
                        
                        
                    }
                    
                case "flag abbigliamento":
                    
                    if Consts.FloatingLogsGameScreen.abbigliamento.contains((bodyA.node?.name)!) {
                        debugPrint("right category")
                        let contactNode = bodyA.node as! MovingContextNode
                        contactNode.isInTheRightCategory = false
                        
                    }
                    
                case "flag animali":
                    
                    if Consts.FloatingLogsGameScreen.animali.contains((bodyA.node?.name)!) {
                        debugPrint("right category")
                        let contactNode = bodyA.node as! MovingContextNode
                        contactNode.isInTheRightCategory = false
                        
                    }
                    
                case "flag cibo":
                    
                    if Consts.FloatingLogsGameScreen.cibo.contains((bodyA.node?.name)!) {
                        debugPrint("right category")
                        let contactNode = bodyA.node as! MovingContextNode
                        contactNode.isInTheRightCategory = false
                        
                    }
                    
                case "flag mezziDiTrasporto":
                    
                    if Consts.FloatingLogsGameScreen.mezziDiTrasporto.contains((bodyA.node?.name)!) {
                        debugPrint("right category")
                        let contactNode = bodyA.node as! MovingContextNode
                        contactNode.isInTheRightCategory = false
                        
                    }
                    
                case "flag stagioni":
                    
                    if Consts.FloatingLogsGameScreen.stagioni.contains((bodyA.node?.name)!) {
                        debugPrint("right category")
                        let contactNode = bodyA.node as! MovingContextNode
                        contactNode.isInTheRightCategory = false
                        
                    }
                    
                    
                default:
                        debugPrint("right category")
                }
                
            }
        }
        
    }
    
    func checkRightCategory () {
      
//        cont += 1
        
        if remainingContextMovingNode == 0 {
            endComparison = true
        }
        
//        if !endComparison {
        
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
            logIndex = index
        } else if logNode[1].nodeFlag.name == movingNode.category {
            print("second")
            logPosition = logNode[1].position
            index = 1
            logIndex = index
        }
        
        
        let newSequence = SKAction.sequence([
            movingNode.moveTo(position: logPosition)
            ])
        
//        movingNode.run(newSequence)
        
        
        
        
        let newPosition = CGPoint(x: self.logNode[index].initialPosition.x, y: self.frame.height + self.logNode[index].size.height / 2)
        
        //creating animation to get a new hole after the shape is in his center
        
        if !endComparison {
         movingNode.run(newSequence)
        //creating animation to get a new shape
        let createNewMovingNode = SKAction.run {
            
            self.movingNode.removeFromParent()
            self.createMovingNode()
            
        }
        
        
        
        let logInitialPoisition = SKAction.sequence([
            SKAction.wait(forDuration: newSequence.duration),
            SKAction.wait(forDuration: 0.2),
            logNode[index].moveTo(position: newPosition, startingPoint: logNode[index].position),
            createNewMovingNode,
            logNode[index].moveTo(position: self.logNode[index].initialPosition, startingPoint: CGPoint(x: newPosition.x, y: 0 - self.logNode[index].size.height)),
            
            
            ])
       
        
        movingNode.run( movingNode.moveTo(position: newPosition))
        
        logNode[index].run(logInitialPoisition)
            
            
        } else {
//            let removeMovingNode = SKAction.run{
//            self.movingNode.removeFromParent()
//            }
            
            let goBack = SKAction.run {
                RootViewController.shared.skView.presentScene(MenuScreen())
            }
//
            let finalLogInitialPoisition = SKAction.sequence([
                SKAction.wait(forDuration: newSequence.duration),
                SKAction.wait(forDuration: 0.2),
                logNode[index].moveTo(position: newPosition, startingPoint: logNode[index].position),
                goBack
//                logNode[index].moveTo(position: self.logNode[index].initialPosition, startingPoint: CGPoint(x: newPosition.x, y: 0 - self.logNode[index].size.height)),
                ])
            movingNode.run( movingNode.moveTo(position: newPosition))
             logNode[index].run(finalLogInitialPoisition)
            
//         //   create new log or exit
            
            
        }
        
    }
    
}
