//
//  CameraRatio.swift
//  AlternativeCamera
//
//  Created by Brandon Santeliz on 1/16/25.
//

enum CameraRatio: String, CaseIterable, Identifiable {
    case full, square
    
    var id: String { rawValue }
    
    var title: String { rawValue.capitalized }
    
    var iconName: String {
        switch self {
            case .full: "rectangle.portrait"
            case .square: "square"
        }
    }
}
