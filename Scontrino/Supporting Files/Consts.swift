//
//  Consts.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 26/04/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import UIKit

struct Consts {
    static let words = [
        "luna",
        "stella"
    ]
    static let shapes = [
        "triangle",
        "star",
        "circle",
        "square",
        "polygon",
        "rounded"
    ]
    static let colors = [
        "blue",
        "green",
        "orange",
        "red",
        "teal blue",
        "yellow"
    ]
    
    
    struct CategorizationGameScreen {
        static let categories = [
            "animals",
            "fruits"
        ]
        static let animals = [
            "bear",
            "duck"
        ]
        static let fruits = [
            "apple",
            "orange"
        ]
    }
    struct Graphics {
        static let screenWidth = UIScreen.main.bounds.width
        static let screenHeight = UIScreen.main.bounds.height
    }
    struct Id {
        struct CarGameScreen {
            static let coloredShapeNode = "100-"
        }
    }
    enum PhysicsMask {
        static let shapeNodes: UInt32 = 0x1 << 1 //2
        static let holeNode: UInt32 = 0x1 << 2 // 4
    }
}
