//
//  SwitchNode.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 29/05/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

protocol SwitchNodeDelegate: class {
    func switchNodeTapped(_ sender: SwitchNode)
}

class SwitchNode: SKSpriteNode {
    weak var delegate: SwitchNodeDelegate?
    var isOn: Bool!
    var onImage: String!
    var offImage: String!
    
    convenience init(isOn: Bool, onImage: String, offImage: String) {
        if isOn {
            let onTexture = SKTexture(imageNamed: onImage)
            self.init(texture: onTexture)
        } else {
            let offTexture = SKTexture(imageNamed: offImage)
            self.init(texture: offTexture)
        }
        self.isOn = isOn
        self.onImage = onImage
        self.offImage = offImage
        self.isUserInteractionEnabled = true
    }
    
    func setOn(_ isOn: Bool) {
        if isOn {
            let offTexture = SKTexture(imageNamed: self.offImage)
            self.texture = offTexture
        } else {
            let onTexture = SKTexture(imageNamed: self.onImage)
            self.texture = onTexture
        }
        self.isOn = !isOn
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        setOn(self.isOn)
        delegate?.switchNodeTapped(self)
    }
}
