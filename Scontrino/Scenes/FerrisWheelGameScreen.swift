//
//  FerrisWheelGameScreen.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 26/04/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//
//

import UIKit
import SpriteKit
import AVFoundation
import Vision
import Speech

class FerrisWheelGameScreen: GameScene, SFSpeechRecognizerDelegate {
    
    let dataSource = GameDataSource()
    
    
    //speech
    var currentWordOnScreen: String!
    
    
    let recordingNode = SKSpriteNode(imageNamed: "recording off")
    var recognizedSentence = ""
    var recognizedWords = [Substring]()
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private var audio = AVAudioEngine()
    var listen = true {
        didSet {
            if !listen {
                self.audio.stop()
                recognitionRequest?.endAudio()
                self.recognitionRequest = nil
                self.recognitionTask = nil
            }
        }
    }
    
    //camera & ui
    let cameraNode = SKCameraNode()
    
    var ferrisWheel: SKSpriteNode!
    private var cabins: [CabinNode] = []
    private var currentWords: [String] = []
    
    var startTime: TimeInterval?
    var start: CGPoint?
    var end: CGPoint?
    var wheelSpeed: CGFloat = 1000
    var zoomedIn: Bool = false
    var zoomPoint: CGFloat?
    
    
    
    override func createSceneContents() {
        super.createSceneContents()
        
        //camera
        cameraNode.position = CGPoint(x: self.size.width / 2,y: self.size.height / 2)
        self.addChild(cameraNode)
        self.camera = cameraNode
        
        
        //create ferris wheel
        
        ferrisWheel = SKSpriteNode.init(texture: SKTexture(imageNamed: "Wheel"))
        ferrisWheel.name = "wheel"
        ferrisWheel.zPosition = 2
        ferrisWheel.anchorPoint = CGPoint(x: 0.5, y: 0.5) // default
        ferrisWheel.position = CGPoint(x: size.width/2, y: size.height/1.6)
        ferrisWheel.size = CGSize(width: size.height/1.2, height: size.height/1.2)
        zoomPoint = ferrisWheel.frame.minY - size.height/14
        ferrisWheel.physicsBody = SKPhysicsBody(circleOfRadius: max((ferrisWheel.size.width) / 2,
                                                                    (ferrisWheel.size.height) / 2))
        ferrisWheel.zRotation = CGFloat.pi / 2
        ferrisWheel.physicsBody?.pinned = true
        ferrisWheel.physicsBody?.angularDamping = 0.1
        
        self.addChild(ferrisWheel)
        
        
        //place cabins
        let radius = ferrisWheel.size.width/2 - 2
        for i in 1...6 {
            
            let newCabin = CabinNode.init(imageNamed: "cabin body")
            
            newCabin.zPosition = 3
            newCabin.size = CGSize(width: ferrisWheel.size.width/5, height: ferrisWheel.size.height/5)

            //trigonometric functions to calculate cabin position on the circumference of the wheel
            let currentX = radius*CGFloat(cosf(2*Float.pi*Float(i)/6))+ferrisWheel.frame.midX
            let currentY = radius*CGFloat(sinf(2*Float.pi*Float(i)/6))+ferrisWheel.frame.midY

            newCabin.position = CGPoint(x: currentX, y: currentY-newCabin.size.height/2)
            newCabin.physicsBody = SKPhysicsBody(circleOfRadius: newCabin.size.height/2)
            newCabin.physicsBody?.angularDamping = 30
            newCabin.physicsBody?.mass = 2
            //resize doors according to current cabin size
            newCabin.leftDoor?.size = CGSize(width: newCabin.size.width/3.1, height: newCabin.size.height/1.3)
            newCabin.rightDoor?.size = CGSize(width: newCabin.size.width/3.1, height: newCabin.size.height/1.3)
            newCabin.occupant?.size = CGSize(width: newCabin.size.width/2, height: newCabin.size.height/2)
            
            //occupant
            var newOccupant: String = dataSource.getWord()
            currentWords.append(newOccupant)
            newCabin.occupant?.texture = SKTexture(imageNamed: newOccupant)
            
            self.addChild(newCabin)
            cabins.append(newCabin)
            
            let joint = SKPhysicsJointPin.joint(withBodyA: ferrisWheel.physicsBody! , bodyB: newCabin.physicsBody!, anchor: CGPoint(x: currentX, y: currentY))
            //limit joint angles?
            //            joint.shouldEnableLimits = true
            //            joint.lowerAngleLimit = -0.3
            //            joint.upperAngleLimit = 0.3
            self.physicsWorld.add(joint)
            
        }
        
        let captionNode = SKLabelNode(text: currentWordOnScreen)
        captionNode.fontSize = 36
        captionNode.fontColor = .black
        captionNode.name = "caption"
        captionNode.position = CGPoint(x: ferrisWheel.frame.midX, y: ferrisWheel.frame.minY-10)
        
        startGame()
        //start the recording process
        checkAuthorization()
        
    }
    
    //touch handling
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        self.start = touch.location(in: self)
        self.startTime = touch.timestamp
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        self.end = touch.location(in: self)
        var dx = ((self.end?.x)! - (self.start?.x)!)
        var dy = ((self.end?.y)! - (self.start?.y)!)
        
        let magnitude:CGFloat = sqrt(dx*dx+dy*dy)
        print(magnitude)
        if magnitude >= 25 {
            let dt:CGFloat = CGFloat(touch.timestamp - self.startTime!)
            if dt > 0.1 {
                wheelSpeed = magnitude / dt
                dx = dx / magnitude
                dy = dy / magnitude
                print("dx: \(dx), dy: \(dy), speed: \(wheelSpeed) ")
                
            }
            let touchPosition = touch.location(in: self)
            if touchPosition.x < (self.frame.width / 2) {
                self.ferrisWheel.physicsBody?.applyAngularImpulse(-(wheelSpeed/100))
            } else {
                self.ferrisWheel.physicsBody?.applyAngularImpulse(wheelSpeed/100)
            }
        }
        if magnitude < 25 {
            if !zoomedIn{
                zoomIn()
//                for cabin in cabins {
//                    if !cabin.doorsOpen{
//                        cabin.openDoors()
//                    }
//                    else {
//                        cabin.closeDoors()
//                    }
//                }
            }
            else {
                zoomOut()
//                for cabin in cabins {
//                    cabin.openDoors()
//                }
            }
            
            let touchPosition = touch.location(in: self)
            if touchPosition.x < (self.frame.width / 2) {
                self.ferrisWheel.physicsBody?.angularVelocity = 0
            } else {
                self.ferrisWheel.physicsBody?.angularVelocity = 0
            }
        }
        
    }
    
    //MARK: custom functions
    
    func zoomIn(scalingFactor: CGFloat = 0.2) {
        let zoomInAction = SKAction.scale(to: scalingFactor, duration: 1)
        let positioning = SKAction.moveTo(y: zoomPoint!, duration: 1)
        let group = SKAction.group([zoomInAction, positioning])
        cameraNode.run(group)
        zoomedIn = true
    }
    
    func zoomOut(scalingFactor: CGFloat = 1) {
        let zoomInAction = SKAction.scale(to: scalingFactor, duration: 1)
        let positioning = SKAction.moveTo(y: self.size.height / 2, duration: 1)
        let group = SKAction.group([zoomInAction, positioning])
        cameraNode.run(group)
        zoomedIn = false
    }
    
    //MARK: Speech
    
    func checkAuthorization() {
        
        SFSpeechRecognizer.requestAuthorization { authStatus in
            
            OperationQueue.main.addOperation {
                switch authStatus {
                    
                case .authorized:
                    
                    self.listen = true
                    
                    self.recordingNode.texture = SKTexture(imageNamed: "recording on")
                    
                    if self.audio.isRunning {
                        self.audio.stop()
                        self.recognitionRequest?.endAudio()
                    } else {
                        self.recordingNode.texture = SKTexture(imageNamed: "recording on")
                        try! self.startRecording()
                    }
                    
                case .denied:
                    
                    self.recordingNode.texture = SKTexture(imageNamed: "recording denied")
                    
                case .restricted:
                    
                    self.recordingNode.texture = SKTexture(imageNamed: "recording denied")
                    
                case .notDetermined:
                    
                    self.recordingNode.texture = SKTexture(imageNamed: "recording denied")
                    
                }
            }
        }
    }
    
    
    private func startRecording() throws {
        
        // Cancel the previous task if it's running.
        if let recognitionTask = recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSessionCategoryRecord)
        try audioSession.setMode(AVAudioSessionModeMeasurement)
        try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audio.inputNode
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to created a SFSpeechAudioBufferRecognitionRequest object") }
        
        // Configure request so that results are returned before audio recording is finished
        recognitionRequest.shouldReportPartialResults = true
        
        // A recognition task represents a speech recognition session.
        // We keep a reference to the task so that it can be cancelled.
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            var isFinal = false
            
            if let result = result {
                
                // Recognized sentence from speech recognition session
                self.recognizedSentence = result.bestTranscription.formattedString.lowercased()
                print("The recognized sentence until now is: \(self.recognizedSentence)\n")
                isFinal = result.isFinal
                
                // Control if the array of words has the current word (needs to be set empty or to reinitialize the session)
                if self.recognizedSentence.contains(self.currentWordOnScreen) {
                    
                    self.audio.stop()
                    self.recognitionRequest?.endAudio()
                    self.recognitionRequest = nil
                    self.recognitionTask = nil
                    
                    print("Entered the control, the current word on screen is: \(self.currentWordOnScreen!)\n")
                    self.cabins[0].closeDoors()
                    
                    
                    
                }
            }
            
            if error != nil || isFinal {
                
                self.audio.stop()
                inputNode.removeTap(onBus: 0)
                
                if self.listen {
//                    self.changeCard()
                    try! self.startRecording()
                }
            }
        }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audio.prepare()
        
        try audio.start()
        self.listen = true
    }
    
    func startGame() {
        currentWordOnScreen = currentWords[0]
        print("Current word: \(self.currentWordOnScreen!)\n")
        cabins[0].openDoors()

    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
