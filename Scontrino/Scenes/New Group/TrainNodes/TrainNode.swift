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
        var pos:CGFloat = 400
        headVagon.position = CGPoint(x: pos, y: headVagon.size.height)
        pos = pos - headVagon.size.width
        centralVagon.position = CGPoint(x: pos, y: centralVagon.size.height)
        pos = pos - centralVagon.size.width
        tailVagon.position = CGPoint(x: pos, y: tailVagon.size.height)
        
        self.addChild(headVagon)
        self.addChild(centralVagon)
        self.addChild(tailVagon)
        
    }
    
}
