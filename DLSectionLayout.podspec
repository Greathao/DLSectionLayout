#
# Be sure to run `pod lib lint DLSectionLayout.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DLSectionLayout'
  s.version          = '0.1.0'
  s.summary          = '支持 Section 背景图和圆角的灵活 UICollectionViewLayout 布局库'

  s.description      = <<-DESC
DLSectionLayout 是一个灵活强大的 UICollectionView 布局解决方案，专为电商首页楼层类需求设计。
支持 Section 背景图、渐变背景、圆角裁剪、Header/Footer、横向 & 瀑布流布局等特性。
适合构建现代感强、模块清晰的 CollectionView UI
  DESC

  s.homepage         = 'https://github.com/Greathao/DLSectionLayout.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'DLSectionLayout' => '704550535@qq.com' }
  s.source           = { :git => 'https://github.com/Greathao/DLSectionLayout.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'

  # 主体代码
  s.source_files = 'Sources/**/*.{swift}'

  # 图片等资源（如有）
    #s.resource_bundles = {
    #  'DLSectionLayout' => ['Sources/Assets/**/*']
   # }

  # 依赖（根据你使用的库，如 RoundedImage 或异步加载）
  s.dependency 'Kingfisher', '~> 6.0'
end
