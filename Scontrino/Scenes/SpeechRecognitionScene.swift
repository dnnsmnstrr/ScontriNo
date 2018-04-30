//
//  SpeechRecognitionScene.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 26/04/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//

import SpriteKit
import Speech

class SpeechRecognitionScreen: GameScene, SFSpeechRecognizerDelegate {
    let tempDataModel = ["stella", "luna", "sole"] // all the possible words
    var wordIndex = 0
    var currentWordOnScreen: String?
    
    var isRecording = false
    let recordingNode = SKSpriteNode(imageNamed: "recording off")
    var recognizedSentence = ""
    var recognizedWords = [Substring]()
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "it-IT"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private var audio = AVAudioEngine()
    
    override init() {
        super.init()
        currentWordOnScreen = tempDataModel[wordIndex]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func createSceneContents() {
        super.createSceneContents()
        let starCardNode = SKSpriteNode(imageNamed: "star card")
        starCardNode.name = "star card"
        starCardNode.position = CGPoint(x: Consts.Graphics.screenWidth / 2, y: Consts.Graphics.screenHeight / 2)
        self.addChild(starCardNode)
        
        recordingNode.name = "recording"
        recordingNode.position = CGPoint(x: Consts.Graphics.screenWidth / 2, y: Consts.Graphics.screenHeight / 5)
        self.addChild(recordingNode)
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        SFSpeechRecognizer.requestAuthorization { authStatus in
            
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.recordingNode.texture = SKTexture(imageNamed: "recording off")
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
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
                self.recognizedSentence = result.bestTranscription.formattedString
                isFinal = result.isFinal
                
                // Getting recognized words from the sentence above
                self.recognizedWords = self.recognizedSentence.split(separator: " ")
                
                // Control if the array of words has the current word (needs to be set empty or to reinitialize the session)
                if self.recognizedWords.contains(Substring(self.currentWordOnScreen!)) {
                    self.wordIndex += 1
                    let i = self.recognizedWords.index(of: Substring(self.currentWordOnScreen!))
                    print(self.wordIndex)
                    print(self.recognizedWords[i!])
                    self.currentWordOnScreen = self.tempDataModel[self.wordIndex]
                    if self.currentWordOnScreen == "sole" {
                        print("it worked!")
                    }
                    let starCardNode = self.childNode(withName: "star card")
                    let fadeAway = SKAction.fadeOut(withDuration: 1.0)
                    let removeNode = SKAction.removeFromParent()
                    let sequence = SKAction.sequence([fadeAway, removeNode])
                    starCardNode?.run(sequence)
                    
                    let moonCardNode = SKSpriteNode(imageNamed: "moon card")
                    moonCardNode.position = CGPoint(x: Consts.Graphics.screenWidth / 2, y: Consts.Graphics.screenHeight / 2)
                    self.addChild(moonCardNode)
                    moonCardNode.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.0), SKAction.wait(forDuration: 1.0), SKAction.fadeIn(withDuration: 1.0)]))
                }
            }
            
            if error != nil || isFinal {
                self.audio.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.recordingNode.texture = SKTexture(imageNamed: "recording off")
            }
        }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audio.prepare()
        
        try audio.start()
    }
    
    
    
}
