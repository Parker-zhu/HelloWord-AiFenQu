//
//  ProductTypesView.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/13.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit

class ProductTypesView: UIView {

    var headerView: UIView!
    
    lazy var contentCollection = { () -> UICollectionView in
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: self.width, height: self.height - 60), collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(ProductTypeItemCellCell.self, forCellWithReuseIdentifier: "cell")
        collection.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        return collection
    }()
    lazy var sureBtn: UIButton = {
        let btn = UIButton.init(frame: CGRect.init(x: 0, y: self.height - 60, width: SCREEN_Width, height: 60))
        btn.backgroundColor = UIColor.brown
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitle("确定", for: .normal)
        btn.block = {
            PopView.disMiss()
        }
        self.addSubview(btn)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sureBtn.backgroundColor = UIColor.brown
        self.addSubview(contentCollection)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

}

extension ProductTypesView: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: SCREEN_Width, height: 60)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let v = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
        let lable = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 60))
        lable.text = "颜色"
        v.addSubview(lable)
        return v
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
