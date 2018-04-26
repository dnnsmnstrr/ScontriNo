//
//  ViewController.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 26/04/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

class ViewController: UIViewController {
    
    var skView: SKView {
        return view as! SKView
    }
    
    let scene = SKScene(size: CGSize(width: 375, height: 667))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view = SKView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        createSceneContent()
        skView.presentScene(scene)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createSceneContent() {
        scene.scaleMode = .aspectFit
        // Add additional scene contents here.
        let topNode = SKShapeNode(rect: CGRect(x: -100, y: -50, width: 200, height: 100))
        topNode.name = "topNode"
        topNode.fillColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        topNode.position = CGPoint(x: scene.size.width / 2, y: 3 * scene.size.height / 4)
        scene.addChild(topNode)
        
        let middleNode = SKShapeNode(rect: CGRect(x: -100, y: -50, width: 200, height: 100))
        middleNode.name = "middleNode"
        middleNode.fillColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        middleNode.position = CGPoint(x: scene.size.width / 2, y: 2 * scene.size.height / 4)
        scene.addChild(middleNode)
        
        let bottomNode = SKShapeNode(rect: CGRect(x: -100, y: -50, width: 200, height: 100))
        bottomNode.name = "bottomNode"
        bottomNode.fillColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        bottomNode.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 4)
        scene.addChild(bottomNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: scene)
            let nodes = scene.nodes(at: location)

            if let node = nodes.first {
                switch node.name {
                case "topNode":
                    skView.presentScene(GameScene())
                case "middleNode":
                    skView.presentScene(SpeechRecognitionScene())
                case "bottomNode":
                    skView.presentScene(FaceDetectionScene())
                default:
                    break
                }
                
            }
        }
    }


}

