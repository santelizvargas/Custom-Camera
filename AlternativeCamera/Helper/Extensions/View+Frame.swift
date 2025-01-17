//
//  View+Frame.swift
//  AlternativeCamera
//
//  Created by Brandon Santeliz on 1/16/25.
//

import SwiftUI

// MARK: - View + Frame Square

extension View {
    func frame(square size: CGFloat,
               alignment: Alignment = .center) -> some View {
        frame(
            width: size,
            height: size,
            alignment: alignment
        )
    }
    
    func frame(maxSquare size: CGFloat,
               alignment: Alignment = .center) -> some View {
        frame(
            maxWidth: size,
            maxHeight: size,
            alignment: alignment
        )
    }
}
