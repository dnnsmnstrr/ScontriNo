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
    var cont = 0
    let numberOfComprarison = 5
    var endComparison = false
    
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
        logNode[0].setup(pos: Consts.NodePositions.firstLogPosition)
        logNode[1].setup(pos: Consts.NodePositions.secondLogPosition)
        self.addChild(logNode[0])
        self.addChild(logNode[1])
    }
    
    
    func createMovingNode(){
        movingNode = dataSource.nextMovingContextNode(from: logNode)
//        movingNode.position = CGPoint(x: 200, y: 200)
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
                    
                    if Consts.FloatingLogsGameScreen.fruits.contains((bodyA.node?.name)!) {
                        debugPrint("right category")
                        let contactNode = bodyA.node as! MovingContextNode
                        contactNode.category = category.nodeFlag.name!
                        contactNode.isInTheRightCategory = true
                        print("category: " + contactNode.category)
                    }
                    
                case "flag animals":
                    
                    if Consts.FloatingLogsGameScreen.animals.contains((bodyA.node?.name)!) {
                        debugPrint("right category")
                        let contactNode = bodyA.node as! MovingContextNode
                        contactNode.isInTheRightCategory = true
                        contactNode.category = category.nodeFlag.name!
                        print("category: " + contactNode.category)
                    }
                    
                case "flag clothes":
                    
                    if Consts.FloatingLogsGameScreen.clothes.contains((bodyA.node?.name)!) {
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
                case "flag fruits":
                    
                    if Consts.FloatingLogsGameScreen.fruits.contains((bodyA.node?.name)!) {
                        debugPrint("right category")
                        let contactNode = bodyA.node as! MovingContextNode
                        contactNode.isInTheRightCategory = false
                        
                        
                    }
                    
                case "flag animals":
                    
                    if Consts.FloatingLogsGameScreen.animals.contains((bodyA.node?.name)!) {
                        debugPrint("right category")
                        let contactNode = bodyA.node as! MovingContextNode
                        contactNode.isInTheRightCategory = false
                        
                    }
                    
                case "flag clothes":
                    
                    if Consts.FloatingLogsGameScreen.clothes.contains((bodyA.node?.name)!) {
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
      
        cont += 1
        
        if cont == numberOfComprarison {
            endComparison = true
        }
        
        if !endComparison {
        
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
            movingNode.moveTo(position: logPosition)
            ])
        
        movingNode.run(newSequence)
        
        
        
        
        let newPosition = CGPoint(x: self.logNode[index].initialPosition.x, y: self.frame.height + self.logNode[index].size.height / 2)
        
        //creating animation to get a new hole after the shape is in his center
        
        
        
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
            
            //create new log or exit
            RootViewController.shared.skView.presentScene(StartScreen())
            
        }
        
    }
    
}
