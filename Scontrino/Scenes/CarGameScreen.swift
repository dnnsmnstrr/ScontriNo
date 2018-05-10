//
//  CarGameScreen.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 26/04/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

class CarGameScreen: GameScene {
    
    let squareNode = MovingNode(imageNamed: "red square")
    
    var holePosition: CGPoint!
    
    var holeNode = GameDataSource.shared.nextStaticNode()
    
    //shape arrays
    var coloredShapesNodes: [MovingNode] = []
    var coloredShapesPositions: [String: CGPoint] = [:]
    var coloredShapesInitialPositions: [String: CGPoint] = [:] //using a different type
    
    
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
    
    func createShape() {
//        debugPrint("line 59")
//        let randomShape = arc4random_uniform(UInt32(Consts.shapes.count))
//        let randomNode = MovingNode(imageNamed: (Consts.shapes[Int(randomShape)]))
//        debugPrint(" randomNode:\(randomNode)")
        coloredShapesNodes.append(GameDataSource.shared.nextMovingNode())
//        debugPrint(" coloredShapesNodes:\(coloredShapesNodes[0])")
//        debugPrint(" coloredShapesNodes.count:\(coloredShapesNodes.count)")
        
        
    }
    
    override func createSceneContents() {
        super.createSceneContents()
        self.view?.showsPhysics = true
//        mainView.showsPhysics = true
//        mainView.ignoresSiblingOrder = true
        let shapeNumber = setDifficulty()
        let spacing: CGFloat = 10
        for index in  0..<shapeNumber{
            createShape()
//            debugPrint("line 48 index:\(index)")
//            debugPrint(" coloredShapesNodes.count:\(coloredShapesNodes.count)")
            coloredShapesNodes[index].name = Consts.Id.CarGameScreen.coloredShapeNode + "\(index)"
            coloredShapesInitialPositions[coloredShapesNodes[index].name!] = (CGPoint(x: CGFloat(UIScreen.main.bounds.width / CGFloat(shapeNumber) + spacing + (CGFloat(index) * coloredShapesNodes[index].size.width ) ), y: UIScreen.main.bounds.height / 2))
            coloredShapesPositions[coloredShapesNodes[index].name!] = coloredShapesInitialPositions[coloredShapesNodes[index].name!]
            coloredShapesNodes[index].position = coloredShapesPositions[coloredShapesNodes[index].name!]!
            if let texture = coloredShapesNodes[index].texture {
                var texSize = texture.size()
                coloredShapesNodes[index].physicsBody = SKPhysicsBody(texture: texture, size: texSize)
                coloredShapesNodes[index].physicsBody?.affectedByGravity = false
//                debugPrint("line 88")
            }
            
            
            self.addChild(coloredShapesNodes[index])
        }
        createHole()
        
        
    }
    
    func createHole(){
        holePosition = CGPoint(x: CGFloat(UIScreen.main.bounds.width / 2), y: UIScreen.main.bounds.height / 3)
        holeNode.position = holePosition
        holeNode.zPosition = -1
        if let texture = holeNode.texture {
            var texSize = texture.size()
            debugPrint("texsize wid: \(texSize.width)")
            texSize.width = (texSize.width) * 0.33
            debugPrint("texsize wid: \(texSize.width)")
            texSize.height = (texSize.height) * 0.33
            holeNode.physicsBody = SKPhysicsBody(texture: texture, size: texSize)
//            holeNode.physicsBody = SKPhysicsBody(rectangleOf: texSize)
//            holeNode.physicsBody = SKPhysicsBody(rectangleOf: texSize, center: holeNode.position)
            holeNode.physicsBody?.affectedByGravity = false
            debugPrint("line 96")
        }
        
        
        self.addChild(holeNode)
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
//        squareNode.position = squarePosition
//        coloredShapesNodes[0].position = squarePosition
        for index in  0..<coloredShapesNodes.count {
            coloredShapesNodes[index].position = coloredShapesPositions[coloredShapesNodes[index].name!]!
        }
    }
}
