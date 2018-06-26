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
    //MARK: Eliminate + 3
    var numberShapesRemaining = Consts.shapes.count
    var holeNode: HoleNode!
    let textureWidth = MovingShapeNode(imageNamed: "square normal").size.width
    //shape arrays
    var coloredShapesNodes: [MovingShapeNode] = []
    var coloredFakeShapesNodes: [MovingShapeNode] = []
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
    
    var coloredFakeShapesIndex = 0
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func createSceneContents() {
        super.createSceneContents()
        self.physicsWorld.contactDelegate = self
        createBackground()
        createTrain()
        trainXPosition = Consts.Graphics.screenWidth + (self.train.headVagon.size.width / 2) 
        self.moveTrain() { (value) in
            if(value) {
                self.createShapes()
                self.createHole()
            }
        }
    }
    
    func createBackground() {
        let background = SKSpriteNode(imageNamed: "roller coaster background")
        background.name = "background"
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.zPosition = Consts.RollerCoasterGameScreen.zPositions.background
        addChild(background)
    }
    func createTrain() {
        train.setupTrain(numberOfShapes: Consts.shapes.count - 1)
//        test number
//        train.setupTrain(numberOfShapes: 5)
        self.addChild(train.headVagon)
        for index in 0...train.centralVagons.count - 1 {
            self.addChild(train.centralVagons[index])
        }
        self.addChild(train.tailVagon)
    }
    
    func moveTrain(onComplete: @escaping (Bool) -> Void ) {
        train.moveTrain(pos: trainXPosition) { (value) in
            if(value) {
                onComplete(true)
            }
        }
    }
    
    func createShapes() {
        let numberOfShapes = setDifficulty()
        for index in  0..<numberOfShapes {
            coloredShapesNodes.append(dataSource.nextMovingShapeNode())
            createOneShape(index: index, numberOfShapes: numberOfShapes)
        }
        numberShapesRemaining -= numberOfShapes
    }
    
    func createOneShape(index: Int, numberOfShapes: Int){
        
        let spacing: CGFloat = Consts.Graphics.screenHeight / 100
        coloredShapesNodes[index].name = Consts.Id.RollerCoasterGameScreen.coloredShapeNode + "\(index)"
//        coloredShapesPositions[coloredShapesNodes[index].name!] = (CGPoint(x: CGFloat(UIScreen.main.bounds.width / CGFloat(numberOfShapes) + spacing + (CGFloat(index) * textureWidth ) ), y: UIScreen.main.bounds.height / 2))
        coloredShapesPositions[coloredShapesNodes[index].name!] = (CGPoint(x: (Consts.Graphics.screenWidth / 11) * CGFloat((index + 1) * 3) , y: Consts.Graphics.screenHeight - (coloredShapesNodes[index].size.height / 2) - spacing))
        coloredShapesNodes[index].position = coloredShapesPositions[coloredShapesNodes[index].name!]!
        coloredShapesNodes[index].initialPos = coloredShapesNodes[index].position
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
    
    func createHole() {
        holeNode = dataSource.nextStaticNode(from: coloredShapesNodes)
//        holeNode.setup(pos: CGPoint(x: CGFloat(UIScreen.main.bounds.width / 2), y: UIScreen.main.bounds.height / 3))
        var position = CGPoint.zero
        position.x = (train.centralVagons[vagonIndex].position.x * 2) / 2.05
        position.y = (train.centralVagons[vagonIndex].position.y * 2) / 1.8
        holeNode.setup(pos: position)
        self.addChild(holeNode)
    }
    
    func shapeIsGoingToRightHole(nodeName: String) {
        var i = 0
        while i < coloredShapesNodes.count {
            if coloredShapesNodes[i].name == nodeName {
                let index = i
                coloredShapesNodes[index].moveTo(position: holeNode.position) { (value) in
                    if value {
                        debugPrint("finito il move to")
//                        debugPrint("coloreDHOleNodes.count \(self.coloredHoleNodes.count)")
                        self.coloredHoleNodes.append(self.coloredShapesNodes[index])
                        self.coloredHoleNodes.last?.state = .noBorder
//                        debugPrint("aggiunto coloreDHOleNodes.count \(self.coloredHoleNodes.count)")
                        self.coloredHoleNodes[self.vagonIndex].position = self.holeNode.position
//                        debugPrint("shapeRamaining \(self.numberShapesRemaining)")
                        debugPrint("Deleting a hole node")
                        self.holeNode.removeFromParent()
                        if self.numberShapesRemaining > 0 {
                            
                            debugPrint("I'm changing Shape")
                            self.coloredShapesNodes[index] = self.dataSource.nextMovingShapeNode()
                            self.createOneShape(index: index, numberOfShapes: self.setDifficulty())
                        } else if self.numberShapesRemaining > 0 - self.setDifficulty() + 1 {
                            debugPrint("I'm only removing a shape")
                            self.coloredFakeShapesNodes.append(self.dataSource.nextFakeShapeNode(from: self.coloredShapesNodes))
                            self.coloredFakeShapesNodes[self.coloredFakeShapesIndex].name = Consts.Id.RollerCoasterGameScreen.coloredShapeNode + "\(self.coloredFakeShapesIndex + 1 * 1000)"
                            self.coloredShapesPositions[self.coloredFakeShapesNodes[self.coloredFakeShapesIndex].name!] = self.coloredShapesInitialPositions
                            self.coloredFakeShapesNodes[self.coloredFakeShapesIndex].position = self.coloredShapesPositions[self.coloredFakeShapesNodes[self.coloredFakeShapesIndex].name!]!
                            self.coloredFakeShapesNodes[self.coloredFakeShapesIndex].initialPos = self.coloredFakeShapesNodes[self.coloredFakeShapesIndex].position 
                            
                            self.scene?.addChild(self.coloredFakeShapesNodes[self.coloredFakeShapesIndex])
                            self.coloredFakeShapesIndex += 1
                            self.coloredShapesNodes.remove(at: index)
                        } else {
                            self.coloredShapesNodes.remove(at: index)
                        }
                        
                        self.trainXPosition += self.train.headVagon.size.width + (self.train.headVagon.size.width / 100 * 5)
                        self.moveHolesWithTrain(pos: self.trainXPosition)
                        self.moveTrain() { (value) in
//                            debugPrint("I'm inside Moving Train")
                            if(value) {
                                debugPrint("shapeRamaining \(self.numberShapesRemaining)")
                                self.vagonIndex += 1
                                if self.coloredShapesNodes.count > 0{
                                    debugPrint("creating a hole node")
                                    self.createHole()
                                    self.allowUserMovements()
                                } else {
                                    self.endGame = true
                                }
                            }
                        }
                    }
                }
                numberShapesRemaining -= 1
                print("number of remaining shapes are \(numberShapesRemaining)")
            }
            i += 1
        }
    }
    
    func moveHolesWithTrain(pos: CGFloat) {
        
        for index in 0...coloredHoleNodes.count - 1 {
//            debugPrint("I'm moving the hole: \(index)")
            let path = UIBezierPath()
            path.move(to: coloredHoleNodes[index].position)
            path.addLine(to: CGPoint(x: pos - (train.centralVagons[index].size.width * CGFloat(index + 1)), y: coloredHoleNodes[index].position.y))
            
            
            
//                coloredHoleNodes[index].run(SKAction.follow(path.cgPath, asOffset: false, orientToPath: false, speed: train.trainSpeed))
            let vect = CGVector(dx: train.headVagon.size.width, dy: 0)
            coloredHoleNodes[index].run(SKAction.move(by: vect, duration: 1))
        }
    }
    
    func blockUserMovements(){
        for index in  0..<coloredShapesNodes.count {
            coloredShapesNodes[index].canMove = false
        }
        for index in 0..<coloredFakeShapesNodes.count {
            coloredFakeShapesNodes[index].canMove = false
        }
    }
    
    func allowUserMovements(){
        for index in  0..<coloredShapesNodes.count {
            coloredShapesNodes[index].canMove = true
        }
        for index in 0..<coloredFakeShapesNodes.count {
            coloredFakeShapesNodes[index].canMove = true
        }
    }
    
    
    func endGameFunction() {
        print("THE END FRA'")
        endGame = false
        trainXPosition += (train.tailVagon.size.width * 2)
        for index in 0...coloredFakeShapesNodes.count - 1 {
            coloredFakeShapesNodes[index].deScaling() { (value) in
                if value {
                    self.removeFromParent()
                }
            }
        }
        moveHolesWithTrain(pos: trainXPosition)
        moveTrain() { (value) in
            if(value) {
//                I should come back here
                Consts.endBackground = "roller coaster background"
                RootViewController.shared.skView.presentScene(GameEndScene())
            }
        }
        
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {
        var bodyA = contact.bodyA
        var bodyB = contact.bodyB
        if contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask {
            bodyA = contact.bodyB
            bodyB = contact.bodyA
//            debugPrint("A Better then B")
        }else{
//            debugPrint("B Better then A")
            //            nodeA = contact.bodyA.node
            //            nodeB = contact.bodyB.node
        }
        if bodyA.categoryBitMask == Consts.PhysicsMask.shapeNodes {
            if bodyB.categoryBitMask == Consts.PhysicsMask.holeNode {
//                debugPrint("scontro")
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
//            debugPrint("A Better then B")
        }else{
//            debugPrint("B Better then A")
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
            if coloredShapesNodes[index].canMove {
                coloredShapesNodes[index].position = coloredShapesPositions[coloredShapesNodes[index].name!]!
            }
        }
        for index in 0..<coloredFakeShapesIndex {
            coloredFakeShapesNodes[index].position = coloredShapesPositions[coloredFakeShapesNodes[index].name!]!
        }
    }
}
