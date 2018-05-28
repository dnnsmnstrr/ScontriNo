//
//  RollerCoasterGameScreen.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 26/04/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//
//MARK: add end game, add score, decrease size of moving node physics body

import SpriteKit

class RollerCoasterGameScreen: GameScene, SKPhysicsContactDelegate {
    let dataSource = GameDataSource()
    var numberShapesRemaining = Consts.shapes.count
    var holeNode: HoleNode!
    let textureWidth = MovingShapeNode(imageNamed: "red square").size.width
    //shape arrays
    var coloredShapesNodes: [MovingShapeNode] = []
    var coloredShapesPositions: [String: CGPoint] = [:]
    var coloredShapesInitialPositions = CGPoint.zero
    var coloredHoleNodes: [MovingShapeNode] = []
    var endGame = false
    var canCreateShapes = false
    //train Nodes
    var train = Train()
    var trainXPosition: CGFloat = 0
    var trainAnimDuration: TimeInterval = 0.0
    var vagonIndex = 0
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func createSceneContents() {
        super.createSceneContents()
        self.physicsWorld.contactDelegate = self
        
        createTrain()
        trainXPosition = Consts.Graphics.screenWidth + (self.train.headVagon.size.width / 2)
        self.moveTrain(pos: trainXPosition) { (value) in
            if(value) {
                self.createShapes()
                self.createHole()
            }
        }
    }
    func createTrain() {
        train.setupTrain(numberOfShapes: setDifficulty())
        self.addChild(train.headVagon)
        for index in 0...train.centralVagons.count - 1 {
            self.addChild(train.centralVagons[index])
        }
        self.addChild(train.tailVagon)
    }
    
    func moveTrain(pos: CGFloat, onComplete: @escaping (Bool) -> Void ) {
        train.moveTrain(pos: pos) { (value) in
            if(value) {
                onComplete(true)
            }
        }
    }
    
    func createShapes() {
        let numberOfShapes = setDifficulty()
        for index in  0..<numberOfShapes{
            coloredShapesNodes.append(dataSource.nextMovingShapeNode())
            createOneShape(index: index, numberOfShapes: numberOfShapes)
        }
        numberShapesRemaining -= numberOfShapes
    }
    
    func createOneShape(index: Int, numberOfShapes: Int){
        
        let spacing: CGFloat = 10
        coloredShapesNodes[index].name = Consts.Id.RollerCoasterGameScreen.coloredShapeNode + "\(index)"
        coloredShapesPositions[coloredShapesNodes[index].name!] = (CGPoint(x: CGFloat(UIScreen.main.bounds.width / CGFloat(numberOfShapes) + spacing + (CGFloat(index) * textureWidth ) ), y: UIScreen.main.bounds.height / 2))
        coloredShapesNodes[index].position = coloredShapesPositions[coloredShapesNodes[index].name!]!
        self.addChild(coloredShapesNodes[index])
    }
    
    func setDifficulty() -> Int {
        let difficulty = 1 //example for difficulty
        var numberOfShapes: Int
        switch difficulty {
        case 1:
            numberOfShapes = 3
        case 2:
            numberOfShapes = 4
        case 3:
            numberOfShapes = 5
        case 4:
            numberOfShapes = 6
        default:
            numberOfShapes = 3
        }
        return numberOfShapes
    }
    
    func createHole(){
        holeNode = dataSource.nextStaticNode(from: coloredShapesNodes)
//        holeNode.setup(pos: CGPoint(x: CGFloat(UIScreen.main.bounds.width / 2), y: UIScreen.main.bounds.height / 3))
        holeNode.setup(pos: train.centralVagons[vagonIndex].position)
        self.addChild(holeNode)
    }
    
    func shapeIsGoingToRightHole(nodeName: String){
        var i = 0
        while i < coloredShapesNodes.count {
            if coloredShapesNodes[i].name == nodeName {
                let index = i
                coloredShapesNodes[index].moveTo(position: holeNode.position) { (value) in
                    if value {
                        self.coloredHoleNodes.append(self.coloredShapesNodes[index])
                        self.coloredHoleNodes[self.vagonIndex].position = self.holeNode.position
                        if self.numberShapesRemaining > 0 {
                            self.coloredShapesNodes[index] = self.dataSource.nextMovingShapeNode()
                            self.createOneShape(index: index, numberOfShapes: self.setDifficulty())
                        } else {
                            self.coloredShapesNodes.remove(at: index)
                        }
                        self.trainXPosition += self.train.headVagon.size.width
                        self.moveTrain(pos: self.trainXPosition) { (value) in
                            if(value) {
                                self.holeNode.removeFromParent()
                                if self.coloredShapesNodes.count > 0{
                                    self.createHole()
                                } else {
                                    self.endGame = true
                                }
                                self.vagonIndex += 1
                            }
                        }
                        
                    }
                }
                
            }
        }
    }
    
    func controlIfRightShapeInHole(nodeName: String) {
        var i = 0
        while i < coloredShapesNodes.count {
            
            if coloredShapesNodes[i].name == nodeName {
                let index = i
                //creating animation to get a new shape
                let createNewShapeNode = SKAction.run {
                    if self.numberShapesRemaining > 0 {
                    self.coloredShapesNodes[index] = self.dataSource.nextMovingShapeNode()
                    self.createOneShape(index: index, numberOfShapes: self.setDifficulty())
                    } else {
                        self.coloredShapesNodes.remove(at: index)
                    }
                }
                
                //                coloredShapesNodes[i].isFitting = true
                //                let path = UIBezierPath()
                //                path.move(to: coloredShapesNodes[i].position)
                //                path.addLine(to: holeNode.position)
                //
                //                let fillInHoleAnimation = SKAction.sequence([
                //                    SKAction.follow(path.cgPath, asOffset: false, orientToPath: false, speed: 100),
                //                    SKAction.removeFromParent(),
                //                    createNewShapeNode
                //                    ])
                
                
                //creating animation to get the colored hole
                let createColoredHole = SKAction.run {
                    
//                    self.addChild(self.coloredHoleNodes[self.vagonIndex])
                }
                
                //creating animation to get a new hole after the shape is in his center
                let createNewHole = SKAction.run {
                    if self.coloredShapesNodes.count > 0{
                    self.createHole()
                    } else {
                        self.endGame = true
                    }
                }
                
                let changeHoleAnimation = SKAction.sequence([
                    //                    SKAction.wait(forDuration: newSequence.duration),
                    //                    SKAction.wait(forDuration: moveTrainAnim.duration),
                    SKAction.removeFromParent(),
                    createNewHole
                    ])
                trainXPosition += train.headVagon.size.width
                
                let moveToAnimation = SKAction.run {
//                    self.coloredShapesNodes[index].moveTo(position: self.holeNode.position)
                    self.moveTrain(pos: self.trainXPosition) { (value) in
                        if(value) {
                            self.holeNode.run(changeHoleAnimation)
                            self.vagonIndex += 1
                        }
                    }
                }
                
                //creating animation sequence to move the shape to the hole and than creating a new shape
                let newSequence = SKAction.sequence([
                    createColoredHole,
                    moveToAnimation,
                    createNewShapeNode
                    ])
                coloredShapesNodes[index].run(newSequence)
                
//                let moveTrainAnim = SKAction.run {
////                    self.trainAnimDuration = self.train.moveTrain(pos: self.train.headVagon.position.x + self.train.headVagon.size.width)
////
//                }
                
//                let moveTrainAnimationSq = SKAction.sequence([
//                    SKAction.wait(forDuration: newSequence.duration),
//                                  moveTrainAnim,
////                                  self.coloredHoleNodes[self.vagonIndex].moveTo(position: CGPoint(x: self.train.headVagon.position.x + self.train.headVagon.size.width, y: self.coloredHoleNodes[self.vagonIndex].position.y))
//                    ])
//                self.run(moveTrainAnimationSq)
                
                numberShapesRemaining -= 1
                print("number of remaining shapes are \(numberShapesRemaining)")
            }
            i += 1
        }
    }
    
    func endGameFunction() {
        print("THE END FRA'")
        endGame = false
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {
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
                debugPrint("scontro")
                if bodyA.node?.name == bodyB.node?.name {
                    debugPrint("same Shape")
                    let contactNode = bodyA.node as! MovingShapeNode
                    contactNode.isInTheRightHole = true
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
                if bodyA.node?.name == bodyB.node?.name {
                    debugPrint("same Shape")
                    let contactNode = bodyA.node as! MovingShapeNode
                    contactNode.isInTheRightHole = false
                }
            }
        }
        print(coloredShapesNodes.first!.texture!.description.split(separator: "\'"))
        print(coloredShapesNodes.first!.texture!.description.split(separator: "\'")[1])
    }
    
    override func update(_ currentTime: TimeInterval) {
        if endGame {
            endGameFunction()
        }
        
        for index in  0..<coloredShapesNodes.count {
            if !coloredShapesNodes[index].isFitting{
                coloredShapesNodes[index].position = coloredShapesPositions[coloredShapesNodes[index].name!]!
            }
        }
    }
}