//
//  StickerCell.swift
//  KBStickerView_Example
//
//  Created by Devlomi on 3/14/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import KBStickerView
class StickerCell: UITableViewCell {
    internal var stickerImageView:UIImageView = {
       let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
 
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView(){
        addSubview(stickerImageView)
        stickerImageView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        stickerImageView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        
        stickerImageView.topAnchor.constraint(equalTo: topAnchor,constant: 16).isActive = true
        stickerImageView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: 16).isActive = true
        stickerImageView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16).isActive = true
    }
    
    func setSticker(_ sticker:Sticker){
        stickerImageView.image = UIImage(named: sticker.data)
    }
}
