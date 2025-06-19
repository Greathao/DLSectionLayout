
//
//  DLRoundedLayoutAttributes.swift
//  DLSectionLayout
//
//  Created by liuhao on 2025/6/18.
//


// MARK: 支持圆角的 DLRoundedCollectionViewCell 基类
open class DLRoundedCollectionViewCell: UICollectionViewCell {
    private var roundingMaskLayer: CAShapeLayer?
    private var currentAttributes: DLRoundedLayoutAttributes?
    private var needsReapplyRounding = false

    open override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)

        guard let roundedAttr = layoutAttributes as? DLRoundedLayoutAttributes else {
            clearRounding()
            return
        }
        currentAttributes = roundedAttr
        needsReapplyRounding = true
        applyRounding(with: roundedAttr)
    }

    private func applyRounding(with attributes: DLRoundedLayoutAttributes) {
        guard let clipPath = attributes.roundedClipPath else {
            clearRounding()
            return
        }

        // 根据 sectionFrame 转换成相对 cell 的 path
        var offsetTransform = CGAffineTransform(translationX: -attributes.frameInSection.minX, y: -attributes.frameInSection.minY)
        guard let translatedPath = clipPath.copy(using: &offsetTransform) else {
            clearRounding()
            return
        }

        if roundingMaskLayer == nil {
            roundingMaskLayer = CAShapeLayer()
            roundingMaskLayer?.fillRule = .evenOdd
            layer.mask = roundingMaskLayer
        }

        roundingMaskLayer?.path = translatedPath
        needsReapplyRounding = false
    }

    private func clearRounding() {
        layer.mask = nil
        roundingMaskLayer = nil
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        if let attributes = currentAttributes, needsReapplyRounding {
            applyRounding(with: attributes)
        }
    }
}
