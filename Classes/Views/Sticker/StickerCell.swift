//
//  StickerCell.swift
//  KBSticker
//
//  Created by Devlomi on 3/6/21.
//

import UIKit
class StickerCell: UICollectionViewCell {
    
    weak var delegate:StickerProviderDelegate?=nil

    private var stickerImgView:UIImageView = {
        let stickerImgView = UIImageView()
        stickerImgView.translatesAutoresizingMaskIntoConstraints = false
        return stickerImgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    
    private func setupView() {
        addSubview(stickerImgView)

        stickerImgView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stickerImgView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stickerImgView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stickerImgView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }

    
    func setSticker(sticker:Sticker)  {
        delegate?.willLoadSticker(imageView: stickerImgView,sticker: sticker)
    }
}
