//
//  StickerCollectionView.swift
//  KBSticker
//
//  Created by Devlomi on 3/6/21.
//

import Foundation
import UIKit

class StickerCollectionView: UIView {
    private let stickerPageCellReuseIdentifier = "StickerPageCell"

    private (set)
    var categories: [StickerCategory]?
    
    
    func setAllCategories(categories:[StickerCategory]){
        self.categories = categories
        collectionView.reloadData()
    }
    
    
    var stickerPageBackground = StickerPageBackground{
        didSet{
            collectionView.backgroundColor = stickerPageBackground
        }
    }

    
    var stickerItemSize = StickerItemSize{
        didSet{
            collectionView.reloadData()
        }
    }
    
    


    internal func insertStickerAtCategoryIndex(sticker:Sticker, categoryIndex:Int, stickerIndex:Int) {
        categories?[categoryIndex].stickers.insert(sticker, at: stickerIndex)
    }
    

    var visibleCurrentCellIndexPath: IndexPath? {
        for cell in self.collectionView.visibleCells {
            let indexPath = self.collectionView.indexPath(for: cell)
            return indexPath
         }
            
         return nil
    }


    internal weak var delegate: StickersCollectionViewDelegate? = nil
    internal weak var stickerDelegate: StickerDelegate? = nil
    internal weak var stickerProviderDelegate: StickerProviderDelegate? = nil

    private var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        return flowLayout
    }()

    private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()



    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    internal func selectItem(at indexPath: IndexPath, animated: Bool, scrollPosition: UICollectionView.ScrollPosition) {
        collectionView.selectItem(at: indexPath, animated: animated, scrollPosition: scrollPosition)
    }
    

    internal func relaodData(){
        collectionView.reloadData()
    }

    func reloadRecentsSection(){
        collectionView.reloadItems(at: [IndexPath(item: 0, section: 0)])
    }
    
    private func setupViews() {

        addSubview(collectionView)

        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        collectionView.collectionViewLayout = flowLayout
        collectionView.isPagingEnabled = true

        collectionView.register(StickerPageCell.self, forCellWithReuseIdentifier: stickerPageCellReuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.backgroundColor = stickerPageBackground
        
   

    }


}
extension StickerCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: stickerPageCellReuseIdentifier, for: indexPath) as? StickerPageCell {
            let stickersForSection = categories![indexPath.item].stickers
            cell.stickerItemSize = stickerItemSize
            cell.stickers = stickersForSection
            cell.delegate = stickerDelegate
            cell.stickerProviderDelegate = stickerProviderDelegate
            return cell
        }

        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: self.frame.height)
    }



    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x / self.frame.width)
        let indexPath = IndexPath(item: index, section: 0)
        if let category = categories?[index]{
            delegate?.didSwipePage(at: indexPath,category: category)
        }
        


    }



}
protocol StickersCollectionViewDelegate: class {
    func didSwipePage(at indexPath: IndexPath,category:StickerCategory)
}

