//
//  CameraRatioOptions.swift
//  AlternativeCamera
//
//  Created by Brandon Santeliz on 1/16/25.
//

import SwiftUI

private enum Constants {
    static let mainSpacing: CGFloat = 15
    static let backgroundOpacity: CGFloat = 0.5
}

struct CameraRatioOptions: View {
    @Binding private var selectedRatio: CameraRatio
    
    init(selectedRatio: Binding<CameraRatio>) {
        _selectedRatio = selectedRatio
    }
    
    // MARK: - Main View
    
    var body: some View {
        HStack(spacing: Constants.mainSpacing) {
            ForEach(CameraRatio.allCases) { ratio in
                ratioItem(for: ratio)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.black.opacity(Constants.backgroundOpacity))
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    // MARK: - UI Components
    
    private func ratioItem(for ratio: CameraRatio) -> some View {
        Button(ratio.title, systemImage: ratio.iconName) {
            withAnimation(.spring) {
                selectedRatio = ratio
            }
        }
        .buttonStyle(.plain)
        .foregroundStyle(selectedRatio == ratio ? .yellow : .white)
    }
}
