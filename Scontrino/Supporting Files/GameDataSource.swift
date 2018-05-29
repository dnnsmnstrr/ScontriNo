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
    var clothesDie: GKShuffledDistribution!
    
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
        case "flag clothes":
            res = nextDress()
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

    func countMovingNode(from logNodes: [LogNode]) -> Int {
        var num = 0
        for index in 0...1{
            let node = logNodes[index]
            
            switch node.nodeFlag.name {
            case "flag fruits":
                num += Consts.FloatingLogsGameScreen.fruits.count
            case "flag animals":
                num += Consts.FloatingLogsGameScreen.animals.count
            case "flag clothes":
                num += Consts.FloatingLogsGameScreen.clothes.count
            default:
                num += 0
            }
            
        }
        return num
        
    }
    
    func nextWord() -> String {
//        return Consts.words[GKRandomSource.sharedRandom().nextInt(upperBound: Consts.words.count)]
        return "luna"
    }
    
    func getWord() -> String {
        let index = Int(arc4random_uniform(UInt32(Consts.testArray.count)))
        return Consts.testArray[index]
    }
    
    // TODO: - initializeDice() should be updated to depend opon dificulty
    mutating func initializeDice() {
        colorsDie = GKShuffledDistribution(forDieWithSideCount: Consts.colors.count - 1)
        shapesDie = GKShuffledDistribution(forDieWithSideCount: Consts.shapes.count - 1)
        categorizationDie = GKShuffledDistribution(forDieWithSideCount: Consts.FloatingLogsGameScreen.categories.count)
        animalsDie = GKShuffledDistribution(forDieWithSideCount: Consts.FloatingLogsGameScreen.animals.count)
        fruitDie = GKShuffledDistribution(forDieWithSideCount: Consts.FloatingLogsGameScreen.fruits.count)
        clothesDie = GKShuffledDistribution(forDieWithSideCount: Consts.FloatingLogsGameScreen.clothes.count)
    }
    
    private func nextShape() -> String {
        return Consts.shapes[shapesDie.nextInt()]
    }
    
    private func nextColor() -> String {
        return Consts.colors[colorsDie.nextInt()]
    }
    
    private func nextCategorization() -> String {
        return Consts.FloatingLogsGameScreen.categories[categorizationDie.nextInt() - 1]
    }
    
    private func nextFruit() -> String {
        return Consts.FloatingLogsGameScreen.fruits[fruitDie.nextInt() - 1]
    }
    
    private func nextAnimal() -> String {
        return Consts.FloatingLogsGameScreen.animals[animalsDie.nextInt() - 1]
    }
    
    private func nextDress() -> String {
        return Consts.FloatingLogsGameScreen.clothes[clothesDie.nextInt() - 1]
    }
}
