//
//  StickerProvider.swift
//  KBSticker
//
//  Created by Devlomi on 3/8/21.
//

import UIKit
public struct StickerProvider {
    public init(stickerCategories: [StickerCategory], stickerDelegate: StickerProviderDelegate, recentsEnabled: Bool) {
        self.stickerCategories = stickerCategories
        self.stickerDelegate = stickerDelegate
        self.recentsEnabled = recentsEnabled
    }
    
    public let stickerCategories:[StickerCategory]
    
    public let stickerDelegate:StickerProviderDelegate
    
    public let recentsEnabled:Bool
    
}
