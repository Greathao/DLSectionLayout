//
//  DLCornerRadii.swift
//  DLSectionLayout
//
//  Created by liuhao on 2025/6/18.
//

import Foundation

// MARK: - 圆角信息结构
public struct DLCornerRadii {
    let topLeft: CGFloat
    let topRight: CGFloat
    let bottomLeft: CGFloat
    let bottomRight: CGFloat
    
    public  static let zero = DLCornerRadii(topLeft: 0, topRight: 0, bottomLeft: 0, bottomRight: 0)
    
    public  init(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) {
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight
    }
    
    public  init(all: CGFloat) {
        self.init(topLeft: all, topRight: all, bottomLeft: all, bottomRight: all)
    }
    
    public var hasAnyCorner: Bool {
        return topLeft > 0 || topRight > 0 || bottomLeft > 0 || bottomRight > 0
    }
     

    public func roundedCorners() -> UIRectCorner {
        var corners: UIRectCorner = []
        if topLeft > 0 { corners.insert(.topLeft) }
        if topRight > 0 { corners.insert(.topRight) }
        if bottomLeft > 0 { corners.insert(.bottomLeft) }
        if bottomRight > 0 { corners.insert(.bottomRight) }
        return corners
    }
}
 
extension DLCornerRadii {
    func withTopLeft(_ radius: CGFloat) -> DLCornerRadii {
        return DLCornerRadii(topLeft: radius, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight)
    }
    func withTopRight(_ radius: CGFloat) -> DLCornerRadii {
        return DLCornerRadii(topLeft: topLeft, topRight: radius, bottomLeft: bottomLeft, bottomRight: bottomRight)
    }
    func withBottomLeft(_ radius: CGFloat) -> DLCornerRadii {
        return DLCornerRadii(topLeft: topLeft, topRight: topRight, bottomLeft: radius, bottomRight: bottomRight)
    }
    func withBottomRight(_ radius: CGFloat) -> DLCornerRadii {
        return DLCornerRadii(topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: radius)
    }
}

 
extension DLCornerRadii {
    func toPath(in rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()

        let topLeftRadius = CGSize(width: topLeft, height: topLeft)
        let topRightRadius = CGSize(width: topRight, height: topRight)
        let bottomRightRadius = CGSize(width: bottomRight, height: bottomRight)
        let bottomLeftRadius = CGSize(width: bottomLeft, height: bottomLeft)

        let topLeft = CGPoint(x: rect.minX, y: rect.minY)
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)

        // Start at top-left corner
        path.move(to: CGPoint(x: topLeft.x + topLeftRadius.width, y: topLeft.y))

        // Top edge
        path.addLine(to: CGPoint(x: topRight.x - topRightRadius.width, y: topRight.y))
        path.addArc(
            withCenter: CGPoint(x: topRight.x - topRightRadius.width, y: topRight.y + topRightRadius.height),
            radius: topRightRadius.width,
            startAngle: CGFloat(-CGFloat.pi / 2),
            endAngle: 0,
            clockwise: true
        )

        // Right edge
        path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y - bottomRightRadius.height))
        path.addArc(
            withCenter: CGPoint(x: bottomRight.x - bottomRightRadius.width, y: bottomRight.y - bottomRightRadius.height),
            radius: bottomRightRadius.width,
            startAngle: 0,
            endAngle: CGFloat(CGFloat.pi / 2),
            clockwise: true
        )

        // Bottom edge
        path.addLine(to: CGPoint(x: bottomLeft.x + bottomLeftRadius.width, y: bottomLeft.y))
        path.addArc(
            withCenter: CGPoint(x: bottomLeft.x + bottomLeftRadius.width, y: bottomLeft.y - bottomLeftRadius.height),
            radius: bottomLeftRadius.width,
            startAngle: CGFloat(CGFloat.pi / 2),
            endAngle: CGFloat(CGFloat.pi),
            clockwise: true
        )

        // Left edge
        path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y + topLeftRadius.height))
        path.addArc(
            withCenter: CGPoint(x: topLeft.x + topLeftRadius.width, y: topLeft.y + topLeftRadius.height),
            radius: topLeftRadius.width,
            startAngle: CGFloat(CGFloat.pi),
            endAngle: CGFloat(3 * CGFloat.pi / 2),
            clockwise: true
        )

        path.close()
        return path
    }
}
