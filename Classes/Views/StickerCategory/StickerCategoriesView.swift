//
//  StickerCategoriesView.swift
//  KBSticker
//
//  Created by Devlomi on 3/8/21.
//

import UIKit

class StickerCategoriesView: UIView {

    private let categoryCellIdentifier = "CategroyCell"
    
    internal weak var delegate:StickerCategoriesDelegate?=nil
    internal weak var stickerProviderDelegate:StickerProviderDelegate?=nil
    
    var categoryIconSize = CategoryIconSize{
        didSet{
            collectionView.reloadData()
        }
    }
    
    var categoriesViewBackground = CategoriesViewBackground{
        didSet{
            collectionView.backgroundColor = categoriesViewBackground
        }
    }
    
    var categoryColorActive = CategoryColorActive{
        didSet{
            collectionView.reloadData()
        }
    }
    
    var categoryColorNotActive = CategoryColorNotActive{
        didSet{
            collectionView.reloadData()
        }
    }
    
    var selectedCategoryBackground = SelectedCategoryBackground{
        didSet{
            collectionView.reloadData()
        }
    }

    
    private lazy var collectionView:UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: .init())
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    var categories:[StickerCategory]?{
        didSet{
            collectionView.reloadData()
            collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews(){
        setupCollectionView()
    }
    
    
    private func setupCollectionView(){
        addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        collectionView.collectionViewLayout = flowLayout
        
        
        collectionView.backgroundColor = categoriesViewBackground
        
        
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: categoryCellIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    internal func selectCategory(at indexPath:IndexPath){
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        delegate?.didSelectCategory(indexPath: indexPath, category: categories![indexPath.item])
    }
    
}

extension StickerCategoriesView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let categories = categories, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellIdentifier, for: indexPath) as? CategoryCell{
            
            let category = categories[indexPath.item]
            cell.categoryColorActive = categoryColorActive
            cell.categoryColorNotActive = categoryColorNotActive
            cell.selectedCategoryBackground = selectedCategoryBackground
            cell.stickerProviderDelegate = stickerProviderDelegate
            cell.setStickerImage(category)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectCategory(indexPath: indexPath,category: categories![indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return categoryIconSize
    }
}

internal protocol StickerCategoriesDelegate:class {
    func didSelectCategory(indexPath:IndexPath,category:StickerCategory)
}
