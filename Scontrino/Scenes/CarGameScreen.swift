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
    var squarePosition: CGPoint!
    
    //shape arrays
    var coloredShapesNodes: [MovingNode] = []
    var coloredShapesPositions: [String: CGPoint] = [:]
    
    
    
    override init() {
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setDifficulty() -> Int {
        let difficulty = 3 //example for difficulty
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
        debugPrint("line 59")
//        let randomShape = arc4random_uniform(UInt32(Consts.shapes.count))
//        let randomNode = MovingNode(imageNamed: (Consts.shapes[Int(randomShape)]))
//        debugPrint(" randomNode:\(randomNode)")
        coloredShapesNodes.append(GameDataSource.shared.nextMovingNode())
        debugPrint(" coloredShapesNodes:\(coloredShapesNodes[0])")
        debugPrint(" coloredShapesNodes.count:\(coloredShapesNodes.count)")
        
        
    }
    
    override func createSceneContents() {
        super.createSceneContents()
        let shapeNumber = setDifficulty()
        let spacing: CGFloat = 10
        for index in  0..<shapeNumber{
            createShape()
            debugPrint("line 48 index:\(index)")
            debugPrint(" coloredShapesNodes.count:\(coloredShapesNodes.count)")
            coloredShapesNodes[index].name = Consts.Id.CarGameScreen.coloredShapeNode + "\(index)"
            coloredShapesPositions[coloredShapesNodes[index].name!] = (CGPoint(x: CGFloat(UIScreen.main.bounds.width / CGFloat(shapeNumber) + spacing + (CGFloat(index) * coloredShapesNodes[index].size.width ) ), y: UIScreen.main.bounds.height / 2))
            coloredShapesNodes[index].position = coloredShapesPositions[coloredShapesNodes[index].name!]!
            self.addChild(coloredShapesNodes[index])
        }
        squarePosition = CGPoint(x: CGFloat(UIScreen.main.bounds.width / 2), y: UIScreen.main.bounds.height / 2)
        squareNode.position = squarePosition
//        self.addChild(squareNode)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
//        squareNode.position = squarePosition
//        coloredShapesNodes[0].position = squarePosition
        for index in  0..<coloredShapesNodes.count {
            coloredShapesNodes[index].position = coloredShapesPositions[coloredShapesNodes[index].name!]!
        }
    }
}
