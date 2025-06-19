//
//  DLCornerCalculator.swift
//  DLSectionLayout
//
//  Created by liuhao on 2025/6/18.
//

import UIKit

// MARK: - 圆角计算工具
 
import UIKit

class DLCornerCalculator {
    static func calculateCorners(for attr: DLRoundedLayoutAttributes,
                                 in section: Int,
                                 sectionFrame: CGRect,
                                 cornerRadii: DLCornerRadii) -> (corners: UIRectCorner, radius: CGFloat) {

        let frameInSection = attr.frameInSection
        let tolerance: CGFloat = 1.0 // 增加容错
        var corners: UIRectCorner = []
        var radius: CGFloat = 0

        if abs(frameInSection.minX) <= tolerance && abs(frameInSection.minY) <= tolerance && cornerRadii.topLeft > 0 {
            corners.insert(.topLeft)
            radius = max(radius, min(frameInSection.width, frameInSection.height, cornerRadii.topLeft))
        }

        if abs(frameInSection.maxX - sectionFrame.width) <= tolerance && abs(frameInSection.minY) <= tolerance && cornerRadii.topRight > 0 {
            corners.insert(.topRight)
            radius = max(radius, min(frameInSection.width, frameInSection.height, cornerRadii.topRight))
        }

        if abs(frameInSection.minX) <= tolerance && abs(frameInSection.maxY - sectionFrame.height) <= tolerance && cornerRadii.bottomLeft > 0 {
            corners.insert(.bottomLeft)
            radius = max(radius, min(frameInSection.width, frameInSection.height, cornerRadii.bottomLeft))
        }

        if abs(frameInSection.maxX - sectionFrame.width) <= tolerance && abs(frameInSection.maxY - sectionFrame.height) <= tolerance && cornerRadii.bottomRight > 0 {
            corners.insert(.bottomRight)
            radius = max(radius, min(frameInSection.width, frameInSection.height, cornerRadii.bottomRight))
        }

        return (corners, radius)
    }
}

extension DLCornerCalculator {
    /// 根据四个角的半径绘制圆角路径
    static func createRoundedPath(bounds: CGRect, cornerRadii: DLCornerRadii) -> UIBezierPath {
        let path = UIBezierPath()

        let topLeftRadius = cornerRadii.topLeft
        let topRightRadius = cornerRadii.topRight
        let bottomRightRadius = cornerRadii.bottomRight
        let bottomLeftRadius = cornerRadii.bottomLeft

        // 不要扩展bounds，直接使用原始bounds
        let workingBounds = bounds
        
        path.move(to: CGPoint(x: workingBounds.minX + topLeftRadius, y: workingBounds.minY))

        // top edge
        path.addLine(to: CGPoint(x: workingBounds.maxX - topRightRadius, y: workingBounds.minY))

        // topRight corner arc
        if topRightRadius > 0 {
            path.addArc(withCenter: CGPoint(x: workingBounds.maxX - topRightRadius, y: workingBounds.minY + topRightRadius),
                        radius: topRightRadius,
                        startAngle: CGFloat(-Double.pi / 2),
                        endAngle: 0,
                        clockwise: true)
        }

        // right edge
        path.addLine(to: CGPoint(x: workingBounds.maxX, y: workingBounds.maxY - bottomRightRadius))

        // bottomRight corner arc
        if bottomRightRadius > 0 {
            path.addArc(withCenter: CGPoint(x: workingBounds.maxX - bottomRightRadius, y: workingBounds.maxY - bottomRightRadius),
                        radius: bottomRightRadius,
                        startAngle: 0,
                        endAngle: CGFloat(Double.pi / 2),
                        clockwise: true)
        }

        // bottom edge
        path.addLine(to: CGPoint(x: workingBounds.minX + bottomLeftRadius, y: workingBounds.maxY))

        // bottomLeft corner arc
        if bottomLeftRadius > 0 {
            path.addArc(withCenter: CGPoint(x: workingBounds.minX + bottomLeftRadius, y: workingBounds.maxY - bottomLeftRadius),
                        radius: bottomLeftRadius,
                        startAngle: CGFloat(Double.pi / 2),
                        endAngle: CGFloat(Double.pi),
                        clockwise: true)
        }

        // left edge
        path.addLine(to: CGPoint(x: workingBounds.minX, y: workingBounds.minY + topLeftRadius))

        // topLeft corner arc
        if topLeftRadius > 0 {
            path.addArc(withCenter: CGPoint(x: workingBounds.minX + topLeftRadius, y: workingBounds.minY + topLeftRadius),
                        radius: topLeftRadius,
                        startAngle: CGFloat(Double.pi),
                        endAngle: CGFloat(3 * Double.pi / 2),
                        clockwise: true)
        }

        path.close()
        return path
    }

}
