//
//  StickerCell.swift
//  KBSticker
//
//  Created by Devlomi on 3/7/21.
//

import UIKit
class StickerPageCell: UICollectionViewCell {
    private let stickerCellIdentifier = "StickerPageCell"

    var stickers: [Sticker]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var stickerItemSize = StickerItemSize{
        didSet{
            collectionView.reloadData()
        }
    }
    


    weak var delegate: StickerDelegate? = nil
    weak var stickerProviderDelegate: StickerProviderDelegate? = nil

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        return cv
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
        addSubview(collectionView)

        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

        collectionView.register(StickerCell.self, forCellWithReuseIdentifier: stickerCellIdentifier)
        collectionView.backgroundColor = .clear
    }


    internal func reloadCellItem(indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }


}

extension StickerPageCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return stickers?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let stickers = stickers, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: stickerCellIdentifier, for: indexPath) as? StickerCell {
            let sticker = stickers[indexPath.item]
            cell.delegate = stickerProviderDelegate
            cell.setSticker(sticker: sticker)
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didClickSticker(sticker: stickers![indexPath.item])
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return stickerItemSize
    }
    

}

internal protocol StickerDelegate: class {
    func didClickSticker(sticker: Sticker)
}
