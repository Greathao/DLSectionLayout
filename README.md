# DLSectionLayout

[![CI Status](https://img.shields.io/travis/DLSectionLayout/DLSectionLayout.svg?style=flat)](https://travis-ci.org/DLSectionLayout/DLSectionLayout)
[![Version](https://img.shields.io/cocoapods/v/DLSectionLayout.svg?style=flat)](https://cocoapods.org/pods/DLSectionLayout)
[![License](https://img.shields.io/cocoapods/l/DLSectionLayout.svg?style=flat)](https://cocoapods.org/pods/DLSectionLayout)
[![Platform](https://img.shields.io/cocoapods/p/DLSectionLayout.svg?style=flat)](https://cocoapods.org/pods/DLSectionLayout)

---

## 📦 What is DLSectionLayout?

**DLSectionLayout** 是一个高度灵活的 `UICollectionViewLayout`，专为电商首页楼层、内容模块化 UI 布局场景而设计。  
支持自定义 Section 背景图、圆角裁剪、Header/Footer 位置、横向/纵向/瀑布流等多种布局形式。

English:  
**DLSectionLayout** is a flexible and feature-rich layout system for UICollectionView. It is perfect for modular, floor-style UIs like e-commerce home pages.

---

## ✨ Features 特性

- ✅ 支持 Section 背景视图（支持渐变色或图片）
- ✅ 支持独立 Header / Footer 高度定义
- ✅ 支持圆角裁剪：可设置四角分别的圆角半径
- ✅ 横向布局 / 纵向布局 / 瀑布流布局
- ✅ 每个 Section 独立配置列数、间距、圆角等
- ✅ 支持 DecorationView 裁剪遮罩合成
- ✅ 适用于电商楼层、瀑布流 Feed 等场景

---

## 🚀 Usage 示例

```swift
let layout = DLSectionLayout()
layout.delegate = self
collectionView.collectionViewLayout = layout
```

实现协议 `DLSectionLayoutDelegate` 即可灵活配置每个 section：

```swift
func collectionView(_ collectionView: UICollectionView, layout: DLSectionLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 100, height: 120)
}

func collectionView(_ collectionView: UICollectionView, layout: DLSectionLayout, backgroundImageURLStringForSection section: Int) -> String? {
    return "https://example.com/bg.png"
}
```

---

## 📦 Installation

DLSectionLayout is available through [CocoaPods](https://cocoapods.org).  
To install it, simply add the following line to your Podfile:

```ruby
pod 'DLSectionLayout'
```

然后运行：

```bash
pod install
```

---

## 📱 Requirements

- iOS 10.0+
- Swift 5.0+
- Xcode 12+

---

## 🛠 Example 示例项目

To run the example project:

```bash
git clone https://github.com/DLSectionLayout/DLSectionLayout.git
cd Example
pod install
open Example.xcworkspace
```

---

## 👨‍💻 Author

DLSectionLayout – [704550535@qq.com](mailto:704550535@qq.com)

---

## 📄 License

DLSectionLayout is available under the MIT license.  
See the [LICENSE](./LICENSE) file for more info.
