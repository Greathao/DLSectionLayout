//
//  DLSectionLayoutDelegate.swift
//  DLSectionLayout
//
//  Created by liuhao on 2025/6/18.
//

import Foundation
// 需求：支持多种
public protocol DLSectionLayoutDelegate: AnyObject {
    
    /// 容器层圆角，4个角分别是否启用
    func collectionView(_ collectionView: UICollectionView, layout:  DLSectionLayout, cornerRadiiForSection section: Int) -> DLCornerRadii
    
    /// 容器层四边内边距
    func collectionView(_ collectionView: UICollectionView, layout:  DLSectionLayout, containerInsetsForSection section: Int) -> UIEdgeInsets
    
    /// 容器层背景颜色（如果有图片，图片优先）
    func collectionView(_ collectionView: UICollectionView, layout:  DLSectionLayout, backgroundColorForSection section: Int) -> DLBackgroundGradient?
    
    /// 容器层背景图片名或url（可选）
    func collectionView(_ collectionView: UICollectionView, layout:  DLSectionLayout, backgroundImageURLStringForSection section: Int) -> String?
    
    /// 每组最小行间距（纵向）
    func collectionView(_ collectionView: UICollectionView, layout:  DLSectionLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    
    /// 每组最小列间距（横向）
    func collectionView(_ collectionView: UICollectionView, layout:  DLSectionLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    
    /// 每组 header 高度
    func collectionView(_ collectionView: UICollectionView, layout:  DLSectionLayout, referenceSizeForHeaderInSection section: Int) -> CGFloat
    
    /// 每组 Footer 高度
    func collectionView(_ collectionView: UICollectionView, layout:  DLSectionLayout, referenceSizeForFooterInSection section: Int) -> CGFloat
    
    /// 每组 大小
    func collectionView(_ collectionView: UICollectionView, layout:  DLSectionLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    
    /// 每组布局的排布方向（水平 / 垂直）
    func collectionView(_ collectionView: UICollectionView, layout:  DLSectionLayout, layoutDirectionForSection section: Int) ->  DLSectionLayoutDirection
    
    /// 每组行数（在水平排列中表示垂直方向的数量）
    func collectionView(_ collectionView: UICollectionView, layout:  DLSectionLayout, numberOfRowsInSection section: Int) -> Int
    
    /// 每组列数（在垂直排列中表示水平方向的数量）
    func collectionView(_ collectionView: UICollectionView, layout:  DLSectionLayout, numberOfColumnsInSection section: Int) -> Int
    
    /// 每组是否为瀑布流布局（仅适用于纵向排列）
    func collectionView(_ collectionView: UICollectionView, layout:  DLSectionLayout, isWaterfallFlowForSection section: Int) -> Bool
}
