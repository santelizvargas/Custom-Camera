//
//  CameraManager.swift
//  AlternativeCamera
//
//  Created by Brandon Santeliz on 1/16/25.
//

import SwiftUI
import AVFoundation

final class CameraManager: NSObject, CameraManagerProtocol {
    private(set) var session: AVCaptureSession = .init()
    private let output: AVCapturePhotoOutput
    private let queue: DispatchQueue
    
    // MARK: - Initializer
    
    init(output: AVCapturePhotoOutput = .init(),
         queue: DispatchQueue = .global(qos: .userInteractive)) {
        self.output = output
        self.queue = queue
    }
    
    // MARK: - Public Methods
    
    func checkCameraAccess() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: setupCamera()
        case .notDetermined: requestAccess()
        case .denied: handleDeniedAccess()
        default: break
        }
    }
    
    func startSession() {
        let execute: DispatchWorkItem = .init { [unowned self] in
            guard !session.isRunning else { return }
            session.startRunning()
        }
        queue.async(execute: execute)
    }
    
    func stopSession() {
        let execute: DispatchWorkItem = .init { [unowned self] in
            session.stopRunning()
        }
        queue.async(execute: execute)
    }
    
    func takePicture() {
        let execute: DispatchWorkItem = .init { [unowned self] in
            let settings = AVCapturePhotoSettings()
            output.capturePhoto(with: settings, delegate: self)
        }
        queue.async(execute: execute)
    }
    
    // MARK: - Private Methods
    
    private func requestAccess() {
        Task {
            if await AVCaptureDevice.requestAccess(for: .video) {
                setupCamera()
            } else {
                handleDeniedAccess()
            }
        }
    }
    
    private func setupCamera() {
        session.beginConfiguration(); defer { session.commitConfiguration() }
        
        guard let cameraDevice else { return }
        addInput(device: cameraDevice)
        addOutput()
        startSession()
    }
    
    private var cameraDevice: AVCaptureDevice? {
        AVCaptureDevice.default(
            .builtInDualCamera,
            for: .video,
            position: .back
        )
    }
    
    private func addInput(device: AVCaptureDevice) {
        do {
            let input = try AVCaptureDeviceInput(device: device)
            
            guard session.canAddInput(input) else { return }
            session.addInput(input)
        } catch {
            debugPrint("Failed to add camera input: \(error.localizedDescription)")
        }
    }
    
    private func addOutput() {
        guard session.canAddOutput(output) else { return }
        session.addOutput(output)
    }
    
    private func handleDeniedAccess() { }
}

// MARK: - AVCapturePhotoCaptureDelegate

extension CameraManager: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?) {
        guard error == nil,
              let imageData = photo.fileDataRepresentation(),
              let uiImage = UIImage(data: imageData) else {
            return
        }
        UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil)
    }
}
