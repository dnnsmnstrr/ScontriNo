//
//  CarGameScreen.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 26/04/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//
//MARK: add end game, add score, decrease size of moving node physics body

import SpriteKit

class CarGameScreen: GameScene, SKPhysicsContactDelegate {
    let dataSource = GameDataSource()
    
    var holeNode: HoleNode!
    let textureWidth = MovingShapeNode(imageNamed: "red square").size.width
    //shape arrays
    var coloredShapesNodes: [MovingShapeNode] = []
    var coloredShapesPositions: [String: CGPoint] = [:]
    var coloredShapesInitialPositions: [String: CGPoint] = [:] //using a different type
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func createSceneContents() {
        super.createSceneContents()
        self.physicsWorld.contactDelegate = self
        createShapes()
        createHole()
    }
    
    func createShapes() {
        let numberOfShapes = setDifficulty()
        for index in  0..<numberOfShapes{
            coloredShapesNodes.append(dataSource.nextMovingShapeNode())
            createOneShape(index: index, numberOfShapes: numberOfShapes)
        }
    }
    
    func createOneShape(index: Int, numberOfShapes: Int){
        let spacing: CGFloat = 10
        coloredShapesNodes[index].name = Consts.Id.CarGameScreen.coloredShapeNode + "\(index)"
        coloredShapesInitialPositions[coloredShapesNodes[index].name!] = (CGPoint(x: CGFloat(UIScreen.main.bounds.width / CGFloat(numberOfShapes) + spacing + (CGFloat(index) * textureWidth ) ), y: UIScreen.main.bounds.height / 2))
        coloredShapesPositions[coloredShapesNodes[index].name!] = coloredShapesInitialPositions[coloredShapesNodes[index].name!]
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
        holeNode.setup(pos: CGPoint(x: CGFloat(UIScreen.main.bounds.width / 2), y: UIScreen.main.bounds.height / 3))
        self.addChild(holeNode)
    }
    
    func controlIfRightShapeInHole(nodeName: String) {
        var i = 0
        while i < coloredShapesNodes.count {
            if coloredShapesNodes[i].name == nodeName {
                debugPrint("new Shape")
                debugPrint("i:\(i)")
                let index = i
                let createNewShapeNode = SKAction.run {
//                    self.coloredShapesNodes[index].removeFromParent()
                    self.coloredShapesNodes[index] = self.dataSource.nextMovingShapeNode()
                    self.createOneShape(index: index, numberOfShapes: self.setDifficulty())
                }
                coloredShapesNodes[i].isFitting = true
                let path = UIBezierPath()
                path.move(to: coloredShapesNodes[i].position)
                path.addLine(to: holeNode.position)
                
                let fillInHoleAnimation = SKAction.sequence([
                    SKAction.follow(path.cgPath, asOffset: false, orientToPath: false, speed: 100),
                    SKAction.removeFromParent(),
                    createNewShapeNode
                    ])
                coloredShapesNodes[i].run(fillInHoleAnimation)
                
                let createNewHole = SKAction.run{
                    self.createHole()
                }
                
                let changeHoleAnimation = SKAction.sequence([
                    SKAction.wait(forDuration: fillInHoleAnimation.duration),
                    SKAction.wait(forDuration: 0.2),
                    SKAction.removeFromParent(),
                    createNewHole
                    ])

                self.holeNode.run(changeHoleAnimation)
            
            }
            i += 1
        }
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
        
        for index in  0..<coloredShapesNodes.count {
            if !coloredShapesNodes[index].isFitting{
                coloredShapesNodes[index].position = coloredShapesPositions[coloredShapesNodes[index].name!]!
            }
        }
    }
}
