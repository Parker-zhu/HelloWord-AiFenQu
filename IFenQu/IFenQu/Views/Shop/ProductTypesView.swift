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
        layout.scrollDirection = .vertical
        let collection = UICollectionView.init(frame: CGRect.init(x: 20, y: 101, width: self.width - 40, height: self.height - 161), collectionViewLayout: layout)
        
        collection.delegate = self
        collection.dataSource = self
        collection.register(ProductTypeItemCellCell.self, forCellWithReuseIdentifier: "cell")
        collection.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        collection.backgroundColor = UIColor.white
        return collection
    }()
    lazy var sureBtn: UIButton = {
        let btn = UIButton.init(frame: CGRect.init(x: 0, y: self.height - 60, width: SCREEN_Width, height: 60))
        btn.shadeColor()
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitle("立即购买", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.block = {
            PopView.disMiss()
        }
        
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = xlightGray
        
        self.addSubview(contentCollection)
        self.addSubview(sureBtn)
        headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: 100))
        self.addSubview(headerView)
        
        let imageView = UIImageView.init(frame: CGRect.init(x: 20, y: -10, width: headerView.height, height: headerView.height))
        imageView.image = UIImage.init(named: "pic00")
        headerView.addSubview(imageView)
        
        let lable1 = UILabel.init(frame: CGRect.init(x: imageView.frame.maxX + 20, y: 10, width: SCREEN_Width - 100, height: 30))
        lable1.text = "¥9088.00-¥10999.90"
        lable1.textColor = UIColor.black
        headerView.addSubview(lable1)
        
        let lable2 = UILabel.init(frame: CGRect.init(x: imageView.frame.maxX + 20, y: lable1.frame.maxY, width: SCREEN_Width - 100, height: 30))
        lable2.text = "每期¥1999.00起"
        lable2.textColor = UIColor.black
        headerView.addSubview(lable2)
    }
    
    var data = ["银色","银色银色","银色银银色","银色","银色银色","银色银银色"]
    
    
    func setModel(model:Any) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

}

extension ProductTypesView: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductTypeItemCellCell
        cell.setModel(title: data[indexPath.row])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: SCREEN_Width, height: 30)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let v = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
        if (v.subviews.last is UILabel) {
            let lable = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 100, height:30))
            lable.text = "颜色"
            v.addSubview(lable)
        }
        
        return v
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: data[indexPath.row].getTextSize(font: 12).width + 20, height: 30)
    }
}
