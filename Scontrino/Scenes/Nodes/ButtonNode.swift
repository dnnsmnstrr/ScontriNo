//
//  ButtonNode.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 26/04/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

protocol ButtonNodeDelegate: class {
    func buttonNodeTapped(_ sender: ButtonNode)
}

class ButtonNode: SKSpriteNode {
    weak var delegate: ButtonNodeDelegate?
    
    convenience init(imageNamed: String) {
        let texture = SKTexture(imageNamed: imageNamed)
        self.init(texture: texture)
        self.isUserInteractionEnabled = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.buttonNodeTapped(self)
    }
}
