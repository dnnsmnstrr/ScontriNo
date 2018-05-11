//
//  FaceDetectionScreen.swift
//  Scontrino
//
//  Created by Eduardo Yutaka Nakanishi on 26/04/2018.
//  Copyright © 2018 Eduardo Yutaka Nakanishi. All rights reserved.
//
//  TODO: Make back button visible
//

import UIKit
import SpriteKit
import AVFoundation
import Vision

class FaceDetectionScreen: GameScene {
    
    internal var backgroundLayer = CALayer()
    internal var gameLayer = CALayer()
    
    // MARK: AVSession Management
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    private var devicePosition: AVCaptureDevice.Position = .front
    private let sessionQueue = DispatchQueue(label: "session queue", attributes: [], target: nil) // Communicate with the session and other session objects on this queue.
    
    private var videoDeviceInput: AVCaptureDeviceInput!
    
    private var videoDataOutput: AVCaptureVideoDataOutput!
    private var videoDataOutputQueue = DispatchQueue(label: "VideoDataOutputQueue")
    
    
    // MARK: didMove
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .clear
        
        captureSession = AVCaptureSession()
        
        self.configureSession()
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        view.layer.addSublayer(previewLayer)
        //        view.layer.addSublayer(gameLayer)
        //        view.layer.insertSublayer(gameLayer, above: previewLayer)
        //        view.layer.insertSublayer(previewLayer, at: 1)
        //        view.layer.insertSublayer(previewLayer, below: gameLayer)
        captureSession.startRunning()
        
    }
    
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func configureSession() {
        
        captureSession.beginConfiguration()
        captureSession.sessionPreset = .high
        
        // Add video input.
        do {
            var defaultVideoDevice: AVCaptureDevice?
            
            // Choose the front camera
            if let frontCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .front) {
                defaultVideoDevice = frontCameraDevice
            }
            
            let videoDeviceInput = try AVCaptureDeviceInput(device: defaultVideoDevice!)
            
            if captureSession.canAddInput(videoDeviceInput) {
                captureSession.addInput(videoDeviceInput)
                self.videoDeviceInput = videoDeviceInput
            }
        } catch {
            print("Could not create video device input: \(error)")
            captureSession.commitConfiguration()
            return
        }
        
        // add output
        videoDataOutput = AVCaptureVideoDataOutput()
        videoDataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as String): Int(kCVPixelFormatType_32BGRA)]
        
        if captureSession.canAddOutput(videoDataOutput) {
            videoDataOutput.alwaysDiscardsLateVideoFrames = true
            videoDataOutput.setSampleBufferDelegate(self as? AVCaptureVideoDataOutputSampleBufferDelegate, queue: videoDataOutputQueue)
            captureSession.addOutput(videoDataOutput)
        } else {
            print("Could not add metadata output to the session")
            captureSession.commitConfiguration()
            return
        }
        
        captureSession.commitConfiguration()
    }
    
    
}

//extension FaceDetectionScreen: AVCaptureVideoDataOutputSampleBufferDelegate{
//    // MARK: - AVCaptureVideoDataOutputSampleBufferDelegate
//    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
//        let exifOrientation = CGImagePropertyOrientation.leftMirrored
//        var requestOptions: [VNImageOption : Any] = [:]
//
//        if let cameraIntrinsicData = CMGetAttachment(sampleBuffer, kCMSampleBufferAttachmentKey_CameraIntrinsicMatrix, nil) {
//            requestOptions = [.cameraIntrinsics : cameraIntrinsicData]
//        }
//
//        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: exifOrientation, options: requestOptions)
//
//        do {
//            try imageRequestHandler.perform(requests)
//        }
//
//        catch {
//            print(error)
//        }
//
//    }
//
//}
