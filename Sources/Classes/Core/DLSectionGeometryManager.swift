//
//  DLSectionGeometryManager.swift
//  DLSectionLayout
//
//  Created by liuhao on 2025/6/18.
//
// MARK: - Section 几何信息管理器
class DLSectionGeometryManager {
    private var sectionFrames: [Int: CGRect] = [:]
    private var sectionItems: [Int: [UICollectionViewLayoutAttributes]] = [:]
    
    func addItem(_ item: UICollectionViewLayoutAttributes, forSection section: Int) {
        if sectionItems[section] == nil {
            sectionItems[section] = []
        }
        sectionItems[section]?.append(item)
        updateSectionFrame(section, withItem: item)
    }
    
    private func updateSectionFrame(_ section: Int, withItem item: UICollectionViewLayoutAttributes) {
        let currentFrame = sectionFrames[section] ?? .zero
        let newFrame = currentFrame.isEmpty ? item.frame : currentFrame.union(item.frame)
        sectionFrames[section] = newFrame
    }
    
    func frameForSection(_ section: Int) -> CGRect {
        return sectionFrames[section] ?? .zero
    }
    
    func itemsForSection(_ section: Int) -> [UICollectionViewLayoutAttributes] {
        return sectionItems[section] ?? []
    }
    
    func reset() {
        sectionFrames.removeAll()
        sectionItems.removeAll()
    }
}


 
