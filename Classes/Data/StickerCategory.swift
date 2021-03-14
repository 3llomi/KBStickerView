//
//  StickerCategory.swift
//  KBSticker
//
//  Created by Devlomi on 3/8/21.
//

import UIKit
public struct StickerCategory {
    
    public init(stickers: [Sticker], icon: String, iconResourceType: ResourceType) {
        self.stickers = stickers
        self.icon = icon
        self.iconResourceType = iconResourceType
    }
    

    public var stickers:[Sticker]
    public let icon:String
    public let iconResourceType:ResourceType
    

}
