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

enum ButtonState {
    case normal, highlighted, disabled
}

class ButtonNode: SKSpriteNode {
    weak var delegate: ButtonNodeDelegate?
    var normalImageName: String!
    var highlightedImageName: String!
    var disabledImageName: String!
    var state = ButtonState.normal {
        willSet {
            switch newValue {
            case .normal:
                let texture = SKTexture(imageNamed: normalImageName)
                self.texture = texture
            case .highlighted:
                let texture = SKTexture(imageNamed: highlightedImageName)
                self.texture = texture
            case .disabled:
                let texture = SKTexture(imageNamed: disabledImageName)
                self.texture = texture
            }
        }
    }
    
    convenience init(imageNamed: String, for _: ButtonState) {
        let texture = SKTexture(imageNamed: imageNamed)
        self.init(texture: texture)
        self.normalImageName = imageNamed
        self.highlightedImageName = imageNamed
        self.disabledImageName = imageNamed
        self.isUserInteractionEnabled = true
    }
    
    func setTexture(imageNamed: String, for _: ButtonState) {
        highlightedImageName = imageNamed
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        state = .highlighted
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        state = .normal
        delegate?.buttonNodeTapped(self)
    }
}
