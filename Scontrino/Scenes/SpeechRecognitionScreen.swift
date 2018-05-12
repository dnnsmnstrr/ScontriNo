//
//  SpeechRecognitionScreen.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 26/04/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit
import Speech

class SpeechRecognitionScreen: GameScene, SFSpeechRecognizerDelegate {
    let dataSource = GameDataSource()
    var currentWordOnScreen: String!
    
    let recordingNode = SKSpriteNode(imageNamed: "recording off")
    var recognizedSentence = ""
    var recognizedWords = [Substring]()
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private var audio = AVAudioEngine()
    
    var listen = false {
        didSet {
            if !listen {
                audio.stop()
            }
        }
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func createSceneContents() {
        super.createSceneContents()
        currentWordOnScreen = dataSource.nextWord()
        
        let cardNode = SKSpriteNode(imageNamed: "card")
        cardNode.name = "card"
        cardNode.position = CGPoint(x: Consts.Graphics.screenWidth / 2, y: Consts.Graphics.screenHeight / 2)
        self.addChild(cardNode)
        
        let illustrationNode = SKSpriteNode(imageNamed: currentWordOnScreen)
        illustrationNode.name = "illustration"
        illustrationNode.position = CGPoint(x: 0, y: 33.5 * cardNode.size.height / 267)
        cardNode.addChild(illustrationNode)
        
        let captionNode = SKLabelNode(text: currentWordOnScreen)
        captionNode.fontSize = 36
        captionNode.fontColor = .black
        captionNode.name = "caption"
        captionNode.position = CGPoint(x: 0, y: -100 * cardNode.size.height / 267)
        cardNode.addChild(captionNode)
        
        recordingNode.name = "recording"
        recordingNode.position = CGPoint(x: Consts.Graphics.screenWidth / 2, y: Consts.Graphics.screenHeight / 5)
        self.addChild(recordingNode)
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        checkAuthorization()
        
        if SFSpeechRecognizer.authorizationStatus() != .authorized {
            // Speech Recognition not authorized
        } else {
            if audio.isRunning {
                audio.stop()
                recognitionRequest?.endAudio()
            } else {
                self.recordingNode.texture = SKTexture(imageNamed: "recording on")
                try! startRecording()
            }
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
       /* if SFSpeechRecognizer.authorizationStatus() != .authorized {
            // Speech Recognition not authorized
        } else {
            if audio.isRunning {
                audio.stop()
                recognitionRequest?.endAudio()
            } else {
                self.recordingNode.texture = SKTexture(imageNamed: "recording on")
                try! startRecording()
            }
            
        }
        */
    }
    
    func checkAuthorization() {
        
        SFSpeechRecognizer.requestAuthorization { authStatus in
            
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.recordingNode.texture = SKTexture(imageNamed: "recording on")
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
                    
                    
//                    self.wordIndex += 1
//                    let i = self.recognizedWords.index(of: Substring(self.currentWordOnScreen!))
//                    print(self.wordIndex)
//                    print(self.recognizedWords[i!])
                    self.currentWordOnScreen = self.dataSource.nextWord()
                    print("Entered the control, the current word on screen is: \(self.currentWordOnScreen!)\n")
//                    if self.currentWordOnScreen == "sole" {
//                        print("it worked!")
//                    }
                    
                    
                
                }
            }
            
            if error != nil || isFinal {
                self.listen = false

                self.audio.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                let cardNode = self.childNode(withName: "card")
                let illustrationNode = cardNode?.childNode(withName: "illustration")
                let captionNode = cardNode?.childNode(withName: "caption") as! SKLabelNode
                
                let cardAnimation = SKAction.sequence([SKAction.fadeOut(withDuration: 1.0),
                                                       SKAction.fadeIn(withDuration: 1.0)])
                let illustrationAnimation = SKAction.sequence([SKAction.wait(forDuration: 1.0),
                                                               SKAction.setTexture(SKTexture(imageNamed: self.currentWordOnScreen))])
                
                cardNode?.run(cardAnimation)
                illustrationNode?.run(illustrationAnimation)
                captionNode.text = self.currentWordOnScreen
                
                try! self.startRecording()
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
    
    
    
}
