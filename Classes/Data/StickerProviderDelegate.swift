//
//  StickerLoader.swift
//  KBSticker
//
//  Created by Devlomi on 3/8/21.
//

import UIKit
public protocol StickerProviderDelegate:class {
    func willLoadSticker(imageView:UIImageView,sticker:Sticker)
    func willLoadStickerCategory(imageView:UIImageView,stickerCategory:StickerCategory,selected:Bool)
    func didClickSticker(sticker:Sticker)
    func didChangePage(category:StickerCategory)
}
