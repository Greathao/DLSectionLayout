//
//  DLRoundedLayoutAttributes.swift
//  DLSectionLayout
//
//  Created by liuhao on 2025/6/18.
//

 
// MARK: - 自定义圆角布局属性
class DLRoundedLayoutAttributes: UICollectionViewLayoutAttributes {
    var sectionIndex: Int = 0
    var sectionCornerRadii: DLCornerRadii = .zero
    var sectionFrame: CGRect = .zero
    var frameInSection: CGRect = .zero
    var roundingCorners: UIRectCorner = []
    var cornerRadius: CGFloat = 0
    var needsRounding: Bool = false
    var roundedClipPath: CGPath? = nil // 新增：前面计算好的节点分组圆角 path

    override func copy(with zone: NSZone? = nil) -> Any {
        guard let copy = super.copy(with: zone) as? DLRoundedLayoutAttributes else { return super.copy(with: zone) }
        copy.sectionIndex = sectionIndex
        copy.sectionCornerRadii = sectionCornerRadii
        copy.sectionFrame = sectionFrame
        copy.frameInSection = frameInSection
        copy.roundingCorners = roundingCorners
        copy.cornerRadius = cornerRadius
        copy.needsRounding = needsRounding
        copy.roundedClipPath = roundedClipPath
        return copy
    }
}
