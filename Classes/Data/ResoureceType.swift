//
//  ResoureceSource.swift
//  KBSticker
//
//  Created by Devlomi on 3/9/21.
//

import Foundation

public enum ResourceType:Int,Codable{
 
    
    /*
     remote url
     */
    case url
    
    /*
     local asset, eg: UIImage(named:)
     */
    case assets
    
    
}
