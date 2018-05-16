//
//  GameDataSource.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 30/04/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import GameplayKit

struct GameDataSource {
    var colorsDie: GKShuffledDistribution!
    var shapesDie: GKShuffledDistribution!
    
    init() {
        initializeDice()
    }
    
    func nextMovingNode() -> MovingNode {
        return MovingNode(imageNamed: nextColor() + " " + nextShape())
    }
    
    // This method returns a gray shape based on an array of moving nodes received as parameter
    func nextStaticNode(from movingNodes: [MovingNode]) -> HoleNode { // changed from skspritenode in holenode
        //ALESSIO: I'm Modifing this
        let index = GKRandomSource.sharedRandom().nextInt(upperBound: movingNodes.count)
        let node = movingNodes[index]
        let shape = node.texture!.description.split(separator: "\'")[1].split(separator: " ").last!
        let grayNode = HoleNode(imageNamed: "gray" + " " + shape)
        debugPrint("Shape of the gray node is: \(shape)")
        debugPrint("name of gray node is: \(node.name)")
        grayNode.name = node.name
        return grayNode
        //End of my changes, I commented the original lines
        
//        let node = movingNodes[GKRandomSource.sharedRandom().nextInt(upperBound: movingNodes.count)]
//        let shape = node.texture!.description.split(separator: "\'")[1].split(separator: " ").last!
//
//        return SKSpriteNode(imageNamed: "gray" + " " + shape)
    }
    
    func nextWord() -> String {
        return Consts.words[GKRandomSource.sharedRandom().nextInt(upperBound: Consts.words.count)]
    }
    
    // TODO: - initializeDice() should be updated to depend opon dificulty
    mutating func initializeDice() {
        colorsDie = GKShuffledDistribution(forDieWithSideCount: Consts.colors.count - 1)
        shapesDie = GKShuffledDistribution(forDieWithSideCount: Consts.shapes.count - 1)
    }
    
    private func nextShape() -> String {
        return Consts.shapes[shapesDie.nextInt()]
    }
    
    private func nextColor() -> String {
        return Consts.colors[colorsDie.nextInt()]
    }
}
