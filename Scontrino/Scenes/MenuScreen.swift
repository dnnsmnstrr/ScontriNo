//
//  MenuScreen.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 26/04/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit
import Speech

class MenuScreen: SKScene, ButtonNodeDelegate, UIPageViewControllerDelegate {
    var touchLocation: CGPoint!
    
    override init() {
        super.init(size: Consts.Graphics.screenResolution)
        createSceneContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createSceneContent() {
        let backgroundNode = SKSpriteNode(imageNamed: "start screen background")
        backgroundNode.setScale(Consts.Graphics.scale)
        backgroundNode.position = CGPoint(x: Consts.Graphics.screenWidth / 2, y: Consts.Graphics.screenHeight / 2)
        self.addChild(backgroundNode)
        
        let backButton = ButtonNode(imageNamed: "back button normal", for: .normal)
        backButton.delegate = self
        backButton.setTexture(imageNamed: "back button highlighted", for: .highlighted)
        backButton.name = "StartScreen"
        backButton.setScale(Consts.Graphics.scale)
        backButton.position = CGPoint(x: 0.1 * Consts.Graphics.screenWidth, y: 0.9 * Consts.Graphics.screenHeight)
        self.addChild(backButton)
        
        let ferrisWheelNode = ButtonNode(imageNamed: "ferris wheel icon", for: .normal)
        ferrisWheelNode.delegate = self
        ferrisWheelNode.name = "FerrisWheelGameScreen"
        ferrisWheelNode.setScale(Consts.Graphics.scale)
        ferrisWheelNode.position = CGPoint(x: Consts.Graphics.screenWidth / 2, y: Consts.Graphics.screenHeight / 2)
        self.addChild(ferrisWheelNode)
        
        let rollerCoasterNode = ButtonNode(imageNamed: "roller coaster icon", for: .normal)
        rollerCoasterNode.delegate = self
        rollerCoasterNode.name = "RollerCoasterGameScreen"
        rollerCoasterNode.setScale(Consts.Graphics.scale)
        rollerCoasterNode.position = CGPoint(x: Consts.Graphics.screenWidth / 6, y: Consts.Graphics.screenHeight / 2 - (ferrisWheelNode.size.height - rollerCoasterNode.size.height) / 2)
        self.addChild(rollerCoasterNode)
        
        let floatingLogsNode = ButtonNode(imageNamed: "floating logs icon", for: .normal)
        floatingLogsNode.delegate = self
        floatingLogsNode.name = "FloatingLogsGameScreen"
        floatingLogsNode.setScale(Consts.Graphics.scale)
        floatingLogsNode.position = CGPoint(x: 5 * Consts.Graphics.screenWidth / 6, y: Consts.Graphics.screenHeight / 2 - (ferrisWheelNode.size.height - floatingLogsNode.size.height) / 2)
        self.addChild(floatingLogsNode)
        
//        let trialNode = ButtonNode(imageNamed: "green star", for: .normal)
//        trialNode.delegate = self
//        trialNode.name = "TrialScreen"
//        trialNode.position = CGPoint(x: self.size.width / 2, y: 1.5 * self.size.height / 8)
//        self.addChild(trialNode)
    }
    
    func buttonNodeTapped(_ sender: ButtonNode) {
        if let name = sender.name {
            switch name {
            case "StartScreen":
                RootViewController.shared.skView.presentScene(StartScreen())
            case "RollerCoasterGameScreen":
                RootViewController.shared.skView.presentScene(RollerCoasterGameScreen())
            case "FloatingLogsGameScreen":
                RootViewController.shared.skView.presentScene(FloatingLogsGameScreen())
            case "FerrisWheelGameScreen":
                checkForAuthorizations()
//            case "TrialScreen":
//                RootViewController.shared.skView.presentScene(TrialScreen())
            default:
                break
            }
        }
    }
    
    var firstTime = true
    
    func checkForAuthorizations() {
        checkSpeechRecognizerAuthorization()
        checkMicrophoneAuthorization()
        AVCaptureDevice.requestAccess(for: .audio) { granted in
            DispatchQueue.main.async {
                if Consts.FerrisWheelAuthorizationStatus.speechRecognizerAuth && Consts.FerrisWheelAuthorizationStatus.microphoneAuth {
                    RootViewController.shared.skView.presentScene(FerrisWheelGameScreen())
                } else {
                    if self.firstTime {
                        self.firstTime = false
                    } else if !self.firstTime {
                        self.alertSettings(title: "Microphone and Speech Recognition permissions", message: "In order to play the game, please go to the app settings and give permissions to the microphone and speech recognition usage.")
                    }
                }
            }
        }
    }
    
    func alertSettings(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { (action: UIAlertAction!) in
            let url = URL(string:UIApplicationOpenSettingsURLString)
            _ =  UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            alert.dismiss(animated: true, completion: nil)
            
        }))
        view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func waitForDecision(info: String) {
        AVCaptureDevice.requestAccess(for: .audio) { granted in
            DispatchQueue.main.async {
                if info == "speech" {
                    self.checkSpeechRecognizerAuthorization()
                } else if info == "mic" {
                    self.checkMicrophoneAuthorization()
                }
            }
        }
    }
    
    func checkSpeechRecognizerAuthorization() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    Consts.FerrisWheelAuthorizationStatus.speechRecognizerAuth = true
                case .denied:
                    Consts.FerrisWheelAuthorizationStatus.speechRecognizerAuth = false
                case .notDetermined:
                    self.waitForDecision(info: "speech")
                default: break
                }
            }
        }
    }
    
    func checkMicrophoneAuthorization() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: .audio)
        switch authStatus {
            
        case .authorized:
            Consts.FerrisWheelAuthorizationStatus.microphoneAuth = true
        case .denied:
            Consts.FerrisWheelAuthorizationStatus.speechRecognizerAuth = false
        case .notDetermined:
            waitForDecision(info: "mic")
        default: break
        }
    }
}
