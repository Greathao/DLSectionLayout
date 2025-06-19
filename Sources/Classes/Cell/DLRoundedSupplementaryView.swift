
//
//  DLRoundedSupplementaryView.swift
//  DLSectionLayout
//
//  Created by liuhao on 2025/6/19.
//



// MARK: - 支持圆角的 Header/Footer 基类 
open class DLRoundedSupplementaryView: UICollectionReusableView {
    private var roundingMaskLayer: CAShapeLayer?
    private var currentAttributes: DLRoundedLayoutAttributes?

    


    open override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)

        guard let roundedAttr = layoutAttributes as? DLRoundedLayoutAttributes else {
            currentAttributes = nil
            clearRounding()
            return
        }

        currentAttributes = roundedAttr
        applyRounding(with: roundedAttr)
    }

    private func applyRounding(with attributes: DLRoundedLayoutAttributes) {
        guard !bounds.isEmpty else {
            DispatchQueue.main.async { [weak self] in
                guard let self = self, let attr = self.currentAttributes else { return }
                self.applyRounding(with: attr)
            }
            return
        }

        guard let clipPath = attributes.roundedClipPath else {
            clearRounding()
            return
        }

        // ❗关键：将 section 的路径转换为本 view 的坐标系
        // 这个转换逻辑要保持：sectionFrame 与当前 view frame 的偏移
        let dx = attributes.frame.minX - attributes.sectionFrame.minX
        let dy = attributes.frame.minY - attributes.sectionFrame.minY
        let transform = CGAffineTransform(translationX: -dx, y: -dy)

        let path = UIBezierPath(cgPath: clipPath)
        path.apply(transform)

        if roundingMaskLayer == nil {
            roundingMaskLayer = CAShapeLayer()
            layer.mask = roundingMaskLayer
        }

        roundingMaskLayer?.path = path.cgPath
    }

    private func clearRounding() {
        layer.mask = nil
        roundingMaskLayer = nil
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        if let attributes = currentAttributes {
            applyRounding(with: attributes)
        } else {
            clearRounding() // 清掉之前残留
        }
    }


}
