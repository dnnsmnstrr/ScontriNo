//
//  MonkeyPlayer.swift
//  Scontrino
//
//  Created by Antonio Ragosta on 22/06/18.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import Foundation
import SpriteKit

class MonkeyPlayer: SKSpriteNode {
    
    var textureCelebrating: [SKTexture] = []
    
    var textureFire: [SKTexture] = []
    
//    // Manual Movement
//    var destination = CGPoint()
//    let velocity: CGFloat = 1000
    
    
    init() {
        self.textureCelebrating = Consts.allTextures
        
        
        
        super.init(texture: textureCelebrating[0], color: .clear, size: CGSize(width: 1000, height: 600))
        self.name = "player"
        self.zPosition = 1000
        self.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.minY + 200)
//        self.anchorPoint = CGPoint(x: 0.5, y: 0.0)
//        let animation = SKAction.animate(with: textureCelebrating, timePerFrame: (1.0 / 12.0))
//        self.run(SKAction.repeatForever(animation))
        animate()
//        self.name = "player"
    }
    
    
    func setup(view: SKView) {
 
        self.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.minY)
//            Consts.Graphics.screenWidth / 2, y: 0)
//            UIScreen.main.bounds.midX, y: UIScreen.main.bounds.minY)
        let animation = SKAction.animate(with: textureCelebrating, timePerFrame: (1.0 / 5.0))
        self.run(SKAction.repeatForever(animation))
        
    }
    
    
    func animate() {
        
        let animationMonkeyCelebrate = SKAction.sequence([
            SKAction.animate(with: textureCelebrating, timePerFrame: (1.0 / 12.0)),
            SKAction.run {
                RootViewController.shared.skView.presentScene(MenuScreen())
            }
            ])
        self.run(animationMonkeyCelebrate)
        
    }
    
    // Swift requires this initializer
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
