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
    var categorizationDie: GKShuffledDistribution!
    var animalsDie: GKShuffledDistribution!
    var fruitDie: GKShuffledDistribution!
    
    init() {
        initializeDice()
    }
    
    func nextMovingNode() -> MovingNode {
        return MovingNode(imageNamed: nextColor() + " " + nextShape())
    }
    
    //ALessio: added this one
    func nextMovingShapeNode() -> MovingShapeNode {
        return MovingShapeNode(imageNamed: nextColor() + " " + nextShape())
    }
    
    func nextFlagNode() -> SKSpriteNode {
        let cat = nextCategorization()
        let flagNode = SKSpriteNode(imageNamed: cat)
        flagNode.name = "flag" + " " + cat
        return flagNode
    }
    
    
    
    // This method returns a gray shape based on an array of moving nodes received as parameter
    func nextStaticNode(from movingNodes: [MovingShapeNode]) -> HoleNode { // changed from skspritenode in holenode and movingNode to MovingShapeNode
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
    
    func nextMovingContextNode(from logNodes: [LogNode]) -> MovingContextNode { // changed from skspritenode in holenode and movingNode to MovingShapeNode
        //ALESSIO: I'm Modifing this
        let index = GKRandomSource.sharedRandom().nextInt(upperBound: logNodes.count) //sistemare
        let node = logNodes[index]
        var res = ""
        
        switch node.nodeFlag.name {
        case "flag fruits":
            res  = nextFruit()
        case "flag animals":
            res = nextAnimal()
        default:
            res = nextAnimal()
        }
        
        let newNode = MovingContextNode(imageNamed: res)
        newNode.name = res
//        da cambiare
//        let shape = node.texture!.description.split(separator: "\'")[1].split(separator: " ").last!
//        let grayNode = MovingContextNode(imageNamed: "gray" + " " + shape)
//        debugPrint("Shape of the gray node is: \(shape)")
//        debugPrint("name of gray node is: \(node.name)")
//        grayNode.name = node.name
//        return grayNode
        
        //End of my changes, I commented the original lines
        
        //        let node = movingNodes[GKRandomSource.sharedRandom().nextInt(upperBound: movingNodes.count)]
        //        let shape = node.texture!.description.split(separator: "\'")[1].split(separator: " ").last!
        //
        //        return SKSpriteNode(imageNamed: "gray" + " " + shape)
        return newNode
    }

    func nextWord() -> String {
        return Consts.words[GKRandomSource.sharedRandom().nextInt(upperBound: Consts.words.count)]
    }
    
    // TODO: - initializeDice() should be updated to depend opon dificulty
    mutating func initializeDice() {
        colorsDie = GKShuffledDistribution(forDieWithSideCount: Consts.colors.count - 1)
        shapesDie = GKShuffledDistribution(forDieWithSideCount: Consts.shapes.count - 1)
        categorizationDie = GKShuffledDistribution(forDieWithSideCount: Consts.CategorizationGameScreen.categories.count)
        animalsDie = GKShuffledDistribution(forDieWithSideCount: Consts.CategorizationGameScreen.animals.count - 1)
        fruitDie = GKShuffledDistribution(forDieWithSideCount: Consts.CategorizationGameScreen.fruits.count - 1)
    }
    
    private func nextShape() -> String {
        return Consts.shapes[shapesDie.nextInt()]
    }
    
    private func nextColor() -> String {
        return Consts.colors[colorsDie.nextInt()]
    }
    
    private func nextCategorization() -> String {
        return Consts.CategorizationGameScreen.categories[categorizationDie.nextInt() - 1]
    }
    
    private func nextFruit() -> String {
        return Consts.CategorizationGameScreen.fruits[fruitDie.nextInt()]
    }
    
    private func nextAnimal() -> String {
        return Consts.CategorizationGameScreen.animals[animalsDie.nextInt()]
    }
}
