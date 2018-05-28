//
//  Train.swift
//  Scontrino
//
//  Created by Alessio Perrotti on 24/05/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

struct Train {
    var headVagon: HeadVagonNode
    var centralVagons: [CentralVagonNode] = []
    var tailVagon: TailVagonNode
    var trainSpeed: CGFloat = 600
    
    init() {
        headVagon = HeadVagonNode(imageNamed: "frontal")
        tailVagon = TailVagonNode(imageNamed: "back")
//        instanziateCentralVagons(numberOfShapes: numberOfShapes)
    }
    
    mutating func setupTrain(numberOfShapes: Int) {
        headVagon.setup()
        var vagonXPosition = headVagon.position.x - (headVagon.size.width / 2)
        debugPrint(numberOfShapes)
        for index in 0...numberOfShapes {
            centralVagons.append(CentralVagonNode(imageNamed: "central"))
            centralVagons[index].setup(posX: vagonXPosition)
            vagonXPosition -= centralVagons[index].size.width
        }
        tailVagon.setup(posX: vagonXPosition)
        
    }
    
    mutating func instanziateCentralVagons(numberOfShapes: Int) {
        for index in 0...Consts.shapes.count - 1 {
            
        }
    }
    
    func moveTrain(pos: CGFloat, onComplete: @escaping (Bool) -> Void) -> TimeInterval {
        var count = 0
        let duration = moveVagon(vagon: headVagon, pos: pos) { (value) in
            if(value) {
                count += 1
            }
        }
        
        for index in 0...centralVagons.count - 1 {
//            pos -= centralVagons[index].size.width
            moveVagon(vagon: centralVagons[index], pos: pos - (centralVagons[index].size.width * CGFloat(index + 1))) { (value) in
                if(value) {
                    count += 1
                    if count == self.centralVagons.count {
                        onComplete(true)
                    }
                }
            }
        }
        return duration
    }
    
    func moveVagon(vagon: SKSpriteNode, pos: CGFloat, onComplete: @escaping (Bool) -> Void) -> TimeInterval{
        let path = UIBezierPath()
        path.move(to: vagon.position)
        path.addLine(to: CGPoint(x: pos, y: vagon.position.y))
        
        let anim = SKAction.run {
            onComplete(true)
        }
        
        let fillInHoleAnimation = SKAction.sequence([
            SKAction.follow(path.cgPath, asOffset: false, orientToPath: false, speed: trainSpeed),
            anim
//            SKAction.removeFromParent(),
            ])
        debugPrint("fill in Hole anim: \(fillInHoleAnimation.duration)")
        vagon.run(fillInHoleAnimation)
        return fillInHoleAnimation.duration
    }
    
    
}
