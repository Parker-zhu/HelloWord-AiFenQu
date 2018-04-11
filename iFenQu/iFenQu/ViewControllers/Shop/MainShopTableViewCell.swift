//
//  MainShopTableViewCell.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/8.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit

class MainShopTableViewCell: UITableViewCell {

    ///为nil就没有
    var cellHeaderText: String? {
        didSet{
            headerLable.width = headerLable.getLableWidth(size: CGSize.init(width: 900, height: 30))
            headerLable.center = headerLable.superview!.center
        }
    }
    lazy var headerLable = { () -> UILabel in
        let bgView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: 30))
        self.contentView.addSubview(bgView)
        let lable = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: 20))
        lable.shopLable(text: "商品详情", textColor: UIColor.red, textBackColor: UIColor.white, textFont: 10, lineColor: UIColor.red, lineType: .circle, priceText: nil, priceColor: nil, isChangeSize: nil, priceFont: nil)
        lable.textAlignment = .center
        bgView.addSubview(lable)
        lable.center = bgView.center
        return lable
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.separatorInset = UIEdgeInsets.init(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    ///初始化collectionView
    private func initCollectionView(){
        
    }
    var dirction: Bool = false {
        didSet{
            if !dirction {
                
                cellWidth = SCREEN_Width/2 - 10
                cellHeight = 10/2 * 200 + 50
            }
            
            collectionView.reloadData()
        }
    }
    var cellWidth = SCREEN_Width/5*2
    
    var cellHeight = CGFloat(250) {
        didSet{
            
        }
    }
    
    lazy var collectionView = { () -> UICollectionView in
        let layout = UICollectionViewFlowLayout.init()
        if dirction {
            layout.scrollDirection = .horizontal
        } else {
            layout.scrollDirection = .vertical
        }
//        layout.minimumLineSpacing = 0
//        layout.minimumInteritemSpacing = 0
        
        layout.itemSize = CGSize.init(width: cellWidth, height: 200)
        let c = UICollectionView.init(frame: CGRect.init(x: 0, y: 30, width: SCREEN_Width, height: cellHeight - 50), collectionViewLayout: layout)
        c.isScrollEnabled = dirction
        c.backgroundColor = UIColor.white
        c.register(ShopCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        c.dataSource = self
        c.delegate = self
        c.showsVerticalScrollIndicator = false
        c.showsHorizontalScrollIndicator = false
        self.contentView.addSubview(c)
        return c
    }()
    ///初始化collectionView
    private func initHeaderLable(){
        
        
    }
    ///初始化collectionView
    private func initHeaderImageView(){
        
        
    }
    ///设置数据
    func setModel(model:Any) {
//        collectionView.reloadData()
    }
    
    

}

extension MainShopTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize.init(width: SCREEN_Width/5*2, height: 200)
//    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

