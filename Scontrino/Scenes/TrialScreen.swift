//
//  TrialScreen.swift
//  Scontrino
//
//  Created by Alessio Perrotti on 23/05/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit
import CoreGraphics
import UIKit

class TrialScreen: GameScene, SKPhysicsContactDelegate  {
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func createSceneContents() {
        super.createSceneContents()
//        let cameraNode = SKCameraNode()
//        cameraNode.position = CGPoint(x: Consts.Graphics.screenWidth, y: Consts.Graphics.screenHeight)
//        self.addChild(cameraNode)
//        self.camera = cameraNode
        let backgroundNode = SKSpriteNode(imageNamed: "Path top")
        backgroundNode.zPosition = -10
        backgroundNode.size = CGSize(width: self.size.width, height: self.size.height)
        backgroundNode.position = CGPoint(x: size.width/2, y: size.height/2)
//        backgroundNode.frame =
        self.addChild(backgroundNode)
        var vagonPath = printingPath()
        var vagon = MovingNode(imageNamed: "red square")
        vagon.position = CGPoint(x: vagonPath.bounds.minX, y: vagonPath.bounds.minY)
//        vagon.position = CGPoint(x: 60, y: 60)
        vagon.zPosition = 100
        self.addChild(vagon)
        debugPrint(vagonPath.cgPath)
        let followAnim = SKAction.follow(vagonPath.cgPath, asOffset: true, orientToPath: true, speed: 100)
        let animSeq = SKAction.sequence([
            SKAction.wait(forDuration: 1),
            followAnim])
        
        vagon.run(animSeq)
    
        
        
    }
    
    func printingPath() -> UIBezierPath {
        //// General Declarations
        let bezierPath = UIBezierPath()
        bezierPath.move(to: self.position)
        bezierPath.addCurve(to: CGPoint(x: 299.5 / 2, y: 191.5 / 2), controlPoint1: CGPoint(x: 362.5 / 2, y: 183.5 / 2), controlPoint2: CGPoint(x: 299.5 / 2, y: 191.5 / 2))
        bezierPath.addCurve(to: CGPoint(x: 438.5 / 2, y: 536.5 / 2), controlPoint1: CGPoint(x: 299.5 / 2, y: 191.5 / 2), controlPoint2: CGPoint(x: 488.5 / 2, y: 416.5 / 2))
        bezierPath.addCurve(to: CGPoint(x: 559.5 / 2, y: 586.5 / 2), controlPoint1: CGPoint(x: 388.5 / 2, y: 656.5 / 2), controlPoint2: CGPoint(x: 559.5 / 2, y: 726.5 / 2))
        bezierPath.addCurve(to: CGPoint(x: 643.5 / 2, y: 191.5 / 2), controlPoint1: CGPoint(x: 559.5 / 2, y: 446.5 / 2), controlPoint2: CGPoint(x: 525.5 / 2, y: 150.5 / 2))
        bezierPath.addCurve(to: CGPoint(x: 845.5 / 2, y: 191.5 / 2), controlPoint1: CGPoint(x: 761.5 / 2, y: 232.5 / 2), controlPoint2: CGPoint(x: 845.5 / 2, y: 191.5 / 2))
        bezierPath.addCurve(to: CGPoint(x: 936.5 / 2, y: 282.5 / 2), controlPoint1: CGPoint(x: 845.5 / 2, y: 191.5 / 2), controlPoint2: CGPoint(x: 936.5 / 2, y: 189.5 / 2))
        bezierPath.addCurve(to: CGPoint(x: 997.5 / 2, y: 368.5 / 2), controlPoint1: CGPoint(x: 936.5 / 2, y: 375.5 / 2), controlPoint2: CGPoint(x: 997.5 / 2, y: 368.5 / 2))
        bezierPath.addLine(to: CGPoint(x: 1228.5 / 2, y: 368.5 / 2))
        bezierPath.addLine(to: CGPoint(x: 1248.5 / 2, y: 161.5 / 2))
        bezierPath.addLine(to: CGPoint(x: 1053.5 / 2, y: 101.5 / 2))
        bezierPath.addLine(to: CGPoint(x: 333.5 / 2, y: 51.5 / 2))
        bezierPath.addCurve(to: CGPoint(x: 116.5 / 2, y: 51.5 / 2), controlPoint1: CGPoint(x: 333.5 / 2, y: 51.5 / 2), controlPoint2: CGPoint(x: 180.5 / 2, y: 51.5 / 2))
        bezierPath.addCurve(to: CGPoint(x: 0.5 / 2, y: 161.5 / 2), controlPoint1: CGPoint(x: 52.5 / 2, y: 51.5 / 2), controlPoint2: CGPoint(x: -70.5 / 2, y: 52.5 / 2))
        bezierPath.addCurve(to: CGPoint(x: 87.5 / 2, y: 191.5 / 2), controlPoint1: CGPoint(x: 71.5 / 2, y: 270.5 / 2), controlPoint2: CGPoint(x: 87.5 / 2, y: 191.5 / 2))
        UIColor.black.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
//        context.translateBy(x: 0, y: 6)
//        context.scaleBy(x: 1, y: -1)
//        context.translateBy(x: 0, y: -pathTop.size.height)
//        context.draw(pathTop.cgImage!, in: CGRect(x: 0, y: 0, width: pathTop.size.width, height: pathTop.size.height))
//        context.restoreGState()
        return bezierPath
    }
}
