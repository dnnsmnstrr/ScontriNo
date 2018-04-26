//
//  ViewController.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 26/04/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit

class RootViewController: UIViewController {
    static let shared = RootViewController()
    
    var skView: SKView {
        return view as! SKView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view = SKView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        skView.presentScene(StartScreen())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

