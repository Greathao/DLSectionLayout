//
//  DLSectionBackgroundView.swift
//  DLSectionLayout
//
//  Created by liuhao on 2025/6/18.
//

import Kingfisher

final class DLSectionBackgroundView: UICollectionReusableView {
    static let kind = "DLSectionBackgroundView"

    private let containerView = UIView()
    private let imageView = UIImageView()
    private let gradientLayer = CAGradientLayer()
    private let maskLayer = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.layer.insertSublayer(gradientLayer, at: 0)

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        isUserInteractionEnabled = false
        backgroundColor = .clear

        // 这里关闭clipsToBounds，mask就够了
        containerView.clipsToBounds = false

        // 设置maskLayer到containerView.layer.mask
        containerView.layer.mask = maskLayer
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)

        guard let attr = layoutAttributes as? DLSectionBackgroundLayoutAttributes else { return }

        // 先设置containerView的frame
        containerView.frame = bounds.inset(by: attr.containerInsets)

        // imageView和layer同步frame
        imageView.frame = containerView.bounds
        gradientLayer.frame = containerView.bounds
        maskLayer.frame = containerView.bounds

        let path =  DLCornerCalculator.createRoundedPath(bounds: containerView.bounds, cornerRadii: attr.cornerRadii)
        maskLayer.path = path.cgPath

        // 设置背景图或渐变色
        if let urlStr = attr.backgroundImageURLString, let url = URL(string: urlStr) {
            imageView.isHidden = false
            gradientLayer.isHidden = true
            imageView.kf.setImage(with: url)
        } else if let gradient = attr.backgroundGradient, !gradient.colors.isEmpty {
            imageView.isHidden = true
            gradientLayer.isHidden = false
            gradientLayer.colors = gradient.colors.map { $0.cgColor }
            gradientLayer.startPoint = gradient.direction.startPoint
            gradientLayer.endPoint = gradient.direction.endPoint
        } else {
            imageView.isHidden = true
            gradientLayer.isHidden = true
        }
    }
}
