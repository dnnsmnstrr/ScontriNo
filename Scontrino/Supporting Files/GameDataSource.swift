//
//  GameDataSource.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 30/04/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import GameplayKit

struct GameDataSource {
    static let shared = GameDataSource()
    
    func nextWord() -> String {
        return Consts.words[GKRandomSource.sharedRandom().nextInt(upperBound: Consts.words.count)]
    }
    
    func nextMovingNode() -> MovingNode {
        return MovingNode(imageNamed: Consts.shapes[GKRandomSource.sharedRandom().nextInt(upperBound: Consts.shapes.count)])
    }
}
