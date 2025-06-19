//
//  DLSectionBackgroundLayoutAttributes.swift
//  DLSectionLayout
//
//  Created by liuhao on 2025/6/18.

 
// MARK: - 背景视图属性
class DLSectionBackgroundLayoutAttributes: UICollectionViewLayoutAttributes {
    var containerInsets: UIEdgeInsets = .zero
    var cornerRadii: DLCornerRadii = .zero
    var backgroundGradient: DLBackgroundGradient?
    var backgroundImageURLString: String?
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! DLSectionBackgroundLayoutAttributes
        copy.containerInsets = containerInsets
        copy.cornerRadii = cornerRadii
        copy.backgroundGradient = backgroundGradient
        copy.backgroundImageURLString = backgroundImageURLString
        return copy
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? DLSectionBackgroundLayoutAttributes else { return false }
        return super.isEqual(other) &&
               containerInsets == other.containerInsets &&
               cornerRadii.topLeft == other.cornerRadii.topLeft &&
               cornerRadii.topRight == other.cornerRadii.topRight &&
               cornerRadii.bottomLeft == other.cornerRadii.bottomLeft &&
               cornerRadii.bottomRight == other.cornerRadii.bottomRight
    }
}
 
