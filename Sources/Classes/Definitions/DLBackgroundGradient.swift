//
//  DLBackgroundGradient.swift
//  DLSectionLayout
//
//  Created by liuhao on 2025/6/18.
//

import Foundation
 
public enum DLGradientDirection {
    case vertical
    case horizontal
    case diagonalLeftToRight       // 左上 -> 右下
    case diagonalRightToLeft       // 右上 -> 左下
    case diagonalBottomLeftToTopRight // 左下 -> 右上
    case diagonalBottomRightToTopLeft // 右下 -> 左上
    
    public var startPoint: CGPoint {
        switch self {
        case .vertical:
            return CGPoint(x: 0.5, y: 0)
        case .horizontal:
            return CGPoint(x: 0, y: 0.5)
        case .diagonalLeftToRight:
            return CGPoint(x: 0, y: 0)
        case .diagonalRightToLeft:
            return CGPoint(x: 1, y: 0)
        case .diagonalBottomLeftToTopRight:
            return CGPoint(x: 0, y: 1)
        case .diagonalBottomRightToTopLeft:
            return CGPoint(x: 1, y: 1)
        }
    }
    
    public var endPoint: CGPoint {
        switch self {
        case .vertical:
            return CGPoint(x: 0.5, y: 1)
        case .horizontal:
            return CGPoint(x: 1, y: 0.5)
        case .diagonalLeftToRight:
            return CGPoint(x: 1, y: 1)
        case .diagonalRightToLeft:
            return CGPoint(x: 0, y: 1)
        case .diagonalBottomLeftToTopRight:
            return CGPoint(x: 1, y: 0)
        case .diagonalBottomRightToTopLeft:
            return CGPoint(x: 0, y: 0)
        }
    }
}

public struct DLBackgroundGradient: Equatable {
    public var colors: [UIColor]
    public var direction: DLGradientDirection

    public init(colors: [UIColor], direction: DLGradientDirection) {
        self.colors = colors
        self.direction = direction
    }
}
