//
//  ViewController.swift
//  KBStickerView
//
//  Created by 3llomi on 03/13/2021.
//  Copyright (c) 2021 3llomi. All rights reserved.
//

import UIKit
import KBStickerView

class ViewController: UIViewController { 
    private var textView: UITextView!
    private var btnSwitch: UIButton!
    private var kbstickerView: KBStickerView!
    private var tableView: UITableView!



    private var isKeyboardType = true {
        didSet {
            if isKeyboardType {
                btnSwitch.setImage(#imageLiteral(resourceName: "ic_sticker"), for: .normal)
                textView.inputView = nil
                textView.reloadInputViews()
            } else {
                btnSwitch.setImage(#imageLiteral(resourceName: "ic_keyboard"), for: .normal)
                textView.inputView = kbstickerView
                textView.reloadInputViews()
            }
        }
    }


    private var dataSource = [Sticker]()

    fileprivate func setupViews() {


        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))


        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.register(StickerCell.self, forCellReuseIdentifier: "stickerCell")
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self


        textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)
        textView.backgroundColor = .lightGray



        btnSwitch = UIButton()
        btnSwitch.translatesAutoresizingMaskIntoConstraints = false
        btnSwitch.setImage(#imageLiteral(resourceName: "ic_sticker"), for: .normal)
        btnSwitch.addTarget(self, action: #selector(btnSwitchTapped), for: .touchUpInside)
        view.addSubview(btnSwitch)


        btnSwitch.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30).isActive = true
        btnSwitch.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24).isActive = true

        textView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        textView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: btnSwitch.leadingAnchor, constant: 24).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 60).isActive = true

        tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 32).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.textView.topAnchor, constant: 32).isActive = true



        kbstickerView = KBStickerView()
        kbstickerView.translatesAutoresizingMaskIntoConstraints = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

//        kbstickerView.categoriesViewBackground = .red
//        kbstickerView.selectedCategoryIconBackground = .brown
//        kbstickerView.categoryIconColorActive = .blue
//        kbstickerView.categoryIconColorNotActive = .black
//        kbstickerView.categoryIconSize = CGSize(width: 30, height: 30)
//        kbstickerView.recentCategoryIcon = "ic_recent"
//        kbstickerView.recentCategoryResourceType = .assets
//
//        kbstickerView.stickerItemSize = CGSize(width: 100, height: 100)
//        kbstickerView.stickerPageBackground = .black
//






        kbstickerView.stickerProvider = initStickers()





    }

    @objc private func btnSwitchTapped() {
        isKeyboardType = !isKeyboardType
    }

    private func getStickersFromBundle() -> [Sticker] {
        let fileManager = FileManager.default
        let bundleURL = Bundle.main.bundleURL
        let assetURL = bundleURL.appendingPathComponent("stickers.bundle")

        do {
            let contents = try fileManager.contentsOfDirectory(at: assetURL, includingPropertiesForKeys: [URLResourceKey.nameKey, URLResourceKey.isDirectoryKey], options: .skipsHiddenFiles)

            return contents.map { (url) -> Sticker in
                Sticker(data: url.path, resourceType: .assets)
            }
        }
        catch let error as NSError {
            return []
        }
    }
    private func initStickers() -> StickerProvider {

        let sitckerPack1: [Sticker] = [
            Sticker(data: "ic_recent", resourceType: .assets),
            Sticker(data: "ic_sticker", resourceType: .assets)
        ]

        let stickerCategories: [StickerCategory] = [


            StickerCategory(stickers: sitckerPack1, icon: "ic_sticker", iconResourceType: .assets),
            StickerCategory(stickers: getStickersFromBundle(), icon: "ic_sticker", iconResourceType: .assets),
            StickerCategory(stickers: getStickersFromBundle(), icon: "ic_sticker", iconResourceType: .assets),
            StickerCategory(stickers: getStickersFromBundle(), icon: "ic_sticker", iconResourceType: .assets),
            StickerCategory(stickers: getStickersFromBundle(), icon: "ic_sticker", iconResourceType: .assets),

        ]


        let stickerProvider = StickerProvider(stickerCategories: stickerCategories, stickerDelegate: self, recentsEnabled: true)

        return stickerProvider
    }

    @objc private func viewTapped() {
        view.becomeFirstResponder()
        textView.resignFirstResponder()
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {

            let keyboardRectangle = keyboardFrame.cgRectValue

//            self.view.frame.origin.y = -keyboardRectangle.height

        }
    }

    @objc private func keyboardWillHide() {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }


    override func viewDidAppear(_ animated: Bool) {

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)

    }


}

extension ViewController: StickerProviderDelegate {

    func didClickSticker(sticker: Sticker) {
        dataSource.append(sticker)
        tableView.reloadData()
    }

    func didChangePage(category: StickerCategory) {

    }

    func willLoadSticker(imageView: UIImageView, sticker: Sticker) {

        if sticker.resourceType == .assets {
            let stickerData = sticker.data
            let stickerImage = UIImage(named: stickerData)
            imageView.image = stickerImage
        }
    }

    func willLoadStickerCategory(imageView: UIImageView, stickerCategory: StickerCategory, selected: Bool) {
        if stickerCategory.iconResourceType == .assets {
            let icon = stickerCategory.icon
            imageView.image = UIImage(named: icon)
        }
    }






}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "stickerCell") as? StickerCell {
            let sticker = dataSource[indexPath.row]
            cell.setSticker(sticker)
            return cell
        }

        return UITableViewCell()
    }



}
