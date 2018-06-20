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
    private var currentWords: [String] = []
    var index: Int = 0
    
    //synthesizer
    let synthesizer = AVSpeechSynthesizer()
    
    let recordingNode = SKSpriteNode(imageNamed: "recording off")
    var recognizedSentence = ""
    var recognizedWords = [Substring]()
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "it-IT"))!
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
//    let background = SKSpriteNode()
    
    var ferrisWheel: SKSpriteNode!
    var amountOfCabins: Float = 6 //default is six, physics are tuned to that
    private var cabins: [CabinNode] = []
    
    
    var startTime: TimeInterval?
    var start: CGPoint?
    var end: CGPoint?
    var wheelSpeed: CGFloat = 1000
    var zoomedIn: Bool = false
    var zooming: Bool = false
    var zoomPoint: CGFloat?
    var justSkipped: Bool = false
    var screenScale: CGFloat = UIScreen.main.scale
    
    
    
    override func createSceneContents() {
        super.createSceneContents()
        let center: CGPoint = CGPoint(x: self.size.width / 2,y: self.size.height / 2)
        
        //camera
        cameraNode.position = center
        self.addChild(cameraNode)
        self.camera = cameraNode
        print(screenScale)
        
        //background
        let background = SKSpriteNode(imageNamed: "ferris wheel background")
        background.position = center
        background.setScale(Consts.Graphics.scale)
        addChild(background)

        //create ferris wheel
        createFerrisWheel()
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -30/screenScale)
        
        //set up the first round
        startGame()
        
        //start the recording process
        checkAuthorization()
        
    }
    
    //touch handling
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        self.start = touch.location(in: self)
        self.startTime = touch.timestamp
        
        /* TEXT TO SPEECH
        self.recognitionRequest?.endAudio()
        self.recognitionRequest = nil
        self.recognitionTask = nil*/
        
        let utterance = AVSpeechUtterance(string: self.currentWordOnScreen)
        utterance.voice = AVSpeechSynthesisVoice(language: "it-IT")
        utterance.rate = 0.5
        utterance.volume = 1.0
        self.synthesizer.speak(utterance)
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("Error in starting the audio session")
        }
 
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
                self.ferrisWheel.physicsBody?.applyAngularImpulse(-(wheelSpeed/10))
                if magnitude > 100 {
                    nextCabin()
                }
            } else {
                self.ferrisWheel.physicsBody?.applyAngularImpulse(wheelSpeed/10)
            }
            
        }
        if magnitude < 25 {
            if !zoomedIn && !zooming{
                zoomIn()
            }
            else if !zooming {
                zoomOut()
            }
            
            let touchPosition = touch.location(in: self)
            if touchPosition.x < (self.frame.width / 2) {
                self.ferrisWheel.physicsBody?.angularVelocity = 0
            } else {
                self.ferrisWheel.physicsBody?.angularVelocity = 0
            }
        }
        
    }
    
    //MARK: camera functions
    
    func zoomIn(scalingFactor: CGFloat = 0.2, duration: TimeInterval = 1) {
        let zoomInAction = SKAction.scale(to: scalingFactor, duration: duration)
        let positioning = SKAction.moveTo(y: zoomPoint!, duration: duration)
        let group = SKAction.group([zoomInAction, positioning])
        
        if !zooming{
            zooming = true
            cameraNode.run(group) {
                self.zooming = false
                self.zoomedIn = true
            }
        }
        
    }
    
    func zoomOut(scalingFactor: CGFloat = 1, duration: TimeInterval = 1) {
        let zoomInAction = SKAction.scale(to: scalingFactor, duration: duration)
        let positioning = SKAction.moveTo(y: self.size.height / 2, duration: duration)
        let group = SKAction.group([zoomInAction, positioning])
        if !zooming{
            zooming = true
            cameraNode.run(group) {
                self.zooming = false
            }
        }
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
//                        try! self.startRecording()
                        
                        do {
                            try self.startRecording()
                            
                        } catch {
                            print("error unknown")
                        }
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
                self.currentWordOnScreen = self.currentWords[self.index]
                print("Current word: \(self.currentWordOnScreen!)\n")
                
                // Control if the array of words has the current word (needs to be set empty or to reinitialize the session)
                // or it is found a high similarity in the words spoken by Levenshtein distance
                
                for each in result.bestTranscription.segments {
                
                    if self.recognizedSentence.contains(self.currentWordOnScreen) || Tools.levenshtein(aStr: each.substring.lowercased(), bStr: self.currentWordOnScreen) < 4 {
                    
                    self.audio.stop()
                    self.recognitionRequest?.endAudio()
                    self.recognitionRequest = nil
                    self.recognitionTask = nil
                    
                    self.currentWordOnScreen = self.currentWords[self.index]
                    
                    
                    print("Word recognized, the new word on screen is: \(self.currentWordOnScreen!)\n")
                    
                }
                    //skip if too many words were said
                else if (self.recognizedSentence.lengthOfBytes(using: String.Encoding.ascii) > 50 && !self.justSkipped) || self.recognizedSentence.contains("skip"){
                    self.audio.stop()
                    self.recognitionRequest?.endAudio()
                    self.recognitionRequest = nil
                    self.recognitionTask = nil
                    
                    self.justSkipped = true
                    
                    print("Skipped, the new word on screen is: \(self.currentWordOnScreen!)\n")
                }
                
                }
            }
            
            if isFinal {
                
                self.audio.stop()
                inputNode.removeTap(onBus: 0)
                
                self.nextCabin()
                
                //                if !self.justSkipped{
                //                    self.nextCabin()
                //                    self.justSkipped = false
                //                }
                
                if self.listen {
                    try! self.startRecording()
                }
            } else if error != nil {
                
                self.audio.stop()
                inputNode.removeTap(onBus: 0)
                
                if self.listen {
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
    
    //ui
    func createFerrisWheel() {
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
        ferrisWheel.physicsBody?.angularDamping = 0.5 * screenScale * screenScale * screenScale
        
        let base = SKSpriteNode(imageNamed: "base")
        base.position = CGPoint(x: size.width/2, y: size.height/4.5)
        base.size = CGSize(width: ferrisWheel.frame.width*1.1, height: ferrisWheel.frame.height*1.1)
        
        self.addChild(ferrisWheel)
        self.addChild(base)
        
        placeCabins(amount: amountOfCabins)
    }
    
    func placeCabins(amount: Float = 6) {
        let radius = ferrisWheel.size.width/2 - 10
        for i in 1...Int(amount) {
            
            let newCabin = CabinNode.init(imageNamed: "cabin body")
            
            newCabin.zPosition = 3
            newCabin.size = CGSize(width: ferrisWheel.size.width/5, height: ferrisWheel.size.height/5)
            
            //trigonometric functions to calculate cabin position on the circumference of the wheel
            let currentX = radius*CGFloat(cosf(2*Float.pi*Float(i)/amount))+ferrisWheel.frame.midX
            let currentY = radius*CGFloat(sinf(2*Float.pi*Float(i)/amount))+ferrisWheel.frame.midY
            
            newCabin.position = CGPoint(x: currentX, y: currentY-newCabin.size.height/2)
            newCabin.physicsBody = SKPhysicsBody(circleOfRadius: newCabin.size.height/2)
            newCabin.physicsBody?.angularDamping = 30
            newCabin.physicsBody?.mass = 2
            //resize doors according to current cabin size
            newCabin.leftDoor?.size = CGSize(width: newCabin.size.width/3.1, height: newCabin.size.height/1.3)
            newCabin.rightDoor?.size = CGSize(width: newCabin.size.width/3.1, height: newCabin.size.height/1.3)
            newCabin.occupant?.size = CGSize(width: newCabin.size.width/2, height: newCabin.size.height/2)
            
            
            //occupant
            let newOccupant: String = dataSource.getWord()
            currentWords.append(newOccupant)
            newCabin.occupant?.texture = SKTexture(imageNamed: newOccupant)
            
            self.addChild(newCabin)
            cabins.append(newCabin)
            
            let joint = SKPhysicsJointPin.joint(withBodyA: ferrisWheel.physicsBody! , bodyB: newCabin.physicsBody!, anchor: CGPoint(x: currentX, y: currentY))
            self.physicsWorld.add(joint)
            
        }
    }
    
    func startGame() {
        zoomIn(scalingFactor: 0.2, duration: 15/Double(screenScale))
        currentWordOnScreen = currentWords[index]
        print("Current word: \(self.currentWordOnScreen!)\n")
        cabins[index].physicsBody?.mass=5
        cabins[index].openDoors(duration: 1.5, wait: true, waitDuration: 4.3)
        
    }
    
    
    func nextCabin() {
        cabins[index].physicsBody?.mass = 2
        self.cabins[self.index].closeDoors()
        if index == Int(amountOfCabins)-1{
            index = 0
            let time = SKAction.wait(forDuration: 2)
            run(time) {
                self.reloadWords()
            }
        }
        else{
            self.index += 1
        }
        cabins[index].physicsBody?.mass = 9/screenScale
        
        //default wait time is 2 seconds
        cabins[index].openDoors(wait: true)
    }
    
    func reloadWords() {
        print("Reloading words...")
        currentWords = []
        for cabin in cabins {
            let newOccupant: String = dataSource.getWord()
            currentWords.append(newOccupant)
            cabin.occupant?.texture = SKTexture(imageNamed: newOccupant)
            
        }
        print("The new words are: \(self.currentWords)")
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
