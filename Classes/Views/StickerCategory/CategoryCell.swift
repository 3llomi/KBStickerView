//
//  CategoryCell.swift
//  KBSticker
//
//  Created by Devlomi on 3/8/21.
//

import UIKit

private let HighlightedBackgroundViewSize = CGFloat(30)
internal class CategoryCell: UICollectionViewCell {
    
    weak var stickerProviderDelegate:StickerProviderDelegate?=nil
    
    
    var selectedCategoryBackground = SelectedCategoryBackground{
        didSet{
            highlightedBackgroundView.backgroundColor = selectedCategoryBackground
        }
    }
    
    var categoryColorNotActive = CategoryColorNotActive{
        didSet{
            stickerImageView.tintColor = categoryColorNotActive
        }
    }
    var categoryColorActive = CategoryColorActive
    
    

    private var highlightedBackgroundView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    private lazy var stickerImageView: UIImageView = {
        let stickerImageView = UIImageView()
        stickerImageView.contentMode = .center
        return stickerImageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override var isHighlighted: Bool {
        didSet {
            highlightedBackgroundView.isHidden = !isHighlighted
            stickerImageView.tintColor = isHighlighted ? categoryColorActive : categoryColorNotActive
        }
    }
    
    override var isSelected: Bool {
        didSet {
            highlightedBackgroundView.isHidden = !isSelected
            stickerImageView.tintColor = isSelected ? categoryColorActive : categoryColorNotActive
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = min(HighlightedBackgroundViewSize, contentView.bounds.width)
        highlightedBackgroundView.frame.size.width = size
        highlightedBackgroundView.frame.size.height = size
        highlightedBackgroundView.frame.origin.x = contentView.center.x - size/2
        highlightedBackgroundView.frame.origin.y = contentView.center.y - size/2
        
        highlightedBackgroundView.layer.cornerRadius = highlightedBackgroundView.frame.width/2
        
        stickerImageView.frame = contentView.bounds
    }
    
    
    internal func setStickerImage(_ category: StickerCategory) {
        stickerProviderDelegate?.willLoadStickerCategory(imageView: stickerImageView,stickerCategory: category,selected: isSelected)
        
    }
    
    
    private func setupView() {
        contentView.addSubview(highlightedBackgroundView)
        contentView.addSubview(stickerImageView)
        highlightedBackgroundView.backgroundColor = selectedCategoryBackground
        stickerImageView.tintColor = categoryColorNotActive

        
    }
    
}
