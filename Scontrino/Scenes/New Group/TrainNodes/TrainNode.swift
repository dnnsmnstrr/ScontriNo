//
//  TrainNode.swift
//  Scontrino
//
//  Created by Alessio Perrotti on 24/05/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

class TrainNode : SKNode {
    convenience init(numberOfVagons: Int) {
        self.init()
        
        let headVagon = HeadVagonNode(imageNamed: "frontal")
        
        let centralVagon = CentralVagonNode(imageNamed: "central")
        let tailVagon = TailVagonNode(imageNamed: "back")
        var pos: CGFloat = 0
//        self.setScale(0.2)
//        headVagon.setScale(0.2)
//        centralVagon.setScale(0.2)
//        tailVagon.setScale(0.2)
//        headVagon.position = CGPoint(x: pos, y: 0)
        pos = pos - headVagon.size.width
//        pos = pos - self.size.width
        centralVagon.position = CGPoint(x: pos, y: 0)
        pos = pos - centralVagon.size.width
        tailVagon.position = CGPoint(x: pos, y: 0)
        
        
        
        self.addChild(headVagon)
        self.addChild(centralVagon)
        self.addChild(tailVagon)
        
    }
    
}
