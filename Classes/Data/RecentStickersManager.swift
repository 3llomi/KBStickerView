//
//  RecentStickerSaver.swift
//  KBSticker
//
//  Created by Devlomi on 3/9/21.
//

import Foundation
class RecentStickersManager {
    
    lazy var userDefaults:UserDefaults = {
        return UserDefaults.standard
    }()
    
    private let stickersKey = "kbSticker"
    
    func saveSticker(sticker:Sticker) {
        
        var recentStickers = getRecentStickers()

        recentStickers.insert(sticker, at: 0)
        let encoded = recentStickers.map { try? JSONEncoder().encode($0) }
        userDefaults.set(encoded, forKey: stickersKey)
      

    }
    
    func getRecentStickers() -> [Sticker] {
        guard let encodedData = UserDefaults.standard.array(forKey: stickersKey) as? [Data] else {
            return []
        }

        return encodedData.map { try! JSONDecoder().decode(Sticker.self, from: $0) }
        
        
    }
    

    
    
}
