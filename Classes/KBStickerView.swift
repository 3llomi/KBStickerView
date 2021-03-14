//
//  KBStickerView.swift
//  KBSticker
//
//  Created by Devlomi on 3/6/21.
//

import UIKit

public class KBStickerView: UIView {

    public var categoryIconColorActive = CategoryColorActive{
        didSet{
            categoriesView.categoryColorActive = categoryIconColorActive
        }
    }
    public var categoryIconColorNotActive = CategoryColorActive{
        didSet{
            categoriesView.categoryColorNotActive = categoryIconColorNotActive
        }
    }
    
    public var selectedCategoryIconBackground = SelectedCategoryBackground{
        didSet{
            categoriesView.selectedCategoryBackground = selectedCategoryIconBackground
        }
    }
    
    public var categoryIconSize = CategoryIconSize{
        didSet{
            categoriesView.categoryIconSize = categoryIconSize
        }
    }
    
    public var categoriesViewBackground  = CategoriesViewBackground{
        didSet{
            categoriesView.categoriesViewBackground = categoriesViewBackground
        }
    }
     
    public var recentCategoryIcon = RecentCategoryIcon
    public var recentCategoryResourceType = RecentCategoryResourceType
     
    public var stickerItemSize = StickerItemSize{
        didSet{
            collectionView.stickerItemSize = stickerItemSize
        }
    }
    
    
    public var stickerPageBackground = StickerPageBackground{
        didSet{
            collectionView.stickerPageBackground = stickerPageBackground
        }
    }
     
  
     


    private lazy var recentStickersManager: RecentStickersManager = {
        return RecentStickersManager()
    }()


    private lazy var collectionView: StickerCollectionView = {
        let collectionView = StickerCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var categoriesView: StickerCategoriesView = {
        let cv = StickerCategoriesView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()


    public var stickerProvider: StickerProvider? {
        didSet {
            setupStickers(stickerProvider: stickerProvider!)
        }
    }


    convenience init(stickerProvider: StickerProvider) {
        self.init()

        self.stickerProvider = stickerProvider
        setupStickers(stickerProvider: stickerProvider)


    }
    
    
    
    private func setupStickers(stickerProvider: StickerProvider) {
        var stickerCategories = stickerProvider.stickerCategories

        if stickerProvider.recentsEnabled {
            let recentStickers = recentStickersManager.getRecentStickers()
            
            stickerCategories.insert(StickerCategory(stickers: recentStickers, icon: recentCategoryIcon, iconResourceType: recentCategoryResourceType), at: 0)
        }
        
        collectionView.setAllCategories(categories: stickerCategories)
        collectionView.stickerProviderDelegate = stickerProvider.stickerDelegate
        
        
        categoriesView.stickerProviderDelegate = stickerProvider.stickerDelegate
        categoriesView.categories = stickerCategories
        
        
        
        
        

    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }



    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()

    }




    private func setupViews() {
        setupStickersCategories()
        setupCollectionView()
    }

    private func setupStickersCategories() {
        self.addSubview(categoriesView)

        categoriesView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        categoriesView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        categoriesView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        categoriesView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        

        categoriesView.delegate = self

    }

    private func setupCollectionView() {

        addSubview(collectionView)

        collectionView.topAnchor.constraint(equalTo: categoriesView.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        collectionView.delegate = self
        collectionView.stickerDelegate = self


    }



}


extension KBStickerView: StickerCategoriesDelegate {
    internal func didSelectCategory(indexPath: IndexPath, category: StickerCategory) {
        
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
  
        didChangePage(indexPath: indexPath, category: category)
    }

    private func didChangePage(indexPath:IndexPath,category:StickerCategory){
        stickerProvider?.stickerDelegate.didChangePage(category: category)
        
        if stickerProvider?.recentsEnabled ?? false && indexPath.item == 0  {
            collectionView.reloadRecentsSection()
        }
        
    }

}

extension KBStickerView: StickersCollectionViewDelegate {
    internal func didSwipePage(at indexPath: IndexPath,category:StickerCategory) {
        categoriesView.selectCategory(at: indexPath)
    }
}

extension KBStickerView: StickerDelegate {
    internal func didClickSticker(sticker: Sticker) {

        let isFromRecents:Bool
        if let indexPath = collectionView.visibleCurrentCellIndexPath, indexPath.item == 0{
            isFromRecents = true
        }else{
            isFromRecents = false
        }

        

        if !isFromRecents && stickerProvider!.recentsEnabled {
            let stickers = collectionView.categories?[0].stickers
            
            if !(stickers?.contains(where: {$0.data == sticker.data}) ?? false){
                collectionView.insertStickerAtCategoryIndex(sticker: sticker, categoryIndex: 0, stickerIndex: 0)
                recentStickersManager.saveSticker(sticker: sticker)
            }
        }
        
    
        
        stickerProvider?.stickerDelegate.didClickSticker(sticker: sticker)
    }

}
