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
    func nextStaticNode(from movingNodes: [MovingNode]) -> SKSpriteNode {
        let node = movingNodes[GKRandomSource.sharedRandom().nextInt(upperBound: movingNodes.count)]
        let shape = node.texture!.description.split(separator: "\'")[1].split(separator: " ").last!
        return SKSpriteNode(imageNamed: "gray" + " " + shape)
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
