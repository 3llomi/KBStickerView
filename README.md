# KBStickerView

[![CI Status](https://img.shields.io/travis/3llomi/KBStickerView.svg?style=flat)](https://travis-ci.org/3llomi/KBStickerView)
[![Version](https://img.shields.io/cocoapods/v/KBStickerView.svg?style=flat)](https://cocoapods.org/pods/KBStickerView)
[![License](https://img.shields.io/cocoapods/l/KBStickerView.svg?style=flat)](https://cocoapods.org/pods/KBStickerView)
[![Platform](https://img.shields.io/cocoapods/p/KBStickerView.svg?style=flat)](https://cocoapods.org/pods/KBStickerView)


## Demo
<p align="center">
<img src="etc/demo.gif" height="500" alt="demo image" />
</p>

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Installation

KBStickerView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'KBStickerView'
```


## Usage

```swift
let kbstickerView = KBStickerView()
view.addSubview(kbstickerView)

let sitckerPack1: [Sticker] = [
    Sticker(data: "ic_recent", resourceType: .assets),
    Sticker(data: "ic_sticker", resourceType: .assets)
]

let stickerCategories: [StickerCategory] = [
        StickerCategory(stickers: sitckerPack1, icon: "ic_sticker", iconResourceType: .assets)
    ]
    
    let stickerProvider = StickerProvider(stickerCategories: stickerCategories, stickerDelegate: self, recentsEnabled: true)
    
    kbstickerView.stickerProvider = stickerProvider
    
```

You are responsible for loading stickers images and Sticker Categories images, you can do that by conforming to Protocols

```swift
extension ViewController: StickerProviderDelegate {

    func didClickSticker(sticker: Sticker) {
        dataSource.append(sticker)
        tableView.reloadData()
    }

    func didChangePage(category: StickerCategory) {

    }

    func willLoadSticker(imageView: UIImageView, sticker: Sticker) {

        if sticker.resourceType == .assets {
            let stickerData = sticker.data
            let stickerImage = UIImage(named: stickerData)
            imageView.image = stickerImage
        }
    }

    func willLoadStickerCategory(imageView: UIImageView, stickerCategory: StickerCategory, selected: Bool) {
        if stickerCategory.iconResourceType == .assets {
            let icon = stickerCategory.icon
            imageView.image = UIImage(named: icon)
        }
    }

}
```

## Customization
it's recommended to do this customizaion **Before** 
``kbstickerView.stickerProvider = stickerProvider``

```swift
    kbstickerView.categoriesViewBackground = .red
    kbstickerView.selectedCategoryIconBackground = .brown
    kbstickerView.categoryIconColorActive = .blue
    kbstickerView.categoryIconColorNotActive = .black
    kbstickerView.categoryIconSize = CGSize(width: 30, height: 30)
    kbstickerView.recentCategoryIcon = "ic_recent"
    kbstickerView.recentCategoryResourceType = .assets

    kbstickerView.stickerItemSize = CGSize(width: 100, height: 100)
    kbstickerView.stickerPageBackground = .black
```

## Note:
since `willLoadStickerCategory` will be called in your App, you have to have the default icon included `ic_recent` in your Assets folder, or just change it to the icon you need.

## TODO
1. Optimize Sample App, especially the UI
2. Add a View when there are no Stickers in recents 

## Author

AbdulAlim Rajjoub

## License

KBStickerView is available under the MIT license. See the LICENSE file for more info.
