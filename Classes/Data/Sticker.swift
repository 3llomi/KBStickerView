//
//  Sticker.swift
//  KBSticker
//
//  Created by Devlomi on 3/8/21.
//

import UIKit

public struct Sticker:Codable {
    public init(data: String, resourceType: ResourceType) {
        self.data = data
        self.resourceType = resourceType
    }
    
    public let data:String
    public let resourceType:ResourceType
}
