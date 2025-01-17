//
//  CameraViewModel.swift
//  AlternativeCamera
//
//  Created by Brandon Santeliz on 1/16/25.
//

import Foundation
import AVFoundation

final class CameraViewModel<Manager: CameraManagerProtocol>: ObservableObject {
    @Published var ratio: CameraRatio = .full
    private var cameraManager: Manager
    
    lazy var session: AVCaptureSession = {
        cameraManager.session
    }()
    
    // MARK: - Initializer
    
    init(cameraManager: Manager = CameraManager()) {
        self.cameraManager = cameraManager
        cameraManager.checkCameraAccess()
    }
    
    // MARK: - Private Methods
    
    func takePicture() {
        cameraManager.takePicture()
    }
}
