//
//  CameraView.swift
//  AlternativeCamera
//
//  Created by Brandon Santeliz on 1/16/25.
//

import SwiftUI

struct CameraView: View {
    @StateObject private var viewModel: CameraViewModel = .init()
    
    var body: some View {
        ZStack {
            CameraPreview(session: viewModel.session)
                .ignoresSafeArea()
            
            VStack {
                CameraRatioOptions(selectedRatio: $viewModel.ratio)
                
                TakePhotoButton(action: viewModel.takePicture)
            }
            .frame(maxSquare: .infinity)
        }
    }
}
