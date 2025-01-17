//
//  CameraManagerProtocol.swift
//  AlternativeCamera
//
//  Created by Brandon Santeliz on 1/16/25.
//


import SwiftUI
import AVFoundation

protocol CameraManagerProtocol {
    var session: AVCaptureSession { get }
    
    func checkCameraAccess()
    func startSession()
    func stopSession()
    func takePicture()
}
