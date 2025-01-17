//
//  CameraPreview.swift
//  AlternativeCamera
//
//  Created by Brandon Santeliz on 1/16/25.
//

import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    private let session: AVCaptureSession
    
    init(session: AVCaptureSession) {
        self.session = session
    }
    
    func makeUIView(context: Context) -> UIView {
        let cameraView = UIView(frame: UIScreen.main.bounds)
        setupPreview(in: cameraView)
        return cameraView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) { }
    
    private func setupPreview(in view: UIView) {
        let preview = AVCaptureVideoPreviewLayer(session: session)
        preview.frame = view.frame
        preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(preview)
    }
}
