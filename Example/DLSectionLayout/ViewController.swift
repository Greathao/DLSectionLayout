//
//  ViewController.swift
//  DLSectionLayout
//
//  Created by DLSectionLayout on 06/18/2025.
//  Copyright (c) 2025 DLSectionLayout. All rights reserved.
//
 
import UIKit
import DLSectionLayout
 

class TestCell: DLRoundedCollectionViewCell {}

class ViewController: UIViewController {
    private let fpsMonitor = FPSMonitor()

    lazy var collectionView: UICollectionView = {
        let layout = DLSectionLayout()
        layout.delegate = self
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.register(TestCell.self, forCellWithReuseIdentifier: "cell")
        cv.register(DLRoundedSupplementaryView.self,
                    forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                    withReuseIdentifier: "header")
        cv.register(DLRoundedSupplementaryView.self,
                    forSupplementaryViewOfKind: UICollectionElementKindSectionFooter,
                    withReuseIdentifier: "footer")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        fpsMonitor.attach(to: view)
    }
    deinit {
           fpsMonitor.detach()
       }
   }


extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 模拟item数量多样性
        switch section {
        case 0: return 3
        case 1: return 10
        case 2: return 5
        case 3: return 12
        case 4: return 7
        case 5: return 1
        case 6: return 20
        case 7: return 4
        case 8: return 9
        case 9: return 6
        case 10: return 8
        case 11: return 1
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TestCell
        let colors: [UIColor] = [
            .systemRed, .systemGreen, .systemBlue,
            .systemOrange, .systemPurple, .systemTeal,
            .systemPink, .systemYellow, .systemTeal,
            .brown, .cyan, .magenta
        ]
        cell?.backgroundColor = colors[indexPath.section % colors.count].withAlphaComponent(0.25)
        return cell ?? TestCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let reuseId = (kind == UICollectionElementKindSectionHeader) ? "header" : "footer"
        let color = (kind == UICollectionElementKindSectionHeader) ? UIColor.darkGray : UIColor.lightGray
        let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                           withReuseIdentifier: reuseId,
                                                                           for: indexPath) as! DLRoundedSupplementaryView
        reusableView.backgroundColor = color.withAlphaComponent(0.4)
        return reusableView
    }
}

extension ViewController: DLSectionLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout: DLSectionLayout,
                        cornerRadiiForSection section: Int) -> DLCornerRadii {
        switch section {
        case 0:  return DLCornerRadii(topLeft: 15, topRight: 0, bottomLeft: 15, bottomRight: 0)
        case 1:  return DLCornerRadii(topLeft: 0, topRight: 15, bottomLeft: 0, bottomRight: 15)
        case 2:  return DLCornerRadii(topLeft: 10, topRight: 10, bottomLeft: 10, bottomRight: 10)
        case 3:  return DLCornerRadii(topLeft: 0, topRight: 0, bottomLeft: 0, bottomRight: 0)
        case 4:  return DLCornerRadii(topLeft: 25, topRight: 25, bottomLeft: 0, bottomRight: 0)
        case 5:  return DLCornerRadii(topLeft: 30, topRight: 30, bottomLeft: 30, bottomRight: 30)
        case 6:  return DLCornerRadii(topLeft: 0, topRight: 15, bottomLeft: 15, bottomRight: 0)
        case 7:  return DLCornerRadii(topLeft: 20, topRight: 20, bottomLeft: 20, bottomRight: 0)
        case 8:  return DLCornerRadii(topLeft: 5, topRight: 5, bottomLeft: 5, bottomRight: 5)
        case 9:  return DLCornerRadii(topLeft: 0, topRight: 0, bottomLeft: 15, bottomRight: 15)
        case 10: return DLCornerRadii(topLeft: 40, topRight: 0, bottomLeft: 40, bottomRight: 0)
        case 11: return DLCornerRadii(topLeft: 50, topRight: 50, bottomLeft: 50, bottomRight: 50)
        default: return DLCornerRadii(topLeft: 0, topRight: 0, bottomLeft: 0, bottomRight: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout: DLSectionLayout,
                        containerInsetsForSection section: Int) -> UIEdgeInsets {
        switch section {
        case 0: return UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
        case 1: return UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
        case 2: return UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
        case 3: return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        case 4: return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        case 5: return UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
        case 6: return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        case 7: return UIEdgeInsets(top: 18, left: 10, bottom: 18, right: 10)
        case 8: return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        case 9: return UIEdgeInsets(top: 22, left: 22, bottom: 22, right: 22)
        case 10: return UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        case 11: return UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40)
        default: return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout: DLSectionLayout,
                        backgroundColorForSection section: Int) -> DLBackgroundGradient? {
        switch section {
        case 0: return DLBackgroundGradient(colors: [.red.withAlphaComponent(0.3), .orange.withAlphaComponent(0.3)], direction: .horizontal)
        case 1: return DLBackgroundGradient(colors: [.green.withAlphaComponent(0.3), .blue.withAlphaComponent(0.3)], direction: .vertical)
        case 2: return DLBackgroundGradient(colors: [.purple.withAlphaComponent(0.3), .magenta.withAlphaComponent(0.3)], direction: .diagonalLeftToRight)
        case 3: return nil
        case 4: return DLBackgroundGradient(colors: [.cyan.withAlphaComponent(0.3), .white.withAlphaComponent(0.3)], direction: .diagonalRightToLeft)
        case 5: return nil
        case 6: return DLBackgroundGradient(colors: [.brown.withAlphaComponent(0.3), .black.withAlphaComponent(0.3)], direction: .horizontal)
        case 7: return DLBackgroundGradient(colors: [.systemPink.withAlphaComponent(0.3), .systemYellow.withAlphaComponent(0.3)], direction: .vertical)
        case 8: return DLBackgroundGradient(colors: [.darkGray.withAlphaComponent(0.3), .lightGray.withAlphaComponent(0.3)], direction: .horizontal)
        case 9: return DLBackgroundGradient(colors: [.orange.withAlphaComponent(0.3), .red.withAlphaComponent(0.3)], direction: .vertical)
        case 10: return DLBackgroundGradient(colors: [.magenta.withAlphaComponent(0.3), .purple.withAlphaComponent(0.3)], direction: .diagonalLeftToRight)
        case 11: return nil
        default: return nil
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout: DLSectionLayout,
                        backgroundImageURLStringForSection section: Int) -> String? {
        // 给部分section配置背景图URL占位
        switch section {
        case 3:
            return "https://picsum.photos/400/150"
        case 5:
            return "https://picsum.photos/350/200"
        case 9:
            return "https://picsum.photos/300/300"
        default:
            return nil
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout: DLSectionLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0, 7: return 10
        case 1, 6: return 12
        case 2, 10: return 8
        case 3, 5: return 5
        case 4: return 15
        case 8, 9: return 18
        case 11: return 20
        default: return 8
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout: DLSectionLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0, 7: return 6
        case 1, 6: return 12
        case 2, 10: return 8
        case 3, 5: return 5
        case 4: return 10
        case 8, 9: return 12
        case 11: return 20
        default: return 8
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout: DLSectionLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0, 5, 7: return 40
        case 2, 8, 11: return 30
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout: DLSectionLayout,
                        referenceSizeForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 1, 4, 9: return 40
        case 3, 6, 10: return 30
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout: DLSectionLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        switch indexPath.section {
        case 0:
            return CGSize(width: 100, height: 100)
        case 1:
            let totalSpacing = 16 + 16 + 12
            let width = (screenWidth - CGFloat(totalSpacing)) / 2
            return CGSize(width: width, height: 120)
        case 2:
            return CGSize(width: screenWidth - 32, height: 80)
        case 3:
            let totalSpacing = 16 + 16 + 5 * 3
            let width = (screenWidth - CGFloat(totalSpacing)) / 4
            return CGSize(width: width, height: 90)
        case 4:
            let totalSpacing = 15 + 15 + 10 * 2
            let width = (screenWidth - CGFloat(totalSpacing)) / 3
            return CGSize(width: width, height: 140)
        case 5:
            return CGSize(width: screenWidth - 50, height: 150)
        case 6:
            let totalSpacing = 16 + 16 + 12 * 4
            let width = (screenWidth - CGFloat(totalSpacing)) / 5
            return CGSize(width: width, height: 100)
        case 7:
            return CGSize(width: 120, height: 120)
        case 8:
            let totalSpacing = 12 * 2 + 8 * 2
            let width = (screenWidth - CGFloat(totalSpacing)) / 3
            return CGSize(width: width, height: 110)
        case 9:
            return CGSize(width: screenWidth - 44, height: 180)
        case 10:
            let totalSpacing = 30 + 30 + 8 * 2
            let width = (screenWidth - CGFloat(totalSpacing)) / 2
            return CGSize(width: width, height: 90)
        case 11:
            return CGSize(width: screenWidth - 80, height: 160)
        default:
            return CGSize(width: 100, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout: DLSectionLayout,
                        layoutDirectionForSection section: Int) -> DLSectionLayoutDirection {
        switch section {
        case 0, 7:
            return .horizontal
        case 4, 9:
            return .vertical
        default:
            return .vertical
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout: DLSectionLayout,
                        numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 5
        case 2: return 5
        case 3: return 3
        case 4: return 2
        case 5: return 1
        case 6: return 2
        case 7: return 1
        case 8: return 3
        case 9: return 1
        case 10: return 4
        case 11: return 1
        default: return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout: DLSectionLayout,
                        numberOfColumnsInSection section: Int) -> Int {
        switch section {
        case 0: return 3
        case 1: return 2
        case 2: return 1
        case 3: return 4
        case 4: return 3
        case 5: return 1
        case 6: return 5
        case 7: return 4
        case 8: return 3
        case 9: return 1
        case 10: return 2
        case 11: return 1
        default: return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout: DLSectionLayout,
                        isWaterfallFlowForSection section: Int) -> Bool {
        // 3个section使用瀑布流布局
        return [3, 6, 9].contains(section)
    }
}
