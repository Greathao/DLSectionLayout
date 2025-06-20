//
//  DLSectionLayout.swift
//  DLSectionLayout
//
//  Created by liuhao on 2025/6/18.
//
 
/// 自定义的 CollectionView 布局，支持背景图、圆角、瀑布流、横竖排、行列数等功能
public  class DLSectionLayout: UICollectionViewLayout {
    /// 布局的代理，用于从外部获取每个 section 的自定义配置
    public weak var delegate:  DLSectionLayoutDelegate?
    /// 缓存所有计算得到的布局属性（包括 item、header、footer、decoration）
    private var cache: [UICollectionViewLayoutAttributes] = []
    /// 管理每个 section 的布局区域和元素位置
    private var geometryManager = DLSectionGeometryManager()
    /// 当前内容的总高度
    private var contentHeight: CGFloat = 0
    /// 当前 CollectionView 的宽度
    private var contentWidth: CGFloat {
        return collectionView?.bounds.width ?? 0
    }
    /// 指定用于布局属性的类型（支持圆角的属性类）
    public override class var layoutAttributesClass: AnyClass {
        return DLRoundedLayoutAttributes.self
    }
    /// 默认的 section 内边距
    var sectionInset: UIEdgeInsets = .init(top: 12, left:  12, bottom:  12, right:  12)
    /// 默认的行间距
    var minimumLineSpacing: CGFloat = 7.0
    /// 默认的列间距
    var minimumInteritemSpacing: CGFloat = 7.0
    
    public override init() {
        super.init()
        // 注册 decoration 背景视图
        register(DLSectionBackgroundView.self, forDecorationViewOfKind: DLSectionBackgroundView.kind)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// 每次 layout 更新前都会调用，用于准备所有布局信息
    public override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        // 清空缓存和旧数据
        cache.removeAll()
        geometryManager.reset()
        contentHeight = 0
        
        let numberOfSections = collectionView.numberOfSections
        
        for section in 0..<numberOfSections {
            let numberOfItems = collectionView.numberOfItems(inSection: section)
            let minimumLineSpacingThisSection = delegate?.collectionView(collectionView, layout: self, minimumLineSpacingForSectionAt: section) ?? self.minimumLineSpacing
            let minimumInteritemSpacingThisSection = delegate?.collectionView(collectionView, layout: self, minimumInteritemSpacingForSectionAt: section) ?? self.minimumInteritemSpacing
            let headerHeight = delegate?.collectionView(collectionView, layout: self, referenceSizeForHeaderInSection: section) ?? 0
            let footerHeight = delegate?.collectionView(collectionView, layout: self, referenceSizeForFooterInSection: section) ?? 0
            let containerInsets = delegate?.collectionView(collectionView, layout: self, containerInsetsForSection: section) ?? self.sectionInset
            let cornerRadii = delegate?.collectionView(collectionView, layout: self, cornerRadiiForSection: section) ?? DLCornerRadii.zero
            
            let sectionStartY = contentHeight
            var currentY = sectionStartY + containerInsets.top
            let contentWidthWithoutInset = contentWidth - containerInsets.left - containerInsets.right
            
            // 构建 Header 属性
            if headerHeight > 0 {
                let headerIndexPath = IndexPath(item: 0, section: section)
                let headerAttr = DLRoundedLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: headerIndexPath)
                headerAttr.frame = CGRect(x: containerInsets.left, y: currentY, width: contentWidthWithoutInset, height: headerHeight)
                headerAttr.zIndex = 3
                headerAttr.sectionIndex = section
                cache.append(headerAttr)
                geometryManager.addItem(headerAttr, forSection: section)
            }
            currentY += headerHeight
            
           // 获取布局方向（横向/竖向）、行列数、是否瀑布流
            let direction = delegate?.collectionView(collectionView, layout: self, layoutDirectionForSection: section) ?? .vertical
            let rows = delegate?.collectionView(collectionView, layout: self, numberOfRowsInSection: section) ?? 1
            let columns = delegate?.collectionView(collectionView, layout: self, numberOfColumnsInSection: section) ?? 1
            let isWaterfall = delegate?.collectionView(collectionView, layout: self, isWaterfallFlowForSection: section) ?? false
            
            switch direction {
            case .vertical:
                if isWaterfall {
                    // 竖向瀑布流布局
                    var columnHeights = Array(repeating: currentY, count: columns)
                    for itemIndex in 0..<numberOfItems {
                        let indexPath = IndexPath(item: itemIndex, section: section)
                        let itemSize = delegate?.collectionView(collectionView, layout: self, sizeForItemAt: indexPath) ?? .zero
                        let attr = DLRoundedLayoutAttributes(forCellWith: indexPath)
                        let minColumnIndex = columnHeights.enumerated().min(by: { $0.element < $1.element })?.offset ?? 0
                        let x = containerInsets.left + CGFloat(minColumnIndex) * (itemSize.width + minimumInteritemSpacingThisSection)
                        let currentColumnY = columnHeights[minColumnIndex]
                        let y = (currentColumnY == currentY) ? currentColumnY : currentColumnY + minimumLineSpacingThisSection
                        attr.frame = CGRect(x: x, y: y, width: itemSize.width, height: itemSize.height)
                        attr.zIndex = 4
                        attr.sectionIndex = section
                        cache.append(attr)
                        geometryManager.addItem(attr, forSection: section)
                        columnHeights[minColumnIndex] = attr.frame.maxY
                    }
                    currentY = columnHeights.max() ?? currentY
                } else {
                    // 普通竖向布局（固定行列）
                    for row in 0..<rows {
                        for col in 0..<columns {
                            let itemIndex = row * columns + col
                            if itemIndex >= numberOfItems { continue }
                            let indexPath = IndexPath(item: itemIndex, section: section)
                            let itemSize = delegate?.collectionView(collectionView, layout: self, sizeForItemAt: indexPath) ?? .zero
                            let attr = DLRoundedLayoutAttributes(forCellWith: indexPath)
                            let x = containerInsets.left + CGFloat(col) * (itemSize.width + minimumInteritemSpacingThisSection)
                            let y = currentY + CGFloat(row) * (itemSize.height + minimumLineSpacingThisSection)
                            attr.frame = CGRect(x: x, y: y, width: itemSize.width, height: itemSize.height)
                            attr.zIndex = 4
                            attr.sectionIndex = section
                            cache.append(attr)
                            geometryManager.addItem(attr, forSection: section)
                        }
                    }
                    let itemHeight = delegate?.collectionView(collectionView, layout: self, sizeForItemAt: IndexPath(item: 0, section: section)).height ?? 0
                    if rows > 0 {
                        currentY += CGFloat(rows) * itemHeight + CGFloat(max(rows - 1, 0)) * minimumLineSpacingThisSection
                    }
                    
                }
            case .horizontal:
                // 横向布局
                for col in 0..<columns {
                    for row in 0..<rows {
                        let itemIndex = col * rows + row
                        if itemIndex >= numberOfItems { continue }
                        let indexPath = IndexPath(item: itemIndex, section: section)
                        let itemSize = delegate?.collectionView(collectionView, layout: self, sizeForItemAt: indexPath) ?? .zero
                        let attr = DLRoundedLayoutAttributes(forCellWith: indexPath)
                        let x = containerInsets.left + CGFloat(col) * (itemSize.width + minimumInteritemSpacingThisSection)
                        let y = currentY + CGFloat(row) * (itemSize.height + minimumLineSpacingThisSection)
                        attr.frame = CGRect(x: x, y: y, width: itemSize.width, height: itemSize.height)
                        attr.zIndex = 4
                        attr.sectionIndex = section
                        cache.append(attr)
                        geometryManager.addItem(attr, forSection: section)
                    }
                }
                let itemHeight = delegate?.collectionView(collectionView, layout: self, sizeForItemAt: IndexPath(item: 0, section: section)).height ?? 0
                if rows > 0 {
                    currentY += CGFloat(rows) * itemHeight + CGFloat(max(rows - 1, 0)) * minimumLineSpacingThisSection
                }
             }
            
            // Footer
            if footerHeight > 0 {
                let footerIndexPath = IndexPath(item: 0, section: section)
                let footerAttr = DLRoundedLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, with: footerIndexPath)
                footerAttr.frame = CGRect(x: containerInsets.left, y: currentY, width: contentWidthWithoutInset, height: footerHeight)
                footerAttr.zIndex = 3
                footerAttr.sectionIndex = section
                cache.append(footerAttr)
                geometryManager.addItem(footerAttr, forSection: section)
            }
            currentY += footerHeight
            
            // Decoration 背景
            let decorationAttr = DLSectionBackgroundLayoutAttributes(forDecorationViewOfKind: DLSectionBackgroundView.kind, with: IndexPath(item: 0, section: section))
            decorationAttr.frame = CGRect(x: 0, y: sectionStartY, width: contentWidth, height: (currentY - sectionStartY) + containerInsets.bottom)
            decorationAttr.zIndex = 0
            decorationAttr.containerInsets = containerInsets
            decorationAttr.cornerRadii = cornerRadii
            decorationAttr.backgroundGradient = delegate?.collectionView(collectionView, layout: self, backgroundColorForSection: section)
            decorationAttr.backgroundImageURLString = delegate?.collectionView(collectionView, layout: self, backgroundImageURLStringForSection: section)
            cache.append(decorationAttr)
            
            contentHeight = currentY + containerInsets.bottom
        }
       // 计算每个元素的圆角信息
        calculateRoundingCorners()
    }
 
    private func calculateRoundingCorners() {
        guard let collectionView = collectionView else { return }

        for attributes in cache {
            guard let roundedAttr = attributes as? DLRoundedLayoutAttributes else { continue }
            let section = roundedAttr.sectionIndex

            let cornerRadii = delegate?.collectionView(collectionView, layout: self, cornerRadiiForSection: section) ?? .zero
            guard cornerRadii.hasAnyCorner else { continue }

            let containerInsets = delegate?.collectionView(collectionView, layout: self, containerInsetsForSection: section) ?? self.sectionInset

            let decorationIndexPath = IndexPath(item: 0, section: section)
            guard let decorationAttr = cache.first(where: {
                $0.representedElementCategory == .decorationView &&
                $0.indexPath == decorationIndexPath
            }) else { continue }

            let sectionFrame = decorationAttr.frame.inset(by: containerInsets)
            let frameInSection = roundedAttr.frame.offsetBy(dx: -sectionFrame.minX, dy: -sectionFrame.minY)

            roundedAttr.sectionFrame = sectionFrame
            roundedAttr.frameInSection = frameInSection
            roundedAttr.sectionCornerRadii = cornerRadii
            roundedAttr.roundedClipPath = DLCornerCalculator.createRoundedPath(bounds: CGRect(origin: .zero, size: sectionFrame.size), cornerRadii: cornerRadii).cgPath

            let (corners, radius) = DLCornerCalculator.calculateCorners(
                for: roundedAttr,
                in: section,
                sectionFrame: sectionFrame,
                cornerRadii: cornerRadii
            )

            roundedAttr.roundingCorners = corners
            roundedAttr.cornerRadius = radius
            roundedAttr.needsRounding = true
        }
    }
 
    public override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cache.filter { $0.frame.intersects(rect) }
    }
    
    public override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache.first { $0.representedElementCategory == .cell && $0.indexPath == indexPath }
    }
    
    public override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache.first {
            $0.representedElementCategory == .supplementaryView &&
            $0.indexPath == indexPath &&
            $0.representedElementKind == elementKind
        }
    }
    
    public override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache.first {
            $0.representedElementCategory == .decorationView &&
            $0.indexPath == indexPath &&
            $0.representedElementKind == elementKind
        }
    }
}
