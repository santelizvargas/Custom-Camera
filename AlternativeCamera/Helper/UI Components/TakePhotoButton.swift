//
//  TakePhotoButton.swift
//  AlternativeCamera
//
//  Created by Brandon Santeliz on 1/16/25.
//

import SwiftUI

private enum Constants {
    static let buttonSize: CGFloat = 60
    static let padding: CGFloat = 5
    static let strokeLineWidth: CGFloat = 2
    static let backgroundOpacity: CGFloat = 0.5
}

struct TakePhotoButton: View {
    private let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        Button { action() } label: {
            Circle() // just an instance
                .fill(.white)
                .frame(square: Constants.buttonSize)
                .padding(Constants.padding)
                .overlay {
                    Circle().stroke(.white, lineWidth: Constants.strokeLineWidth)
                }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.black.opacity(Constants.backgroundOpacity))
    }
}
