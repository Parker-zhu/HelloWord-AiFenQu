//
//  MainShopTableViewCell.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/8.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit

enum TitleType {
    case line,cicrl,arrows
}

class MainShopTableViewCell: UITableViewCell {
    
    lazy var headerLable = { () -> UILabel in
        let lable = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: bgCView.height))
        lable.font = UIFont.systemFont(ofSize: 12)
        lable.textAlignment = .center
        bgCView.addSubview(lable)
        lable.backgroundColor = UIColor.white
        return lable
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
    }

    var didSelectItem: ((Any) -> ())?
    ///cell的偏移
    var offSet = CGFloat(5)
    
    lazy var bgCView = { () -> UIView in
        let v = UIView.init(frame: self.bounds)
        v.y = offSet
        v.height = self.height - offSet
        v.backgroundColor = UIColor.white
        self.contentView.addSubview(v)
//        self.backgroundColor = UIColor.clear
        return v
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    ///滚动方向
    var dirction: UICollectionViewScrollDirection = .horizontal {
        didSet{
            if dirction == .vertical {
                cellWidth = SCREEN_Width/2 
            }
            
            collectionView.reloadData()
        }
    }
    ///collectioncell的宽度
    var cellWidth = SCREEN_Width/5*2
    ///cell的高度
    var cellHeight: CGFloat!
    
    let selfHeight = CGFloat(250)
    
    lazy var collectionView = { () -> UICollectionView in
        
        let layout = UICollectionViewFlowLayout.init()
        
        layout.scrollDirection = dirction
        layout.itemSize = CGSize.init(width: cellWidth, height: selfHeight - 30 - offSet)
        
        let c = UICollectionView.init(frame: CGRect.init(x: 0, y: bgCView.height + 1, width: SCREEN_Width, height: cellHeight), collectionViewLayout: layout)
        c.isScrollEnabled = dirction != .vertical
        c.backgroundColor = UIColor.white
        c.register(ShopCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        c.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        c.dataSource = self
        c.delegate = self
        c.showsVerticalScrollIndicator = false
        c.showsHorizontalScrollIndicator = false
        self.contentView.addSubview(c)
        return c
    }()
    
    ///设置数据
    func setModel(model:[Any],title:(String,TitleType),scrollDirection:UICollectionViewScrollDirection,selectModel:@escaping (Any)->()) {
        if title.0.contains("品牌") {
            cellHeight = 150
        } else {
            
        }
        didSelectItem = selectModel
        bgCView.backgroundColor = UIColor.white
        headerLable.text = title.0
        headerLable.textColor = UIColor.white
        
        headerLable.drawCircle(lineColor: UIColor.red, backColor: UIColor.clear, isDrawArrows: true)
        
        if scrollDirection == .vertical {
            cellHeight = (selfHeight - 30 - offSet) * 5 + 30 + offSet + 60
        } else {
//            if title.0.contains("品牌") {
//                cellHeight =
//            } else {
            cellHeight = selfHeight - 30 - offSet
//            }
        }
        
        dirction = scrollDirection
        
    }
    
    
}

extension MainShopTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ShopCollectionViewCell
        cell.setModel(model: "")
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if didSelectItem != nil {
            didSelectItem!("aaa")
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath)
        footerView.backgroundColor = xlightGray
        if footerView.subviews.last is UIButton {
            
        } else {
        let btn = IButton.init(frame:CGRect.init(x: 0, y: 2, width: SCREEN_Width, height: 40))
        btn.titleLable.text = "查看更多"
        btn.imageView.image = UIImage.init(named: "path")
        btn.backgroundColor = UIColor.white
        btn.titleLable.font = UIFont.systemFont(ofSize: 12)
        btn.positionType = .wl_c_ir
        footerView.addSubview(btn)
        }
        return footerView
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if self.dirction == .vertical {
            return CGSize.init(width: SCREEN_Width, height: 60)
        } else {
            return CGSize.init(width: 0, height: 0)
        }
        
    }
    
}

