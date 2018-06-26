//
//  MovingShapeNode.swift
//  Scontrino
//
//  Created by Alessio Perrotti on 17/05/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

enum ShapeState {
    case normal, highlighted, noBorder
}

class MovingShapeNode: MovingNode {
    var isInTheRightHole = false
    var canMove = true
    var initialPos = CGPoint.zero
    var normalImageName: String!
    var highlightedImageName: String!
    var noBorderImageName: String!
    var state = ShapeState.normal {
        willSet {
            switch newValue {
            case .normal:
                let texture = SKTexture(imageNamed: normalImageName)
                self.texture = texture
            case .highlighted:
                let texture = SKTexture(imageNamed: highlightedImageName)
                self.texture = texture
            case .noBorder:
                let texture = SKTexture(imageNamed: noBorderImageName)
                self.texture = texture
            }
        }
    }
    
    convenience init(imageNamed: String) {
        let texture = SKTexture(imageNamed: imageNamed)
        self.init(texture: texture)
        self.normalImageName = imageNamed
        let shapeName = texture.description.split(separator: "\'")[1].split(separator: " ").first!
        self.highlightedImageName = shapeName.description + " highlighted"
        debugPrint(highlightedImageName)
        self.noBorderImageName = shapeName.description
        self.zPosition = Consts.RollerCoasterGameScreen.zPositions.shapes
        self.setScale(Consts.Graphics.scale)
        let mySize = self.size
        var texSize = texture.size()
        texSize.width = (texSize.width) * 0.65
        texSize.height = (texSize.height) * 0.65
        self.isHidden = true
        self.isUserInteractionEnabled = true
        self.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "square normal"), size: texSize)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = Consts.PhysicsMask.shapeNodes
        self.physicsBody?.contactTestBitMask = Consts.PhysicsMask.holeNode
        self.physicsBody?.collisionBitMask = 0
        let isVisible = SKAction.run {
            self.isHidden = false
        }
        let presentationAnimation = SKAction.sequence([SKAction.scale(to: 0, duration: 0),
//            SKAction.scale(to: CGSize.zero, duration: 0),
                                                       isVisible,
                                                       SKAction.scale(to: 1, duration: 0.5)
//                                                       SKAction.scale(to: mySize, duration: 0.5)
            ])
        self.run(presentationAnimation)
    }
    
    func moveTo(position: CGPoint, onComplete: @escaping (Bool) -> Void) -> SKAction {
        
        canMove = false
        let path = UIBezierPath()
        path.move(to: self.position)
        path.addLine(to: position)
        
        let completedAction = SKAction.run {
            onComplete(true)
        }
        
        let fillInHoleAnimation = SKAction.sequence([
            SKAction.follow(path.cgPath, asOffset: false, orientToPath: false, speed: Consts.RollerCoasterGameScreen.speeds.shapeFittingInHole),
            completedAction
            //            SKAction.removeFromParent(),
            ])
        self.run(fillInHoleAnimation)
        return fillInHoleAnimation
    }
    
    
    func deScaling(onComplete: @escaping (Bool) -> Void){
        
        let completedAction = SKAction.run {
            onComplete(true)
        }
        let scalingAnimation = SKAction.sequence([
            SKAction.scale(to: CGSize.zero, duration: 0.5),
            completedAction
            ])
        self.run(scalingAnimation)
    }
    
    func returnInInitialPosition(onComplete: @escaping (Bool) -> Void) {
        if let scene = self.scene as? RollerCoasterGameScreen {
            let completedAction = SKAction.run {
                onComplete(true)
            }
            let path = UIBezierPath()
            path.move(to: self.position)
            path.addLine(to: scene.coloredShapesInitialPositions)
            let returnAnim = SKAction.sequence([
                SKAction.follow(path.cgPath, asOffset: false, orientToPath: false, speed: Consts.RollerCoasterGameScreen.speeds.shapeReturning),
                completedAction
                ])
            self.run(returnAnim)
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        state = .highlighted
        if let scene = self.scene as? RollerCoasterGameScreen {
            if canMove {
                scene.coloredShapesInitialPositions = scene.coloredShapesPositions[self.name!]!
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if canMove {
            if let touch = touches.first {
                if let scene = self.scene as? RollerCoasterGameScreen {
                    let location = touch.location(in: scene)
//                    let locationInParent = self.convert(location, to: self.parent!)
//                    let isTouchInside = self.contains(locationInParent)
//                    if isTouchInside {
//                        state = .highlighted
//                    } else {
//                        state = .normal
//                    }
                    scene.coloredShapesPositions[self.name!] = location
                }
            }
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard state == .highlighted else { return }
        state = .normal
        if canMove {
            if let scene = self.scene as? RollerCoasterGameScreen {
                if isInTheRightHole == false {
                    //                scene.changeUserAbleToMove()
                    self.returnInInitialPosition() { value in
                        scene.coloredShapesPositions[self.name!] = self.initialPos
                        //                    scene.changeUserAbleToMove()
                    }
                    //                scene.coloredShapesPositions[self.name!] = scene.coloredShapesInitialPositions
                }
                else {
                    scene.blockUserMovements()
                    scene.shapeIsGoingToRightHole(nodeName: self.name!)
                    //                scene.controlIfRightShapeInHole(nodeName: self.name!)
                }
            }
        }
        
    }
}
